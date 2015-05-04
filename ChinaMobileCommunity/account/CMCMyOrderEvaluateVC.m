//
//  CMCMyOrderEvaluateVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderEvaluateVC.h"
#import "StarView.h"
#import "CommentStarView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GTMBase64.h"


@interface CMCMyOrderEvaluateVC ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    TPKeyboardAvoidingScrollView *backView;
    UITextView *textView;
    StarView *star;
    
}
@property (nonatomic,strong)NSMutableArray *filePathArr;//图片地址数组
@property (nonatomic,strong)NSMutableArray *imgNameArr;//图片地址数组

@property (nonatomic,assign)int warngNum;//点击的是哪个按钮
@property (nonatomic,strong)NSString *starNum;//评分

@end

@implementation CMCMyOrderEvaluateVC
- (NSMutableArray *)filePathArr{
    if (_filePathArr == nil) {
        self.filePathArr = [NSMutableArray array];
    }
    return _filePathArr;
}

- (NSMutableArray *)imgNameArr{
    if (_imgNameArr == nil) {
        self.imgNameArr = [NSMutableArray array];
    }
    return _imgNameArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服务评价";
    backView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:backView];
    star = [[StarView alloc] initWithFrame:CGRectMake(30, 20, 150, 30)];
    
    __weak typeof(self) wself = self;
    [star setButtonBlock:^(NSInteger number) {
        
        wself.starNum = [NSString stringWithFormat:@"%d",number];
        
    }];
    
    star.backgroundColor = k_color(@"ffffff");
    [backView addSubview:star];
    
    UILabel *evaluaLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 30)];
    evaluaLabel.text = @"评价";
    evaluaLabel.textColor = k_color(@"373737");
    evaluaLabel.font = k_font(14.0);
    [backView addSubview:evaluaLabel];

    textView = [[UITextView alloc] initWithFrame:CGRectMake(20, star.bottom + 20, self.view.frame.size.width - 40, 150)];
    textView.delegate = self;
    textView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [backView addSubview:textView];
    
    for (int i = 0; i < 3; i++) {
        UIButton *imageBtt = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtt.frame = CGRectMake(20 + (66 + 10) * i, textView.bottom + 15, 66, 66);
        imageBtt.tag = 7000 + i;
        [imageBtt setBackgroundImage:[UIImage imageNamed:@"meishijia"] forState:UIControlStateNormal];
        [imageBtt addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:imageBtt];
    }
    
    UIButton *sumbitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sumbitBtn.frame = CGRectMake(10, self.view.frame.size.height - 120, self.view.frame.size.width - 20, 40);
    sumbitBtn.layer.cornerRadius = 5;
    [sumbitBtn setTitle:@"提交" forState:UIControlStateNormal];
    sumbitBtn.backgroundColor = kAPI_AllMainColor;
    [sumbitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitBtn addTarget:self action:@selector(sumbitAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sumbitBtn];
}


- (void)selectImage:(UIButton *)sender{
    _warngNum = (int)sender.tag;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)sumbitAction:(UIButton *)sender{
    NSLog(@"filePaht ===== %@",self.filePathArr);
    NSLog(@"fileName ===== %@",self.imgNameArr);
    
    NSLog(@"提交");
    NSString *nickname;
    if (![CMCUserManager shareManager].nickname) {
        nickname = @"";
    }else{
        nickname = [CMCUserManager shareManager].nickname;
    }
    
    if (!self.starNum) {
        [BaseUtil toast:@"请打分"];
        return;
    }
    
    if (textView.text.length == 0) {
        [BaseUtil toast:@"请对服务进行评价"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //0317
    NSString *timestmap = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"mid":self.mid,@"order_id":self.order_id,@"nickname":k_phone,@"star":self.starNum,@"content":textView.text,@"timestamp":timestmap};
    NSString *sig = KAPI_GetSig(dic);
    NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"mid":self.mid,@"order_id":self.order_id,@"nickname":k_phone,@"star":self.starNum,@"content":textView.text,@"timestamp":timestmap,@"sig":sig};
    NSString *url = KAPI_OrdereValute;
    NSLog(@"000000000 == %@",url);
    [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
        NSLog(@"---------- %@",responseObj);
        
        [BaseUtil pushToLoginVCWithRespondObj:responseObj withViewController:self];
        [BaseUtil errorMesssage:responseObj];
        
        if ([[[[responseObj objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"0"]) {
            NSString *evilt_id = [responseObj objectForKey:@"data"];//字段不明，暂时写成id，要记得验证
            
            //如果有图片，进行图片上传
            if (self.filePathArr.count != 0) {
                
                [self postImageWithEvaluate_id:evilt_id];
                
            }else{
                //
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
                [BaseUtil toast:@"评价成功"];
                
            }
        }
    } ailure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [BaseUtil toast:@"评价失败"];
    }];
    
    
    
    
    
    
}



- (void)postImageWithEvaluate_id:(NSString *)evlt_id{
    
    
    
    for (int i = 0; i < self.filePathArr.count; i++) {
        //把图片base64
        UIImage *image = [UIImage imageWithContentsOfFile:self.filePathArr[i]];
        NSData *data = UIImageJPEGRepresentation(image, 0);//UIImageJPEGRepresentation返回图片较小，但是清晰度模糊
        data = [GTMBase64 encodeData:data];//base64加密
        NSString *imgStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        //文件名base64
        NSData *data1 = [self.imgNameArr[i] dataUsingEncoding:NSUTF8StringEncoding];
        data1 = [GTMBase64 encodeData:data1];
        NSString *imageName = [[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
        
        //上传图片
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"id":evlt_id,@"image_name":imageName,@"timestamp":timestamp};
        NSString *sig = KAPI_GetSig(dic);
        NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"id":evlt_id,@"image_name":imageName,@"upimage":imgStr,@"timestamp":timestamp,@"sig":sig,@"upimage":imgStr};
        
        NSString *url = KAPI_OrdereValuteImage;
        
        [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
            NSLog(@"respondObject ======= %@",responseObj);

            if ([[[[responseObj objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
                if (i == self.filePathArr.count - 1) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    [BaseUtil toast:@"评价成功"];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } ailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"图片上传失败"];
        }];
        
        
    }
    
    
    
    
    
    
    
    
    
}


#pragma mark - pickerImageController -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *tmpImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *image = [BaseUtil scaleToSize:tmpImg WithNumber:4];
    
    UIButton *butt = (UIButton *)[backView viewWithTag:_warngNum];
    [butt setImage:image forState:UIControlStateNormal];
    
    //保存路径
    NSURL *sourceURL = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSString *docement = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docement stringByAppendingPathComponent:sourceURL.query];
    
    [self.filePathArr addObject:filePath];//把路径保存起来
    
    
    
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        [self.imgNameArr addObject:fileName];
        NSLog(@"fileName : %@",fileName);
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
    [assetslibrary assetForURL:sourceURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    //最后一张图片的时候不再增加个数，最多6张
//    if (_dataArr.count == 6) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
//        UICollectionViewCell *cell = [_myCollecView cellForItemAtIndexPath:indexPath];
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.frame = CGRectMake(0, 0, cell.width, cell.height);
//        imageView.backgroundColor = [UIColor redColor];
//        imageView.userInteractionEnabled = YES;
//        NSString *filePath = _dataArr[indexPath.row];
//        imageView.image = [UIImage imageWithContentsOfFile:filePath];
//        [cell.contentView addSubview:imageView];
//    }else{
//        [_myCollecView reloadData];
//    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark end
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*                                                       
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
