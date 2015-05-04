//
//  CMCOrderOrderDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-7.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderOrderDetailVC.h"
#import "CMCOrderWithoutPaymentDetailTVCell.h"

@interface CMCOrderOrderDetailVC ()
{

    UILabel *_middleTitleLabel;
    NetWorkRequest *_request;
}


@property (nonatomic, strong)  UITableView *detailTableView;
@property (nonatomic, strong) NSMutableArray *goods_nameArr;//商品名
@property (nonatomic, strong) NSMutableArray *quantityArr;//份数
@property (nonatomic, strong) NSMutableArray *priceArr;//价格
@property (nonatomic, strong) NSString *order_sn;//订单号
@property (nonatomic, strong) NSString *add_time;//时间
@property (nonatomic, strong) NSString *order_amount;//总计

@property (nonatomic, strong) NSString *comment;//评论
@property (nonatomic, strong) NSString *phone;//电话号码

@end

@implementation CMCOrderOrderDetailVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_middleTitleLabel removeFromSuperview];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"===========%@",self.order_id);
    _request = [[NetWorkRequest alloc] init];
    _request.delegate =self;
    [self creatTabelView];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.quantityArr = [[NSMutableArray alloc] init];
    self.priceArr = [[NSMutableArray alloc] init];
    [self creatMiddleTitleLabel:@"点菜订单详情"];
    [self loadData];
}
- (void)loadData
{
    NSString *timestamp = kAPI_timestamp;
//    NSDictionary *dic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"order_id":self.order_id,@"timestamp":timestamp};
//    NSString *sig = [BaseUtil getSigWithArray:dic];
//    NSString *requstStr = kAPI_getMyorderDetail(kAPI_timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], self.order_id);
    
    NSDictionary *dic = @{@"channel":kAPI_channel,@"token":@"1805e64081991a5cacea5de52bd7db30",@"order_id":@"051157785",@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSLog(@"========%@",dic);
    NSString *requstStr = kAPI_getMyorderDetail(kAPI_timestamp, @"1805e64081991a5cacea5de52bd7db30", [BaseUtil md5:sig], @"051157785");
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
    NSLog(@"订单详情 dic==========%@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSDictionary *dataDic = [dic objectForKey:@"data"];
           self.add_time = [dataDic objectForKey:@"add_time"]; //时间
            self.order_sn = [dataDic objectForKey:@"order_sn"]; //订单号
            self.order_amount = [dataDic objectForKey:@"order_amount"];
            self.comment = [dataDic objectForKey:@"comment"];
            self.phone = [dataDic objectForKey:@"phone"];
            NSArray *goodsArr = [dataDic objectForKey:@"goods"];
            for (NSDictionary *tempDic in goodsArr) {
                [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
                [self.priceArr addObject:[tempDic objectForKey:@"price"]];
                [self.quantityArr addObject:[tempDic objectForKey:@"quantity"]];
                [self.detailTableView reloadData];
            }
        }else {
            [BaseUtil toast:@"暂无详细信息"];
        
        }
        
        
    }else {
    
        [BaseUtil toast:@"服务器未连接,请稍后重试"];
    }


}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}
- (void)creatMiddleTitleLabel:(NSString *)title
{
   _middleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 20, 120, 44)];
    _middleTitleLabel.textColor = [UIColor whiteColor];
    _middleTitleLabel.text = title;
    [self.navigationController.view addSubview:_middleTitleLabel];


}
- (void)creatTabelView
{
    self.detailTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    [BaseUtil setExtraCellLineHidden:self.detailTableView];
    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.detailTableView];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


//    if (self.shop_nameArr.count) {
//        return 1;
//    }
//    return 0;
    return 3;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.goods_nameArr.count %2 == 0) {
            return self.goods_nameArr.count/2 * 30;
        } else {
            
            return (self.goods_nameArr.count / 2 + 1)*30;
        }

    }
    
    if (indexPath.row == 1) {
        return 103;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *str = @"reused";
    CMCOrderWithoutPaymentDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CMCOrderWithoutPaymentDetailTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (indexPath.row == 0) {
            [cell creatLabel:self.goods_nameArr numArr:self.quantityArr priceArr:self.priceArr];
    }
    if (indexPath.row == 1) {
        [cell creatButtomPrice:self.order_amount comment:self.comment phone:self.phone realName:@""];
    }

    
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
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 64, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [orderLabel addSubview:lineImageView];
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
