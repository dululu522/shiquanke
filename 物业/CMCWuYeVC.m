//
//  CMCWuYeVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCWuYeVC.h"
#import "CMCWaterBillDetailVC.h"
#import "CMCNoticeVC.h"
#import "CMCRepairVC.h"
#import "CMCComplaintsVC.h"

#import "CMCEvaluationVC.h"
#import "ANBlurredImageView.h"
#import "CMCCommentsVC.h"

#import "CMCParkingViewController.h"

#import "CMCElectricityViewController.h"
#import "CMCManagementFeeVC.h"

#import "CMCGasFeeViewController.h"
#import "CMCOnlineBookingVC.h"
#import "CMCPayCostViewController.h"
#import "CMCMyScrollView.h"
#import "CMCCityListViewController.h"
#import "CMCIntroductionTableVC.h"
#import "CycleScrollView.h"
#import "CMCSwitchPropertyAddressTVC.h" //切换物业地址
#import "CMCQScrollView.h"
#import "CMCComplaintsRepairViewController.h"

@interface CMCWuYeVC ()
{

    UIView *_buttonView;
    NetWorkRequest *_request;
    UIScrollView *_backScrollView;
    UIButton *_middleButton;
    UILabel *_noticeLabel;
    NSString *wuye_id; //物业zid
    UILabel *_contentLabel;

    
}
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *payCostArr;
@property (nonatomic, strong)  UITableView *leftTableView;
@property (nonatomic, strong) UIView *sideView;
@property (nonatomic, strong) NSMutableArray *bannaImageArr;
//@property (nonatomic, strong) ANBlurredImageView *blurredImageView;
@property (nonatomic, strong) CMCQScrollView *mainScorllView;
@property (nonatomic, strong) UIPageControl* pageControl;
//@property (nonatomic ,strong) CycleScrollView* focusScorllView;
//@property (nonatomic, strong) NSMutableArray *focusImageArray;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *notice_id;


@property (assign) BOOL tinted;


//@property (nonatomic, strong) NSArray *payCostImageArr;
@end

@implementation CMCWuYeVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"物业";
        self.tabBarItem.image = [UIImage imageNamed:@"property"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"property_select"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatTitleButton];
    
//    [self loadBannaData];
    NSLog(@"kAPI_Property %@",kAPI_Property);
    if ([k_propertyAddress isKindOfClass:[NSDictionary class]]) {

    }
  else  if ([kAPI_Property isKindOfClass:[NSArray class]]) {
        if ([kAPI_Property count]) {
            [[NSUserDefaults standardUserDefaults] setObject:[kAPI_Property firstObject] forKey:@"propertyAddress"];

        }
    }
    [self loadAllData];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_middleButton removeFromSuperview];
    [self.mainScorllView stopScorllView];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bannaImageArr = [[NSMutableArray alloc] init];
//    self.focusImageArray  = [[NSMutableArray alloc] init];
    self.navigationController.navigationBarHidden = NO;

    self.imageArr = [[NSArray alloc] initWithObjects:@"paycost",@"complaints",@"repair",@"notice",@"evaluation",@"introduction", nil];
    self.titleArr = [[NSArray alloc] initWithObjects:@"缴费",@"投诉",@"报修",@"通知",@"评价",nil];
    self.payCostArr = [[NSArray alloc] initWithObjects:@"物业费",@"水费",@"燃气费",@"电费",@"停车费", nil];
    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 480)];
    _backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 560);
    //创建scrollView和pageControl
    [self.view addSubview:_backScrollView];
    _mainScorllView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    if ([CMCUserManager shareManager].zbanner) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:[CMCUserManager shareManager].zbanner type:@"30" number:@"1"];
        UIImageView *bananaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
        [_backScrollView addSubview:bananaImageView];
        
        [bananaImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];

    }
    
    [self creatScrollViewAndPagControl];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainScorllView.frame.size.height +self.mainScorllView.frame.origin.y, self.view.bounds.size.width, 45)];
    backView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [_backScrollView addSubview:backView];
    
    //喇叭
    UIImageView *hornImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 45)];
    hornImageView.image = [UIImage imageNamed:@"喇叭_10"];
    [backView addSubview:hornImageView];
    //最新通知
    _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(hornImageView.frame.size.width, 0,60, 0.07 *self.view.bounds.size.height)];
    _noticeLabel.font = [UIFont fontWithName:nil size:13.0];
    _noticeLabel.textColor = [UIColor colorWithHexString:@"595959"];
    _noticeLabel.text = @" 最新通知:";
    [backView addSubview:_noticeLabel];
    //最新通知的内容
   _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_noticeLabel.frame.size.width +_noticeLabel.frame.origin.x, 0, self.view.frame.size.width - (_noticeLabel.frame.size.width +_noticeLabel.frame.origin.x),  0.07 *self.view.bounds.size.height)];
    _contentLabel.font = [UIFont fontWithName:nil size:11.0];
    _contentLabel.textColor = [UIColor colorWithHexString:@"595959"];
    [backView addSubview:_contentLabel];
    
    
    _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.frame.size.height+backView.frame.origin.y+25, self.view.bounds.size.width, 156)];
    _buttonView.userInteractionEnabled = YES;
    [_backScrollView addSubview:_buttonView];
    
    
    [self creatButton];

    _tinted = NO;
    [self creatRightBarButtonItems];

}
#pragma mark - 创建右边的切换按钮

