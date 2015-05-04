//
//  CMCComplaintDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCComplaintDetailVC.h"
#import "CMCComplaint.h"
#import "CMCComplaintRecordView.h"

@interface CMCComplaintDetailVC ()
{
    CMCComplaintRecordView *_repairComplaintView;
    UITextView *_contentView;
    UITextField *_mapLabelTextField;
    UILabel *_communityLabel;
    UILabel *_typeLabel;
    UILabel *_contentLabel;
    
    
}
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation CMCComplaintDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self creatRepairComplaintView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
    [self loadData];
    
}
- (void)loadData
{
    NSString *timestamp= kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"advice_id":self.advice_id,@"token":[CMCUserManager shareManager].token,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = KAPI_adviceinfo(self.advice_id, [CMCUserManager shareManager].token, timestamp, [BaseUtil md5:sig]);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"记录respondObject   %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] integerValue] == 0) {
            if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                CMCComplaint *complaint = [[CMCComplaint alloc] initWithComplaintDic:dataDic];
                _repairComplaintView.complaint = complaint;
                NSString *time = [BaseUtil becomeNormalWithString:[dataDic objectForKey:@"create_time"]];
                [self creatViewMap:[dataDic objectForKey:@"address"] communityText:@"" typeText:[dataDic objectForKey:@"genre"] contentLabel:[dataDic objectForKey:@"content"] time:time image:[dataDic objectForKey:@"image"] contentReplay:[dataDic objectForKey:@"reply_content"] reply_time:[dataDic objectForKey:@"reply_time"]];
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)creatViewMap:(NSString *)mapAddress communityText:(NSString *)communityText typeText:(NSString *)typeText contentLabel:(NSString *)content time:(NSString *)timeStr image:(NSString *)image contentReplay:(NSString *)contentReplay reply_time:(NSString *)reply_time
{
    UIView *mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    mapView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mapView];
    
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 10, 13)];
    mapImageView.image = [UIImage imageNamed:@"地_03"];
    [mapView addSubview:mapImageView];
    _mapLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(mapImageView.frame.size.width + mapImageView.frame.origin.x + 6, 5, 250, 30)];
    //    _mapLabelTextField.delegate = self;
    _mapLabelTextField.font = k_font(13.0);
    _mapLabelTextField.text = [CMCUserManager shareManager].currentAddress;
    _mapLabelTextField.userInteractionEnabled = NO;
    
    [mapView addSubview:_mapLabelTextField];
    //小区
    UIView *seconView = [[UIView alloc] initWithFrame:CGRectMake(0, mapView.frame.size.height + mapView.frame.origin.y + 15, self.view.bounds.size.width, 90)];
    seconView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seconView];
    
    UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, self.view.bounds.size.width - 20, 1)];
    middleImageView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    
    [seconView addSubview:middleImageView];
    
    _communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 100, 45)];
    _communityLabel.font = [UIFont systemFontOfSize:13.0];
//    _communityLabel.text = communityText;
    _communityLabel.text = [CMCUserManager shareManager].wuye_address;
    [seconView addSubview:_communityLabel];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 45, 10, 15, 15)];
//    searchImageView.image = [UIImage imageNamed:@"search"];
    [seconView addSubview:searchImageView];
    
    UIButton *communityButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)];
    communityButton.userInteractionEnabled = YES;

    [seconView addSubview:communityButton];
    
    //报修类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45 , self.view.bounds.size.width - 100, 45)];
    _typeLabel.text = typeText;
    _typeLabel.font = [UIFont systemFontOfSize:13.0];
    
    [seconView addSubview:_typeLabel];
    
    CGFloat height;
   
    //照片头像
    UIView *phoneImage;
    phoneImage = [[UIView alloc] init];
//    phoneImage.backgroundColor = [UIColor redColor];

    [seconView addSubview:phoneImage];
    if (![image isKindOfClass:[NSNull class]]) {

        phoneImage.frame = CGRectMake(0, _typeLabel.bottom + 15, self.view.bounds.size.width, 80);
        phoneImage.backgroundColor = [UIColor whiteColor];
        height = phoneImage.bottom + 15;
        NSArray *imageArr = [image componentsSeparatedByString:@","];
        for (int i = 0; i < imageArr.count; i++) {
            if (imageArr.count > 3) {
                break;
            }
            UIImageView *btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 80 * i, 10, 60, 60)];
            [phoneImage addSubview:btnImageView];
            NSURL *url = [BaseUtil systemRandomlyGenerated:[imageArr objectAtIndex:i] type:@"3" number:@"1"];
            [btnImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"照相机"]];
        }
        
    } else {
        height  = _typeLabel.bottom + 15;
    
    }
    
    
    
    
    //投诉内容
    
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, 60)];
    NSLog(@"^^^^^^^^^^%@",_contentView);
    _contentView.hidden = NO;
    _contentView.userInteractionEnabled = NO;
    _contentView.text = content;
    
    //    _contentView.backgroundColor = [UIColor orangeColor];
    [seconView addSubview:_contentView];
    
    
    
//    seconView.backgroundColor = [UIColor whiteColor];
    

    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, _contentView.bottom, self.view.frame.size.width, 20)];
    [seconView addSubview:timeView];
    timeView.backgroundColor = [UIColor whiteColor];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _contentView.bottom ,self.view.size.width - 20, 20)];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:13.0];
    
    timeLabel.text = timeStr;
    [seconView addSubview:timeLabel];
    

    
    if (![contentReplay isEqualToString:@""]) {
        UIView * replyView = [[UIView alloc] initWithFrame:CGRectMake(0, timeView.bottom + 5, self.view.frame.size.width, 100)];
        replyView.backgroundColor = [UIColor whiteColor];
        [seconView addSubview:replyView];
        UILabel *replayTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 15)];
        [replyView addSubview:replayTitleLabel];
        replayTitleLabel.text = @"物业回复:";
        replayTitleLabel.font = k_font(15);
        
        UILabel *contentRL = [[UILabel alloc] initWithFrame:CGRectMake(10, replayTitleLabel.bottom+5, self.view.frame.size.width - 20, 60)];
//        contentRL.text = @"aaaaaaaaaa";
        contentRL.font = k_font(13.0);
        [replyView addSubview:contentRL];
        contentRL.backgroundColor =[UIColor greenColor];
            contentRL.text = contentReplay;
        
        UILabel *replyTL = [[UILabel alloc] initWithFrame:CGRectMake(10, contentRL.bottom ,self.view.size.width - 20, 20)];
        replyTL.backgroundColor = [UIColor blueColor];
        replyTL.textAlignment = NSTextAlignmentRight;
        replyTL.font = [UIFont systemFontOfSize:13.0];
        replyTL.text = [BaseUtil becomeNormalWithString:reply_time];
        [replyView addSubview:replyTL];
    }

    
    
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
