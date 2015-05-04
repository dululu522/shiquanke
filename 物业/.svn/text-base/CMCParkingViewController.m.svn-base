//
//  CMCParkingViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-13.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCParkingViewController.h"
#import "CMCBillPaymentVC.h"
#import "CMCWuYeView.h"

#import "CMCStopFee.h"
@interface CMCParkingViewController ()
{

    CMCStopFee *_stopFee;
    NetWorkRequest *_request;
    CMCWuYeView *_wuye;
}
@property (nonatomic, strong) NSMutableArray *car_numberArr;
@property (nonatomic, strong) NSMutableArray *park_numberArr;
@property (nonatomic, strong) NSMutableArray *park_priceArr;
@property (nonatomic, strong) NSMutableArray *over_timeArr;
@property (nonatomic, strong) NSMutableArray *real_nameArr;
@property (nonatomic, strong) NSString *addressId;


@end

@implementation CMCParkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    
    self.car_numberArr = [[NSMutableArray alloc] init];
        self.park_numberArr = [[NSMutableArray alloc] init];
        self.park_priceArr = [[NSMutableArray alloc] init];
        self.over_timeArr = [[NSMutableArray alloc] init];
        self.real_nameArr = [[NSMutableArray alloc] init];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"停车费";
//    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(320, 5,66, 34)];
//    [billButton setBackgroundImage:[UIImage imageNamed:@"代理费_03"] forState:UIControlStateNormal];
//    [billButton addTarget:self action:@selector(didClickBillPaymentBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [billButton setTitle:@"代缴费" forState:UIControlStateNormal];
//    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [self loadData];
    _stopFee = [[CMCStopFee alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:_stopFee];
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

- (void)loadData
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] count]) {
        NSString *str = [[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0];
        NSLog(@"qqqqqqqqqqqq %@",str);
        self.addressId = str;

        NSDictionary *dic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"mobile_phone":[CMCUserManager shareManager].phone,@"type":@"1",@"address":str,@"timestamp":kAPI_timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestStr = kAPI_getFeepark(kAPI_timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], @"1", str,[CMCUserManager shareManager].phone);
        [_request loadDataWithURLString:requestStr];
    }else {
        
        [BaseUtil toast:@"暂无数据"];
    }


//[BaseUtil get:KAPI_getcar_number([CMCUserManager shareManager].phone) success:^(AFHTTPRequestOperation *operation, id jsonObject) {
//    NSLog(@"停车费  === %@",KAPI_getcar_number(@"18701332567"));
//    if ([[jsonObject objectForKey:@"status"] intValue] == 1) {
//        NSArray *infoArr = [jsonObject objectForKey:@"info"];
//        for (NSDictionary *tempDic in infoArr) {
//            [self.car_numberArr addObject:[tempDic objectForKey:@"car_number"]];
//            [self.park_numberArr addObject:[tempDic objectForKey:@"park_number"]];
//            [self.park_priceArr addObject:[tempDic objectForKey:@"park_price"]];
//            [self.over_timeArr addObject:[tempDic objectForKey:@"over_time"]];
//            [self.real_nameArr addObject:[tempDic objectForKey:@"real_name"]];
//        }
//        [_stopFee creatStopFeeCar_number:[self.car_numberArr objectAtIndex:0] park_number:[self.park_numberArr objectAtIndex:0] park_price:[self.park_priceArr objectAtIndex:0] over_time:[self.over_timeArr objectAtIndex:0] real_name:[self.real_nameArr objectAtIndex:0]];
//    }
//    
//    
//} faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    
//}];
}
#pragma mark-
#pragma mark - NetWorkRequesDelegate
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"停车费 =========%@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] ==0) {
        NSArray *dataArr = [dic objectForKey:@"data"];
        if (dataArr.count == 0) {
            [BaseUtil toast:@"暂无数据"];
        }else {
            
            NSDictionary *tempDic = [dataArr objectAtIndex:0];
            NSString *id = [tempDic objectForKey:@"id"];//订单id
            NSString *car_number = [tempDic objectForKey:@"car_number"];
            NSString *center_id = [tempDic objectForKey:@"center_id"];
            NSString *park_day = [tempDic objectForKey:@"park_day"];
            NSString *park_number = [tempDic objectForKey:@"park_number"];
            NSString *park_price = [tempDic objectForKey:@"park_price"];
            NSString *real_name = [tempDic objectForKey:@"real_name"];
//            [_wuye creatViewPriceText:property_price address:@"" real_name:real_name time:time month:month];
//            [_stopFee creatStopFeeCar_number:car_number park_number:park_number park_price:park_price over_time:park_day real_name:real_name];
            _stopFee.address = [self.addressByidDic objectForKey:self.addressId];
            [_stopFee creatStopFeeCar_number:car_number park_number:park_number park_price:park_price over_time:park_day real_name:real_name];
//            _wuye.type = @"1";
//            _wuye.center_id = [tempDic objectForKey:@"center_id"];
//            _wuye.id = id;
            _stopFee.order_id = id;
            
            
        }
    }
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        
    }else {
        
        [BaseUtil toast:@"暂无数据"];
    }
    
    
}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{
    
    
}

//代缴费

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
