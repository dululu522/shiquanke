//
//  CMCGasFeeViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCGasFeeViewController.h"
#import "CMCBillPaymentVC.h"
#import "CMCWuYeView.h"

@interface CMCGasFeeViewController ()
{
    
    UIImageView *_selectButton;
    UIImageView *_tonnageImageView;
    UILabel *_paymentTonlabel;
    UITextField *_paymentNamelabelField;
    UILabel *_paymentAddresslabel;
    UILabel *_paymentTimelabel;
    UILabel *_paymentAmountlabel;
    CMCWuYeView *_wuye;
    NetWorkRequest *_request;
}
//@property (nonatomic, strong) NSMutableArray *real_nameArr;
@property (nonatomic, copy) NSMutableArray *gas_priceArr;
@property (nonatomic, copy) NSMutableArray *gas_numberArr;
//@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSMutableArray *start_timeArr;
@property (nonatomic, copy) NSMutableArray *over_timeArr;
@property (nonatomic, copy) NSMutableArray *monthArr;
@property (nonatomic, copy) NSString *address_id;




@end

@implementation CMCGasFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    self.gas_numberArr = [[NSMutableArray alloc] init];
    self.gas_priceArr = [[NSMutableArray alloc] init];
    self.monthArr = [[NSMutableArray alloc] init];
    self.over_timeArr = [[NSMutableArray alloc] init];
    self.start_timeArr = [[NSMutableArray alloc] init];
    
    self.title = @"燃气费";

    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    _wuye = [[CMCWuYeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:_wuye];
    [self loadData:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0]];

}
- (void)loadData:(NSString *)addressId
{

    self.address_id = addressId;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *sig = KAPI_GetPropertyFeelifeSig(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, @"3");
    NSLog(@"燃气费 =========%@",sig);
    
    NSString *requestStr = KAPI_GetPropertyFeelife(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, [BaseUtil md5:sig], @"3");
    NSLog(@"requestStr =========%@",requestStr);
    [_request loadDataWithURLString:requestStr];
    
    
    
}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"燃气费 dic ==== %@",dic);
    
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSArray *dataArr = [dic objectForKey:@"data"];
//            for (NSDictionary *tempDic in dataArr) {
//                [self.gas_numberArr addObject:[tempDic objectForKey:@"gas_number"]];
//                [self.gas_priceArr addObject:[tempDic objectForKey:@"gas_price"]];
//                [self.monthArr addObject:[tempDic objectForKey:@"month"]];
//                [self.over_timeArr addObject:[tempDic objectForKey:@"over_time"]];
//                [self.start_timeArr addObject:[tempDic objectForKey:@"start_time"]];
//                
//                
//            }
            NSDictionary *tempDic = [dataArr objectAtIndex:0];
            [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
            
 NSString *str = [NSString stringWithFormat:@"时间:%@至%@",[tempDic objectForKey:@"start_time"],[tempDic objectForKey:@"over_time"]];
            
//            [_wuye creatViewPriceText:[tempDic objectForKey:@"gas_price"] address:nil real_name:[tempDic objectForKey:@"real_name"] time:str month:[NSString stringWithFormat:@"体积:%@立方米",[tempDic objectForKey:@"gas_number"]]];
            NSLog(@"=======%@",[self.addressByidDic objectForKey:self.address_id]);
            [_wuye creatViewPriceText:[tempDic objectForKey:@"gas_price"] address:[self.addressByidDic objectForKey:self.address_id] real_name:[tempDic objectForKey:@"real_name"]  time:str unitTitle:@"体积" unitNumber:[tempDic objectForKey:@"gas_number"] uint:@"立方米"];
            
//            _wuye.center_id = [tempDic objectForKey:@"center_id"];
//            _wuye.id = [tempDic objectForKey:@"id"];
//            _wuye.type = @"3";
//            _wuye.number = @"立方米";
//            _wuye.address_id = self.address_id;
//            [_tableView reloadData];
        } else {
            [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];

            [BaseUtil toast:@"暂无数据"];
            return;
        }
        
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
        [BaseUtil toast:@"数据加载失败,请重新加载"];
        return;
    
    }

}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{




}
//代缴费
- (void)didClickBillPaymentBtn:(UIButton *)button
{
    CMCBillPaymentVC *billPayVC = [[CMCBillPaymentVC alloc] init];
    [self.navigationController pushViewController:billPayVC animated:YES];
    
    
    
    
}
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
