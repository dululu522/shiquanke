//
//  CMCRepairVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//
#define HeadImgName @"hea.png"
#import "CMCRepairVC.h"
#import "Base64Encoder.h"

#import "CMCResidentialAddressTVC.h"
#import "CMCRepairComplaintsView.h"
#import "CMCCommunityTypeTableVC.h"

#import <AssetsLibrary/AssetsLibrary.h>
@interface CMCRepairVC ()
{
    UITextField *_mapLabelTextField;
    UITextView *_contentView;
    UILabel *_contentLabel;
    UILabel *_label;
    CMCRepairComplaintsView *_repairComplaintView;
    UIButton *_photoBtn;
    NSInteger _numberTag;
}
@property (nonatomic, strong) NSMutableArray *imageNameArr;
@property (nonatomic, strong) UIImage *aImage;
@end

@implementation CMCRepairVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatRepairComplaintView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageNameArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [self creatNavigationBackButton];
    //    //图片
    [self creatUploadPictures];
}


//创建上传图片按钮
- (void)creatUploadPictures
{
    UIView *btnView = [[UIView alloc] init];
//    if ([self.title isEqualToString:@"投诉记录"] | [self.title isEqualToString:@"报修记录"]) {
//        btnView.backgroundColor = [UIColor whiteColor];
//        btnView.frame = CGRectMake(0, 235, self.view.frame.size.width, 120);
//        [self.view addSubview:btnView];
//        
//        UILabel *cotentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, self.view.frame.size.width - 10, 20)];
//        cotentLabel.font = [UIFont systemFontOfSize:13.0];
//        //        cotentLabel.text = @"漏水特别严重";
//        [btnView addSubview:cotentLabel];
//        
//        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 90, self.view.frame.size.width - 10, 20)];
//        //        timeLabel.text = @"2015-04-01 11:27";
//        timeLabel.font = [UIFont systemFontOfSize:13.0];
//        timeLabel.textAlignment = NSTextAlignmentRight;
//        [btnView addSubview:timeLabel];
//        
//        //物业回复
//        
//        UIView *reviewView = [[UIView alloc] initWithFrame:CGRectMake(0, btnView.bottom + 10, self.view.frame.size.width, 106)];
//        [self.view addSubview:reviewView];
//        reviewView.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *reviewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.self.width - 20, 25)];
//        //        reviewLabel.text = @"物业回复";
//        [reviewView addSubview:reviewLabel];
//        
//        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, self.view.self.width - 20, 25)];
//        //        aLabel.text = @"马上修";
//        [reviewView addSubview:aLabel];
//        
//        
//        
//        
//    } else {
        btnView.backgroundColor = [UIColor whiteColor];
        btnView.frame = CGRectMake(0, 235, self.view.frame.size.width, 85);
        [self.view addSubview:btnView];
    
        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 330, 120, 40)];
        
        [submitButton addTarget:self action:@selector(didClickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:submitButton];
    
//    }
    for (int i = 0; i < 3; i++) {
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.userInteractionEnabled = YES;
        photoButton.frame = CGRectMake(i*60 + 5*i + 5, 245, 60, 60);
//         photoButton.frame = CGRectMake(10, 245, 60, 60);
//        if ([self.title isEqualToString:@"投诉记录"] | [self.title isEqualToString:@"报修记录"]) {
//            photoButton.userInteractionEnabled = NO;
//        }else {
//            [photoButton addTarget:self action:@selector(didClickPhotoButton:) forControlEvents:UIControlEventTouchUpInside];
//        }
        [photoButton addTarget:self action:@selector(didClickPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"qiu test");
        
        photoButton.tag = 3000 +i;
        [photoButton setBackgroundImage:[UIImage imageNamed:@"照相机"] forState:UIControlStateNormal];
        [self.view addSubview:photoButton];
    }
    
    
    
    
}
- (void)didClickSubmitButton:(UIButton *)button
{
    
    NSLog(@"_contentView.text %@",_contentView.text);
    //    if ([CMCUserManager shareManager].communityType.length){
    NSString *genre = nil;
    if ([CMCUserManager shareManager].communityType) {
        genre = [CMCUserManager shareManager].communityType;
    } else {
        genre = @"环境";
        
    }
    
    
    
    NSLog(@"[CMCUserManager shareManager].communityType ========%@",[CMCUserManager shareManager].communityType);
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":self.zid,@"type":self.type,@"genre":genre,@"content":@"赶快修理",@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSLog(@"修理sig %@",sig);
    NSString *requestUrl = KAPI_propertyComplain([CMCUserManager shareManager].token, self.zid, self.type,genre, @"赶快修理", timestamp,[BaseUtil md5:sig]);
    NSLog(@"赶快修理 requestUrl ============%@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"投诉报修 %@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                [BaseUtil toast:@"提交成功"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self loadUploadImageData:[respondObject objectForKey:@"data"]];
            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"提交失败,请重新提交"];
            }
        }else {
            [BaseUtil toast:@"提交失败,请重试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadUploadImageData:(NSString *)advice_id
{
    NSLog(@"self.imageNameArr %@",self.imageNameArr);
    for (int i = 0; i < self.imageNameArr.count; i++) {
        //把图片base64
        NSData *data = UIImageJPEGRepresentation(self.aImage, 0);
        NSString *imgStr = [Base64Encoder encodeData:data];
        NSData *data1 = [[self.imageNameArr objectAtIndex:i] dataUsingEncoding:NSUTF8StringEncoding];
        //        NSString *timestamp = kAPI_timestamp;
        NSString *imageName = [Base64Encoder encodeData:data1];
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"advice_id":advice_id,@"image_name":imageName,@"timestamp":kAPI_timestamp};
        NSLog(@"图片上传   %@",dic);
        NSString *sig= [BaseUtil getSigWithArray:dic];
        NSLog(@"测试数据   %@",sig);
        
        NSDictionary *postDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"advice_id":advice_id,@"image_name":imageName,@"upimage":imgStr,@"timestamp":kAPI_timestamp,@"sig":[BaseUtil md5:sig]};
        NSLog(@"qqqqqqqiu %@",postDic);
        [BaseUtil post:KAPI_AdviceImage postBody:postDic success:^(id responseObj) {
            NSLog(@"lastone %@",responseObj);
            NSDictionary *infoDic = [responseObj objectForKey:@"info"];
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                [BaseUtil toast:@"提交成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } ailure:^(NSError *error) {
        }];
    }
    
    
}
- (void)didClickPhotoBtn:(UIButton *)button
{
    NSLog(@"Aaaaaaaaa");
    NSLog(@"bbennnebbnnberbnnbebnn");
    _numberTag = button.tag;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取", nil];
    alertView.delegate = self;
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            NSLog(@"拍照");
            //拍照
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
                imagePickerC.sourceType = sourceType;
                imagePickerC.delegate = self;
                imagePickerC.allowsEditing = YES;
                [self presentViewController:imagePickerC animated:YES completion:nil];
            }
            else
            {
                [BaseUtil toast:@"您的手机没有照相机"];
            }
        }
            break;
        case 2:
        {
            NSLog(@"本地照片");
            //打开本地相册
            UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
            imagePickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePickerC.delegate = self;
            imagePickerC.allowsEditing = YES;
            [self presentViewController:imagePickerC animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark -
//#pragma mark - UIImagePickerControllerDelegate
#pragma mark - UIPickerControllerDelegate -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"info  %@",info);
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type =======%@",type);
    NSURL *sourceURL = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage])
    {
        //先把图片转成NSData
        self.aImage = [self scaleToSize:[info objectForKey:@"UIImagePickerControllerEditedImage"] size:CGSizeMake(60, 60)];
        //        UIImage* image =  [self scaleToSize:[info objectForKey:@"UIImagePickerControllerOriginalImage"] size:CGSizeMake(60, 60)];
        //        NSLog(@"image =======%@",image);
        [self performSelector:@selector(uploadUserHeadPicture:) withObject:self.aImage afterDelay:0.01];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        UIButton *pBtn = (UIButton *)[self.view viewWithTag:_numberTag];
        NSLog(@"pBtn %@",pBtn);
        [pBtn setImage:self.aImage forState:UIControlStateNormal];
    }
    //    __block ;
    __block NSString *imgName = nil;
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        imgName = [representation filename];
        
        [self.imageNameArr addObject:imgName];
        
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
    [assetslibrary assetForURL:sourceURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    
}
- (void)uploadUserHeadPicture:(UIImage *)image
{
    NSArray *dirPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString * docsDir = [dirPaths objectAtIndex:0];  //得到documen目录下
    
    NSData *imageData = UIImagePNGRepresentation(image); //将图片转化为png
    filePath = [NSString stringWithFormat:@"%@/%@",docsDir,HeadImgName];//图片文件完整的路径
    [_photoBtn setBackgroundImage:[UIImage imageNamed:HeadImgName] forState:UIControlStateNormal];
    [imageData writeToFile:filePath atomically:YES];//将图片写入到文件中去
    
    [self UploadThePicture];
    
}
- (void)UploadThePicture
{
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    NSLog(@"%@",image);
    NSData *data = UIImageJPEGRepresentation(image, 1.0);//UIImageJPEGRepresentation返回图片较小，但是清晰度模糊
    
    
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


- (void)creatRepairComplaintView
{
    _repairComplaintView = [[CMCRepairComplaintsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    [self.view addSubview:_repairComplaintView];
    _repairComplaintView.delegate = self;
    
    _repairComplaintView.type = self.type;
    _repairComplaintView.zid = self.zid;
    [_repairComplaintView creatViewMap:[CMCUserManager shareManager].address communityText:[CMCUserManager shareManager].residentialAddressStr typeText:[CMCUserManager shareManager].communityType];
    
}
- (void)returnSucessful
{
    [self.navigationController popViewControllerAnimated:YES];
}

//小区名称
- (void)didClickCommunity
{
    CMCResidentialAddressTVC *residentialAddressVC = [[CMCResidentialAddressTVC alloc] init];
    [self.navigationController pushViewController:residentialAddressVC animated:YES];
    
}
//小区类型
- (void)didClickType
{
    CMCCommunityTypeTableVC *communityTableVC = [[CMCCommunityTypeTableVC alloc] init];
    [self.navigationController pushViewController:communityTableVC animated:YES];
    
}

//小区地址
- (void)didClickcommunityButton:(UIButton *)button
{
    CMCResidentialAddressTVC *residentialAddressVC = [[CMCResidentialAddressTVC alloc] init];
    
    [self.navigationController pushViewController:residentialAddressVC animated:YES];
    
}
- (void)creatNavigationBackButton
{
    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    [billButton setBackgroundImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [billButton addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
}
#pragma mark-
#pragma mark- 返回按钮
- (void)didClickBackBtn:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //    [_contentView resignFirstResponder];
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (_contentView.text.length == 0) {
        _contentLabel.text = @"请描述投诉内容";
        
        
    } else{
        
        _contentLabel.text = @"";
    }
    _contentView.text = textView.text;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_mapLabelTextField resignFirstResponder];
    return YES;
    
}
- (void)didClickEditButton:(UIButton *)button
{
    _mapLabelTextField.userInteractionEnabled = YES;
    
    
}
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
