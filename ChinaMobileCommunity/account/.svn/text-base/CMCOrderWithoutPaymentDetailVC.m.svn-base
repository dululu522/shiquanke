//
//  CMCOrderWithoutPaymentDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderWithoutPaymentDetailVC.h"
#import "CMCOrderWithoutPaymentDetailTVCell.h"
#import "CMCFirstServiceEvaluationVC.h"
#import "CMCEvaluationVC.h"

#define k_thirteenFont [UIFont systemFontOfSize:13.0]
#define k_color [UIColor colorWithHexString:@"666666"]

@interface CMCOrderWithoutPaymentDetailVC ()
{
    NetWorkRequest *_request;
    UILabel *_navigationMidLabel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *goods_nameArr;//商品名
@property (nonatomic, strong) NSMutableArray *quantityArr;//份数
@property (nonatomic, strong) NSMutableArray *priceArr;//价格
@property (nonatomic, strong) NSString *order_sn;//订单号
@property (nonatomic, strong) NSString *add_time;//时间
@property (nonatomic, strong) NSString *order_amount;//总计

@property (nonatomic, strong) NSString *comment;//评论
@property (nonatomic, strong) NSString *phone;//电话号码
@property (nonatomic, strong) NSString *order_type; //外卖的是takeout 点菜:order
@property (nonatomic, strong) NSString *address; //外卖 地址
@property (nonatomic, strong) NSString *real_name;//姓名




@end

@implementation CMCOrderWithoutPaymentDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatNavigationMiddleLabel];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.priceArr = [[NSMutableArray alloc] init];
    self.quantityArr = [[NSMutableArray alloc] init];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 229)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_navigationMidLabel removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"order_id":self.order_id,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requstStr = kAPI_getMyorderDetail(kAPI_timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], self.order_id);
    NSLog(@"%@",requstStr);
    [_request loadDataWithURLString:requstStr];
}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    [self.goods_nameArr removeAllObjects];
    [self.priceArr removeAllObjects];
    [self.quantityArr removeAllObjects];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSDictionary *dataDic = [dic objectForKey:@"data"];
            self.add_time = [dataDic objectForKey:@"add_time"]; //时间
            self.order_sn = [dataDic objectForKey:@"order_sn"]; //订单号
            self.order_amount = [dataDic objectForKey:@"order_amount"];
            self.comment = [dataDic objectForKey:@"comment"];
            self.phone = [dataDic objectForKey:@"phone"];
            self.address = [dataDic objectForKey:@"address"];
            self.real_name = [dataDic objectForKey:@"real_name"];
            NSArray *goodsArr = [dataDic objectForKey:@"goods"];
            for (NSDictionary *tempDic in goodsArr) {
                [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
                [self.priceArr addObject:[tempDic objectForKey:@"price"]];
                [self.quantityArr addObject:[tempDic objectForKey:@"quantity"]];
            }

            [self creatButtomOrder_type:[dataDic objectForKey:@"order_type"] status:[dataDic objectForKey:@"status"]];

            [self.tableView reloadData];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        }else {
            [BaseUtil toast:@"暂无详细信息"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            
        }
        
        
    }else {
        
        [BaseUtil toast:@"服务器未连接,请稍后重试"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }
    
    
}


//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}


- (void)creatNavigationMiddleLabel
{
    _navigationMidLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-80, 20, 160, 44)];
    _navigationMidLabel.text = @"点菜订单详情";
    _navigationMidLabel.textAlignment = NSTextAlignmentCenter;
    _navigationMidLabel.textColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:_navigationMidLabel];


}
- (void)creatButtomOrder_type:(NSString *)type status:(NSString *)status
{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 229, self.view.frame.size.width, 229)];
    [self.view addSubview:buttomView];
    UILabel *combinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100 , 25)];
    combinedLabel.text = @"总计";
    combinedLabel.font = k_thirteenFont;
    combinedLabel.textColor = k_color;
    [buttomView addSubview:combinedLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200, 0, 182, 25)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",self.order_amount];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = kAPI_AllMainColor;
    priceLabel.font = [UIFont systemFontOfSize:13.0];
    priceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [buttomView addSubview:priceLabel];
    
    //备注
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, combinedLabel.frame.size.height +combinedLabel.frame.origin.y , self.view.frame.size.width - 28, 26)];
    noteLabel.text = [NSString stringWithFormat:@"备注:%@",self.comment];
    noteLabel.font = k_thirteenFont;
    noteLabel.textColor = k_color;
    [buttomView addSubview:noteLabel];
   //姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, noteLabel.frame.size.height + noteLabel.frame.origin.y, self.view.frame.size.width - 28, 26)];
    nameLabel.text = [NSString stringWithFormat:@"姓名:%@",self.real_name];
    nameLabel.font = k_thirteenFont;
    nameLabel.textColor = k_color;
    [buttomView addSubview:nameLabel];
    //手机号
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, nameLabel.frame.size.height + nameLabel.frame.origin.y, self.view.frame.size.width - 28, 26)];
    phoneLabel.text = [NSString stringWithFormat:@"手机号:%@",self.phone];
    phoneLabel.textColor = k_color;
    phoneLabel.font = k_thirteenFont;
    [buttomView addSubview:phoneLabel];
    if ([type isEqualToString:@"takeout"]) {
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, phoneLabel.frame.size.height + phoneLabel.frame.origin.y, self.view.frame.size.width - 28, 26)];
        addressLabel.text = [NSString stringWithFormat:@"地址:%@",self.address];
        addressLabel.textColor = k_color;
        addressLabel.font = k_thirteenFont;
        [buttomView addSubview:addressLabel];
    }
    
    UIButton *paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentButton.frame = CGRectMake(10, phoneLabel.frame.size.height +phoneLabel.frame.origin.y + 41, self.view.frame.size.width -20, 40);
    if ([status intValue] == 0) {
        [paymentButton setTitle:@"付款" forState:UIControlStateNormal];
        [paymentButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [paymentButton addTarget:self action:@selector(didClickPaymentButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([status intValue] == 1) {
        [paymentButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [paymentButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [paymentButton addTarget:self action:@selector(didClickConfirmGoods:) forControlEvents:UIControlEventTouchUpInside];
    }

    [buttomView addSubview:paymentButton];


}
//付款
- (void)didClickPaymentButton:(UIButton *)button
{
            [BaseUtil PaymentForGoodsTradeNO:self.order_sn productName:@"点菜订单详情" amount:self.order_amount];


}
//确认收货
- (void)didClickConfirmGoods:(UIButton *)button
{
    CMCFirstServiceEvaluationVC *serviceVC = [[CMCFirstServiceEvaluationVC alloc] init];
    serviceVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serviceVC animated:YES];



}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.goods_nameArr.count) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.goods_nameArr.count %2 == 0) {
        return self.goods_nameArr.count/2 * 30;
    } else {
    
        return (self.goods_nameArr.count / 2 + 1)*30;
    
    }
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    CMCOrderWithoutPaymentDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CMCOrderWithoutPaymentDetailTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell creatLabel:self.goods_nameArr numArr:self.quantityArr priceArr:self.priceArr];

    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    orderView.backgroundColor = [UIColor whiteColor];
//订单号
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 32)];
    orderLabel.text = [NSString stringWithFormat:@"订单号:%@",self.order_sn];
    orderLabel.font = [UIFont systemFontOfSize:14.0];
    orderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [orderView addSubview:orderLabel];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, self.view.frame.size.width - 30, 32)];
    timeLabel.text = [BaseUtil becomeNormalWithString:self.add_time];
    timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    [orderView addSubview:timeLabel];
    return orderView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 64;

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