- (void)creatRightBarButtonItems
{
    UIImage *image = [UIImage imageNamed:@"property_rightBar"];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.view.frame.size.width - image.size.width-10, 20, image.size.width, image.size.height);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"property_rightBar"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}
#pragma mark - 切换物业地址
- (void)didClickRightBtn:(UIButton *)button
{
    CMCSwitchPropertyAddressTVC *propertyAddressTableVC = [[CMCSwitchPropertyAddressTVC alloc] init];
    propertyAddressTableVC.title = @"切换物业地址";
    propertyAddressTableVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:propertyAddressTableVC animated:YES];

}
#pragma mark-
#pragma mark- 获取物业首页的地址
- (void)accessPropertyAddress
{
//    if ([k_propertyAddress isKindOfClass:[NSDictionary class]]) {
//
//        [_middleButton setTitle:[k_propertyAddress objectForKey:@"address"] forState:UIControlStateNormal];
//        
//    }else if ([kAPI_Property count]) {
//        //默认是取第一个
//        NSDictionary *addressDic = [kAPI_Property objectAtIndex:0];
//        [_middleButton setTitle:[addressDic objectForKey:@"address"] forState:UIControlStateNormal];
//        
//        
//        
//        
//        
//    }
    if ([k_propertyAddress isKindOfClass:[NSDictionary class]]) {
//        if ([kAPI_Property count]) {
            [_middleButton setTitle:[BaseUtil getPropertyAddressValue:@"address"] forState:UIControlStateNormal];
            NSLog(@"$$$$$$$$$$$$$$$ %@",[BaseUtil getPropertyAddressValue:@"address"]);

//        }
    }

}
- (void)creatScrollViewAndPagControl
{
//    self.mainScorllView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.3 * self.view.bounds.size.height)];
//    NSURL *url = [BaseUtil systemRandomlyGenerated:[CMCUserManager shareManager].zbanner type:@"30" number:@"1"];
//    NSLog(@"=============%@",url);
//    [self.mainScorllView.imageArr addObject:url];
//    NSLog(@"self.mainScorllView.imageArr  %@",self.mainScorllView.imageArr);
//    [_backScrollView addSubview:self.mainScorllView];
    
//    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.userInteractionEnabled = NO;
//    _pageControl.backgroundColor = [UIColor clearColor];
//    _pageControl.frame = CGRectMake(0, 155, self.view.bounds.size.width, 25);//0, 0, 320, 25
//    _pageControl.numberOfPages = 0;
//    _pageControl.currentPage = 0;
//    [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
//    [_backScrollView addSubview:_pageControl];


}

- (void)creatTitleButton
{
    _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _middleButton.backgroundColor = k_color(@"eca205");
    _middleButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [_middleButton setImage:[UIImage imageNamed:@"wuye_location"] forState:UIControlStateNormal];
    _middleButton.frame = CGRectMake(self.view.frame.size.width/2 - 80, 27, 160, 30);
//    [_middleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 150)];
    [_middleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.navigationController.view addSubview:_middleButton];
    [self accessPropertyAddress];
    
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}
- (void)changePage:(UIPageControl*)page
{


}
-(void)loadAllData
{

    //默认取第一个
    if ([k_propertyAddress isKindOfClass:[NSDictionary class]])  {
            wuye_id = [BaseUtil getPropertyAddressValue:@"zid"];
            
            
            [_middleButton setTitle:[BaseUtil getPropertyAddressValue:@"address"] forState:UIControlStateNormal];
            [self getData];
    }


}

- (void)getData
{
    if (wuye_id &&[CMCUserManager shareManager].token) {
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":wuye_id,@"timestamp":timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = KAPI_propertyIndex([CMCUserManager shareManager].token, wuye_id, timestamp,[BaseUtil md5:sig]);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"物业首页:   %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                    //通知
                    if ([[dataDic objectForKey:@"notice"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *contentDic = [dataDic objectForKey:@"notice"];
                        self.notice = [contentDic objectForKey:@"content"];
                        _contentLabel.text = self.notice;
                        
                        self.notice_id = [contentDic objectForKey:@"zid"];
                    }
                }
            }
        } failure:^(NSError *error) {
            
        }];
        
    }



}

