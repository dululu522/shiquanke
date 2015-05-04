//
//  CMCManagementFeeVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-13.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCManagementFeeVC.h"
#import "CMCBillPaymentVC.h"
#import "CMCWuYeView.h"
#import "NetWorkRequest.h"

@interface CMCManagementFeeVC ()
{
    
    UIImageView *_selectButton;
    NSString *_property_price;
    NSString *_address;
    NSString *_real_name;
    NSString *_start_time;
    NSString *_over_time;
    NSString *_month;
    UITextField *_paymentNamelabelField;
    UILabel *_paymentAddresslabel;
    UILabel *_paymentTimelabel;
    UILabel *_paymentTonlabel;
    UILabel *_paymentAmountlabel;
    CMCWuYeView *_wuye;
    NetWorkRequest  *_request;
}
@property (nonatomic, strong) NSString *addressId; //物业地址
@property (nonatomic, strong) NSString *address;//物业的地址

@end

@implementation CMCManagementFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.category;
    
    NSLog(@"self.addressByidDic %@",self.managementDic);
//    
    _wuye = [[CMCWuYeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _wuye.category = self.title;
    [_wuye creatWuyeView:self.managementDic];
    [self.view addSubview:_wuye];

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
