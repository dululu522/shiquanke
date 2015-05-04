//
//  CMCElectricityViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-13.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCElectricityViewController.h"
#import "CMCBillPaymentVC.h"

#import "CMCWuYeView.h"

@interface CMCElectricityViewController ()
{
    
    UIImageView *_selectButton;
    CMCWuYeView *_wuyeView;
    NetWorkRequest *_request;
//    int number;
//    //吨数
//    UIImageView *_tonnageImageView;
//    UILabel *_paymentTonlabel;
//    UITextField *_paymentNamelabelField;
//    UILabel *_paymentAddresslabel;
//    UILabel *_paymentTimelabel;
//    UILabel *_paymentAmountlabel;
}
//@property (nonatomic, strong) NSString *real_name;
//@property (nonatomic, strong) NSString *power;
//@property (nonatomic, strong) NSString *p_number;
//@property (nonatomic, strong) NSString *address;
//@property (nonatomic, strong) NSString *start_time;
//@property (nonatomic, strong) NSString *over_time;
//@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *addressId; //地址id

@end

@implementation CMCElectricityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"电费详情";
//    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(320, 5,66, 34)];
//    [billButton setBackgroundImage:[UIImage imageNamed:@"代理费_03"] forState:UIControlStateNormal];
//    [billButton addTarget:self action:@selector(didClickBillPaymentBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [billButton setTitle:@"代缴费" forState:UIControlStateNormal];
//    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    
   _wuyeView = [[CMCWuYeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:_wuyeView];

    [self loadData:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0]];
    [self creatNavigationBackButton];

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

- (void)loadData:(NSString *)addressId
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSString *sig = KAPI_GetPropertyFeelifeSig(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, @"2");
//    NSLog(@"燃气费 =========%@",sig);
    NSLog(@"=========%@",addressId);
    self.addressId = addressId;
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"mobile_phone":[CMCUserManager shareManager].phone,@"type":@"2",@"address":addressId,@"timestamp":timestamp};
    NSLog(@"%@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    
    NSString *requestStr = KAPI_GetPropertyFeelife(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, [BaseUtil md5:sig], @"2");
    [_request loadDataWithURLString:requestStr];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//[BaseUtil get:kAPI_getpaylife(@"18701332567",@"2") success:^(AFHTTPRequestOperation *operation, id jsonObject) {
//    
//    if ([[jsonObject objectForKey:@"status"] intValue] == 1) {
//        NSArray *infoArr = [jsonObject objectForKey:@"info"];
//        for (NSDictionary *tempDic in infoArr) {
//            self.real_name = [tempDic objectForKey:@"real_name"];
//            self.p_number = [tempDic objectForKey:@"p_number"];
//            self.power = [tempDic objectForKey:@"power"];
//            self.address = [tempDic objectForKey:@"address"];
//            self.start_time = [tempDic objectForKey:@"start_time"];
//            self.over_time = [tempDic objectForKey:@"over_time"];
//            self.month = [tempDic objectForKey:@"month"];
//            
//        }
//        NSString *timeStr = [NSString stringWithFormat:@"时间:%@至%@",self.start_time,self.over_time];
//        [_wuyeView creatViewPriceText:self.power address:self.address real_name:self.real_name time:timeStr month:[NSString stringWithFormat:@"用量:%@度",self.month]];
//    }
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//    
//    
//} faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//    
//}];



}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"电费 =====%@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSArray *dataArr = [dic objectForKey:@"data"];
            NSDictionary *tempDic = [dataArr objectAtIndex:0];
            NSString *center_id = [tempDic objectForKey:@"center_id"];
            NSString *id = [tempDic objectForKey:@"id"];
            NSString *over_time = [tempDic objectForKey:@"over_time"];
            NSString *power_number = [tempDic objectForKey:@"power_number"];
            NSString *power_price = [tempDic objectForKey:@"power_price"];
            NSString *real_name = [tempDic objectForKey:@"real_name"];
            NSString *start_time = [tempDic objectForKey:@"start_time"];
//            [_wuyeView creatViewPriceText:power_price address:@"" real_name:real_name time:[NSString stringWithFormat:@"%@至%@",start_time,over_time] month:@""];
            [_wuyeView creatViewPriceText:power_price address:[self.addressByidDic objectForKey:self.addressId] real_name:real_name time:[NSString stringWithFormat:@"时间: %@至%@",start_time,over_time] unitTitle:@"度数" unitNumber:power_number uint:@"度"];
//            _wuyeView.priceText = power_price;
//            _wuyeView.center_id = center_id;
//            _wuyeView.type = @"2";
//            _wuyeView.number = @"度";
//            _wuyeView.address_id = self.addressId;
//            _wuyeView.id = [tempDic objectForKey:@"id"];
            


            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        } else {
            [BaseUtil toast:@"暂无数据"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        }
    }

}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{
    
    
    
}
////点击支付宝
//- (void)didClickpayTreasureButton:(UIButton *)button
//{
//    ++number;
//    if (number % 2 != 0) {
//        _selectButton.image = [UIImage imageNamed:@"circle_select"];
//    } else {
//        
//        _selectButton.image = [UIImage imageNamed:@"circle"];
//        
//        
//    }
//    
//    
//    
//}
//代缴费
//- (void)didClickBillPaymentBtn:(UIButton *)button
//{
//    CMCBillPaymentVC *billPayVC = [[CMCBillPaymentVC alloc] init];
//    [self.navigationController pushViewController:billPayVC animated:YES];
//    
//    
//    
//    
//}
//提交
- (void)didClickOkButton:(UIButton *)button
{
    
    
    
    
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