- (void)didClickMiddleButton:(UIButton *)button
{



}
#pragma mark - -缴费,小区通知,投诉,报修......
#pragma mark - -didClickButton
- (void)didClickButton:(UIButton *)button
{
    [CMCUserManager shareManager].wuye_address = [BaseUtil getPropertyAddressValue:@"address"];
    if ([[self.titleArr objectAtIndex:button.tag - 3000] isEqual:@"缴费"]) {
        CMCPayCostViewController *payCostVC = [[CMCPayCostViewController alloc] init];
        payCostVC.hidesBottomBarWhenPushed = YES;
        payCostVC.title = @"缴费";
        [self.navigationController pushViewController:payCostVC animated:YES];
        
    }
    if([[self.titleArr objectAtIndex:button.tag - 3000] isEqualToString:@"通知"]){
        CMCNoticeVC *noticeVC = [[CMCNoticeVC alloc] init];
        noticeVC.title = @"小区通知";
        noticeVC.zid = wuye_id;
        noticeVC.hidesBottomBarWhenPushed = YES;
        noticeVC.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    if ([[self.titleArr objectAtIndex:button.tag - 3000] isEqualToString:@"报修"]) {
       //报修
        CMCComplaintsRepairViewController *complaintVC = [[CMCComplaintsRepairViewController alloc] init];
        complaintVC.zid = wuye_id;
        complaintVC.type = @"1";
        complaintVC.title = @"报修列表";
        complaintVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:complaintVC animated:YES];

        return;
    }
    if ([[self.titleArr objectAtIndex:button.tag - 3000] isEqualToString:@"投诉"]) {
        CMCComplaintsRepairViewController *compliantVC = [[CMCComplaintsRepairViewController alloc] init];
        compliantVC.title = @"投诉列表";
        compliantVC.zid = wuye_id;
        compliantVC.type = @"0";
        compliantVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:compliantVC animated:YES];
//
//            CMCComplaintsVC *complaintsVC = [[CMCComplaintsVC alloc] init];
//            complaintsVC.title = @"投诉";
//            complaintsVC.navigationController.navigationBarHidden = NO;
//            
//            [self.navigationController pushViewController:complaintsVC animated:YES];
        return;

    }
    if ([[self.titleArr objectAtIndex:button.tag - 3000] isEqualToString:@"评价"]) {
            CMCCommentsVC *evaluationVC = [[CMCCommentsVC alloc] init];
        evaluationVC.title = @"服务评价";
        evaluationVC.wuye_zid = wuye_id;
        evaluationVC.navigationController.navigationBarHidden = NO;

        evaluationVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:evaluationVC animated:YES];
        return;

    }
    if ([[self.titleArr objectAtIndex:button.tag - 3000] isEqualToString:@"简介"]) {
        //简介
        CMCIntroductionTableVC *introductionTableVC = [[CMCIntroductionTableVC alloc] init];
        introductionTableVC.zid = wuye_id;
        introductionTableVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:introductionTableVC animated:YES];
        return;

    }


}
- (void)didClickLeftButton:(UIButton *)button
{
//    _sideView.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    [_sideView removeFromSuperview];




}


#pragma mark - 
#pragma mark - creatButton
- (void)creatButton
{

    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j  < 3; j++) {
            if (i*3 + j > self.titleArr.count - 1) {
                return;
            }
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0 + j*(self.view.bounds.size.width/3),95*i + 25  ,self.view.bounds.size.width/3 , 95)];
            tempView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
            [_buttonView addSubview:tempView];
            
            UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + j*(self.view.bounds.size.width/3) ,95*i ,self.view.bounds.size.width/3 -0.5 , 95 - 0.5)];
            buttonImageView.userInteractionEnabled = YES;
            buttonImageView.backgroundColor = [UIColor whiteColor];
            [_buttonView addSubview:buttonImageView];
            
           
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 60, 60)];
            [button setBackgroundImage:[UIImage imageNamed:[self.imageArr objectAtIndex:i*3+j]] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            button.tag = 3000+i*3+j;
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [buttonImageView addSubview:button];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 60, 20)];
            label.text = [self.titleArr objectAtIndex:i*3+j];
            label.font = [UIFont fontWithName:nil size:14.0];
            label.textAlignment = NSTextAlignmentCenter;
            [buttonImageView addSubview:label];
            
        }
    }
}





@end
