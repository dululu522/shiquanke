//
//  CMCWaterBillDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-30.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCWaterBillDetailVC.h"
#import "CMCBillPaymentVC.h"
#import "CMCWuYeView.h"

@interface CMCWaterBillDetailVC ()
{

    UIImageView *_selectButton;
    int number;
    UITextField *_paymentNamelabelField;
    UILabel *_paymentAddresslabel;//地址
    UILabel *_paymentTimelabel;//
    
    UILabel *_paymentTonlabel;
    UILabel *_paymentAmountlabel;
    
    UITableView *_tableView;
    UIView *_addressView;
    CMCWuYeView *_wuye;
    NetWorkRequest *_request;
    
}

@property (nonatomic, strong) NSMutableArray *real_nameArray;
@property (nonatomic, strong) NSMutableArray *water_numberArray;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *start_timeArray;
@property (nonatomic, strong) NSMutableArray *over_timeArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSString *center_id;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *address_id;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSMutableArray *water_priceArr;



@end

@implementation CMCWaterBillDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    number = 0;
    self.real_nameArray = [[NSMutableArray alloc] init];

    self.water_numberArray = [[NSMutableArray alloc] init];
    self.addressArray = [[NSMutableArray alloc] init];
    self.start_timeArray = [[NSMutableArray alloc] init];
    self.over_timeArray = [[NSMutableArray alloc] init];
    self.monthArray = [[NSMutableArray alloc] init];
    self.water_priceArr = [[NSMutableArray alloc] init];

    
//    self.navigationController.navigationBarHidden = NO;
    self.title = @"水费详情";

    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    _wuye = [[CMCWuYeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_wuye];
    _wuye.delegate = self;
    self.address = [[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] objectAtIndex:0];
//    [self loadData:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0]];
[self loadData:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0]];
//   [[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:0];
    
    
}
- (void)didClickItems
{
    [_addressView removeFromSuperview];
    [_tableView removeFromSuperview];
    _addressView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 200)];
    _addressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_addressView];
    
    _tableView = [[UITableView alloc] initWithFrame:_addressView.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_addressView addSubview:_tableView];
    [BaseUtil setExtraCellLineHidden:_tableView];




}



//- (void)creatBackButton
//{
//    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(320, 5,66, 34)];
//    [billButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
//    [billButton addTarget:self action:@selector(didClickBillPaymentBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [billButton setTitle:@"代缴费" forState:UIControlStateNormal];
//    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
//
//}



#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] count];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//    cell.textLabel.text = [self.addressArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 [self loadData:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] objectAtIndex:indexPath.row]];
    self.address = [[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] objectAtIndex:indexPath.row];

    _tableView.hidden = YES;
    _addressView.hidden = YES;
    





}
//加载数据
- (void)loadData:(NSString *)addressId
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *sig = KAPI_GetPropertyFeelifeSig(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, @"1");
    self.address_id = addressId;
    
    NSString *requestStr = KAPI_GetPropertyFeelife(addressId, [CMCUserManager shareManager].phone, [CMCUserManager shareManager].token, [BaseUtil md5:sig], @"1");
    [_request loadDataWithURLString:requestStr];
    



}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    [self.over_timeArray removeAllObjects];
    [self.start_timeArray removeAllObjects];
    [self.over_timeArray removeAllObjects];
    [self.monthArray removeAllObjects];
    [self.water_numberArray removeAllObjects];
    [self.water_priceArr removeAllObjects];
    [self.real_nameArray removeAllObjects];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    NSLog(@"dic ==========%@",dic);
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"] == nil) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"暂无内容"];

        } else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            _wuye.hidden = NO;
            NSArray *dataArr = [dic objectForKey:@"data"];
            for (NSDictionary *tempDic in dataArr) {
                [self.over_timeArray addObject:[tempDic objectForKey:@"over_time"]];
                [self.start_timeArray addObject:[tempDic objectForKey:@"start_time"]];
//                [self.monthArray addObject:[tempDic objectForKey:@"month"]];
                
                [self.water_numberArray addObject:[tempDic objectForKey:@"water_number"]];
                [self.water_priceArr addObject:[tempDic objectForKey:@"water_price"]];
                [self.real_nameArray addObject:[tempDic objectForKey:@"real_name"]];
                self.center_id = [tempDic objectForKey:@"center_id"];
                self.id = [tempDic objectForKey:@"id"];
                
            }

                NSString *timeStr = [NSString stringWithFormat:@"时间:%@至%@",[self.start_timeArray objectAtIndex:0],[self.over_timeArray objectAtIndex:0]];
            [_wuye creatViewPriceText:[self.water_priceArr objectAtIndex:0] address:self.address real_name:[self.real_nameArray objectAtIndex:0] time:timeStr  unitTitle:@"吨数" unitNumber:[self.water_numberArray objectAtIndex:0] uint:@"吨"];

//                [_wuye creatViewPriceText:[self.water_priceArray objectAtIndex:0] address:self.address real_name:[self.real_nameArray objectAtIndex:0] time:timeStr month:nil];
//            _wuye.center_id = self.center_id;
//            _wuye.id = self.id;
//            _wuye.type = @"1";
//            _wuye.number = @"吨";
//            _wuye.address_id = self.address_id;
            [_tableView reloadData];
            


        
        
        }
    }
    


}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}
//点击支付宝
- (void)didClickpayTreasureButton:(UIButton *)button
{
    ++number;
    if (number % 2 != 0) {
        _selectButton.image = [UIImage imageNamed:@"circle_select"];
    } else {
    
       _selectButton.image = [UIImage imageNamed:@"circle"];
    
    
    }



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
//- (void)creatView:(UIImageView *)imageView titleText:(NSString *)str imageNamed:(NSString *)nameStr
//{
//    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
//    logImageView.image = [UIImage imageNamed:nameStr];
//    [imageView addSubview:logImageView];
//    UILabel *paymentlabel = [[UILabel alloc] initWithFrame:CGRectMake(logImageView.frame.origin.x + logImageView.frame.size.width, 0, 100, imageView.frame.size.height)];
//    paymentlabel.font = [UIFont fontWithName:nil size:17.0];
//    paymentlabel.text = str;
//    [imageView addSubview:paymentlabel];
//
//
//
//
//}
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
