//
//  CMCPaymentDetailsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPaymentDetailsVC.h"
#import "CMCPaymentDetailsTableViewCell.h"
#import "MD5.h"
#import <AlipaySDK/AlipaySDK.h>

@interface CMCPaymentDetailsVC ()
{
    UIImageView *_bestPayImageView;
    UIImageView *_paymentImageView;
    BOOL _selectCount;
    UIView *_buttomView;
    UILabel *_shopNameLabel;
    UILabel *_moneylabel;
    NSInteger _count;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *default_imageArr;
@property (nonatomic, strong) NSMutableArray *goods_idArr;
@property (nonatomic, strong) NSMutableArray *goods_nameArr;
//@property (nonatomic, strong) NSMutableArray *order_idArr;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSMutableArray *priceArr;
@property (nonatomic, strong) NSMutableArray *quantityArr;

//@property (nonatomic, strong) NSMutableArray *total_priceArr;
@property (nonatomic, strong) NSString *pay;
@property (nonatomic, strong) NSMutableArray *default_image;


@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSString *orderTranSeq;//流水号


@end

@implementation CMCPaymentDetailsVC
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.tempDic = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付详情";
    _selectCount = 0;
    _count = 0;
    self.params = [[NSMutableDictionary alloc] init];
    self.default_imageArr = [[NSMutableArray alloc] init];
    self.goods_idArr = [[NSMutableArray alloc] init];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.priceArr = [[NSMutableArray alloc] init];
    self.quantityArr = [[NSMutableArray alloc] init];
    self.default_imageArr = [[NSMutableArray alloc] init];
    //    self.total_priceArr = [[NSMutableArray alloc] init];
    
    NSLog(@"self.tempDic === %@",self.tempDic);

    
    
    [self loadData];
    
    //    [self creatTableView];
    
    self.myTableView = [[UITableView alloc] init];
    self.myTableView.frame = CGRectMake(0,0, self.view.bounds.size.width,self.goods_nameArr.count *35+40 +35);
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.myTableView.frame.size.height, self.view.bounds.size.width, 100)];
    [self.view addSubview:_buttomView];
    _buttomView.backgroundColor = [UIColor whiteColor];
    _moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, 35)];
    _moneylabel.text = [NSString stringWithFormat:@"本次消费金额:%@",self.pay];
    _moneylabel.textColor = [UIColor colorWithHexString:@"676767"];
    
    [_buttomView addSubview:_moneylabel];
    UILabel *youhuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _moneylabel.frame.size.height+_moneylabel.frame.origin.y, 80, 35)];
    youhuiLabel.textColor = [UIColor colorWithHexString:@"666666"];
            youhuiLabel.text = @"支付方式:";
    
    [_buttomView addSubview:youhuiLabel];
    //
        //代金券
    
        _bestPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(youhuiLabel.frame.size.width + youhuiLabel.frame.origin.x+ 5, youhuiLabel.frame.origin.y + 7, 20, 20)];
        //    hashTableImageView.backgroundColor = [UIColor blackColor];
        _bestPayImageView.userInteractionEnabled = YES;
            _bestPayImageView.image = [UIImage imageNamed:@"选_25"];
        [_buttomView addSubview:_bestPayImageView];
    
        UILabel *bestPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bestPayImageView.frame.size.width + _bestPayImageView.frame.origin.x+5, youhuiLabel.frame.origin.y, 50, 35)];
            bestPayLabel.text = @"翼支付";
    
        bestPayLabel.font = [UIFont systemFontOfSize:14.0];
        bestPayLabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    
        [_buttomView addSubview:bestPayLabel];
    
        UIButton *bestPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bestPayBtn.frame = CGRectMake(_bestPayImageView.frame.origin.x, bestPayLabel.frame.origin.y, 20+5+40, 35);
        //    hashTableButton.backgroundColor = [UIColor greenColor];
            [bestPayBtn addTarget:self action:@selector(didClickBestPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:bestPayBtn];
    
        //折扣券
    
        _paymentImageView = [[UIImageView alloc] init];
            _paymentImageView.image = [UIImage imageNamed:@"未选_25"];
        //    _discountImageView.userInteractionEnabled = YES;
        _paymentImageView.frame = CGRectMake(bestPayLabel.frame.size.width + bestPayLabel.frame.origin.x + 10, _bestPayImageView.frame.origin.y, 20, 20);
        //    _roomsImageView.backgroundColor = [UIColor orangeColor];
        [_buttomView addSubview:_paymentImageView];
    
        UILabel *paymentlabel = [[UILabel alloc] initWithFrame:CGRectMake(_paymentImageView.frame.size.width + _paymentImageView.frame.origin.x+5, youhuiLabel.frame.origin.y, 50, 35)];
            paymentlabel.text = @"支付宝";
        paymentlabel.font = [UIFont systemFontOfSize:14.0];
        paymentlabel.textColor = [UIColor colorWithHexString:@"666666"];
    
        [_buttomView addSubview:paymentlabel];
    
        UIButton *paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        paymentButton.frame = CGRectMake(_paymentImageView.frame.origin.x, paymentlabel.frame.origin.y, 20+5+40, 35);
        [paymentButton addTarget:self action:@selector(didClickPaymentButton:) forControlEvents:UIControlEventTouchUpInside];
        //    roomsButton.backgroundColor = [UIColor redColor];
        [_buttomView addSubview:paymentButton];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    payButton.frame = CGRectMake(self.view.frame.size.width/2- 40, youhuiLabel.frame.origin.y+ youhuiLabel.frame.size.height + 5, 80, 40);
    payButton.frame = CGRectMake(20, youhuiLabel.frame.origin.y+ youhuiLabel.frame.size.height + 5, self.view.frame.size.width - 80, 40);
    [payButton addTarget:self action:@selector(didClickpayButton:) forControlEvents:UIControlEventTouchUpInside];
    [payButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    payButton.userInteractionEnabled = YES;
    [payButton setTitle:@"付款" forState:UIControlStateNormal];
    [_buttomView addSubview:payButton];
//    //翼支付
//        UIButton *wingPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        wingPayBtn.frame = CGRectMake(payButton.frame.size.width +payButton.frame.origin.x + 30, youhuiLabel.frame.origin.y+ youhuiLabel.frame.size.height + 5, 80, 40);
//        [wingPayBtn addTarget:self action:@selector(didClickBestPayBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [wingPayBtn setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
//        [wingPayBtn setTitle:@"翼支付" forState:UIControlStateNormal];
//        [_buttomView addSubview:wingPayBtn];
    
    
    
    
    
    
    
    
}
- (void)loadData
{
    [self.default_imageArr removeAllObjects];
    [self.goods_idArr removeAllObjects];
    [self.goods_nameArr removeAllObjects];
    [self.priceArr removeAllObjects];
    [self.quantityArr removeAllObjects];
    //    NSDictionary *infoDic = [self.tempDic objectForKey:@"info"];
    
    //    NSDictionary *dataDic = [self.tempDic objectForKey:@"data"];
    //    NSDictionary *infoDic = [dataDic objectForKey:@"info"];
    //    if ([[infoDic objectForKey:@"result"] intValue] != 0) {
    //        [BaseUtil toast:@"请求失败"];
    //        return;
    //    }
    if ([[self.tempDic objectForKey:@"goodslist"] count]) {
        NSArray *goodslistArr = [self.tempDic objectForKey:@"goodslist"];
        for (NSDictionary *dic in goodslistArr) {
            //        [self.default_imageArr
            //         addObject:[dic objectForKey:@"default_image"]];
            [self.goods_idArr addObject:[dic objectForKey:@"id"]];
            [self.goods_nameArr addObject:[dic objectForKey:@"goods_name"]];
            [self.priceArr addObject:[dic objectForKey:@"price"]];
            [self.quantityArr addObject:[dic objectForKey:@"num"]];
            [self.default_imageArr addObject:[dic objectForKey:@"default_image"]];
            //        [self.total_priceArr addObject:[dic objectForKey:@"price"]];
        }
        
        self.pay = [self.tempDic objectForKey:@"pay"];
        self.order_id = [self.tempDic objectForKey:@"order_sn"];
        
        [self.myTableView reloadData];
    }
    
    
    
}
- (void)didClickRightButton:(UIButton *)button
{
    ++_selectCount;
    if (_selectCount%2!= 0) {
        //            self.myTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _buttomView.frame = CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height);
    }else {
        _buttomView.frame = CGRectMake(0, self.myTableView.frame.size.height, self.view.bounds.size.width, 100);
        // self.myTableView.frame = CGRectMake(0,0, self.view.bounds.size.width,300);
        //        [self.myTableView reloadData];
        
        
    }
    
    
    
    
}
//翼支付
- (void)didClickBestPayBtn:(UIButton *)button
{
    _count = 0;
    _paymentImageView.image = [UIImage imageNamed:@"未选_25"];
    
    _bestPayImageView.image = [UIImage imageNamed:@"选_25"];
    
    //    UITableView *discountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myTableView.frame.origin.x + self.myTableView.frame.size.height, self.view.bounds.size.width, 100)];
    //    discountTableView.delegate = self;
    //    discountTableView.dataSource = self;
    //    [self.view addSubview:discountTableView];
    
    
}
//支付宝
- (void)didClickPaymentButton:(UIButton *)button
{
    _count = 1;
    _bestPayImageView.image = [UIImage imageNamed:@"未选_25"];
    _paymentImageView.image = [UIImage imageNamed:@"选_25"];
}
//付款
- (void)didClickpayButton:(UIButton *)button
{
    if (_count == 1) {
        Order *order = [[Order alloc] init];
        order.partner = PartnerID;
        order.seller = SellerID;
        order.tradeNO = self.order_id;//订单id
        order.productName = _shopNameLabel.text; //商品标题
        order.productDescription = @"购买的商品";//商品描述
        order.amount = self.pay;//商品价格
        //    order.amount = @"0.01";
        order.notifyURL = kAPI_NotifyURL;//回调的url
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showUrl = @"m.alipay.com";
        NSString *appScheme = @"com.ChinaMobileCommunity";
        
        NSString *orderSpec = [order description];
        id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
        
        NSString *signedString = [signer signString:orderSpec];
        
        NSString *orderString = nil;
        if (orderString == nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
        }
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *resultStatusStr = [resultDic objectForKey:@"resultStatus"];
            NSString* msg = @"";
            if ([resultStatusStr isEqualToString:@"6001"]) {
                msg=@"您中途取消支付";
            }
            if ([resultStatusStr isEqualToString:@"9000"]) {
                msg=@"支付宝支付成功";
            }
            if([resultStatusStr isEqualToString:@"4000"]){
                msg = @"支付宝异常,请尝试重新购买";
            }
            [BaseUtil alertWithTitle:@"提示" msg:msg];
            
        }];
        
    }
    if (_count == 0) {
//        [self doOrder];
    }
    
    
}
//- (void)didClickWingPayBtn:(UIButton *)btn
//{
//
//    [self doOrder];
//}
#pragma mark -
#pragma mark  Private Methods
-(NSString *)orderInfos
{
    
    NSMutableString * orderDes = [NSMutableString string];
    //商户号
    [orderDes appendFormat:@"MERCHANTID=%@", MERCHANTID];
    //子商户号
    [orderDes appendFormat:@"&SUBMERCHANTID=%@", [_params objectForKey:@"SUBMERCHANTID"]];
    //商户密码 由翼支付网关平台统一分配给各接入商户
    [orderDes appendFormat:@"&MERCHANTPWD=%@", PSWD];
    
    //订单号
    [orderDes appendFormat:@"&ORDERSEQ=%@", self.order_id];
    //订单请求流水号，唯一
    [orderDes appendFormat:@"&ORDERREQTRNSEQ=%@", [self getOrderTrSeq]];
    //金额限制：1-30元整数 单位为元 如2.00
    //请求扣减积分值
    //        [orderDes appendFormat:@"&ORDERAMOUNT=%@", [NSString stringWithFormat:@"%.2f",[[_params objectForKey:@"ORDERAMT"] floatValue]/100.f]];
    //订单总金额
    [orderDes appendFormat:@"&ORDERAMOUNT=%@", [NSString stringWithFormat:@"%.2f",[self.pay floatValue]/100.f]];
    //订单请求时间 格式：yyyyMMddHHmmss
    //        [orderDes appendFormat:@"&ORDERDATE=%@", [self getOrderTime]];
    [orderDes appendFormat:@"&ORDERTIME=%@", [self getOrderTime]];
    //产品描述 optional
    [orderDes appendFormat:@"&PRODUCTDESC=%@", @"chanpinmiaoshu"];
    //附加信息 optional
    [orderDes appendFormat:@"&ATTACH=%@", @"fujiaxinxi"];
    //支付结果通知地址 翼支付网关平台将支付结果通知到该地址，详见支付结果通知接口
    [orderDes appendFormat:@"&BACKMERCHANTURL=%@", kAPI_WingPayNotifyURL];
    
    
    //产品金额
    [orderDes appendFormat:@"&PRODUCTAMOUNT=%@", [NSString stringWithFormat:@"%.2f",[self.pay floatValue]/100.f]];
    //附加金额 单位元，小数点后2位
    [orderDes appendFormat:@"&ATTACHAMOUNT=%@",@"0.00"];
    //币种, 默认RMB
    [orderDes appendFormat:@"&CURTYPE=%@", @"RMB"];
    //业务标识 optional
    [orderDes appendFormat:@"&PRODUCTID=%@", @"yewubiaozhi"];
    //分账描述 optional
    [orderDes appendFormat:@"&DIVDETAILS=%@", @""];
    
    //订单有效截至日期
    [orderDes appendFormat:@"&ORDERVALIDITYTIME=%@", @""];
    //客户标识 在商户系统的登录名 optional
    [orderDes appendFormat:@"&CUSTOMERID=%@", @"tylzhuang"];
    
    //用户IP 主要作为风控参数 optional
    [orderDes appendFormat:@"&USERIP=%@", @"58.53.199.98"];
    
    self.encodeOrderStr = [NSString stringWithFormat:@"MERCHANTID=%@&ORDERSEQ=%@&ORDERREQTRNSEQ=%@&ORDERTIME=%@&KEY=%@", MERCHANTID, self.order_id, [self getOrderTrSeq], [self getOrderTime], KEY];
    NSString *signStr = [MD5 signString:self.encodeOrderStr];
    NSLog(@"跳转支付时签名信息源串：%@",self.encodeOrderStr);
    
    //MAC验证信息 采用MD5加密
    [orderDes appendFormat:@"&MAC=%@", signStr];
    //资金源控制标识
    [orderDes appendFormat:@"&BUSITYPE=%@", @"01"];
    
    return orderDes;
    
}
//订单处理
- (void)doOrder
{
    self.receiveData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://webpaywg.bestpay.com.cn/order.action"];
    //    NSURL *url = [NSURL URLWithString:@"https://wappaywg.bestpay.com.cn/payWap.action"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //    NSString *timeStr = [self getOrderTime];
    NSString* signOrigStr = [NSString stringWithFormat:@"MERCHANTID=%@&ORDERSEQ=%@&ORDERREQTRANSEQ=%@&ORDERREQTIME=%@&KEY=%@", MERCHANTID, self.order_id, [self getOrderTrSeq],[self getOrderTime], KEY];
    
    //    NSString *signMac = [self md5:signOrigStr];
    NSString *signMac = [self md5:signOrigStr];
    NSString *str = [NSString stringWithFormat:@"MERCHANTID=%@&SUBMERCHANTID=%@&ORDERSEQ=%@&ORDERAMT=%@&ORDERREQTRANSEQ=%@&ORDERREQTIME=%@&MAC=%@&TRANSCODE=%@",
                     MERCHANTID,
                     @"",
                     self.order_id,
                     [NSString stringWithFormat:@"%.2f",[self.pay floatValue]/100.f],
                     [self getOrderTrSeq],
                     [self getOrderTime],
                     signMac,
                     @"01"];
    
    
    NSLog(@"下单接口信息：%@",str);
    
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    
}
//MD5编码处理
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    //self.receiveData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    if([[receiveStr substringToIndex:2] isEqualToString:@"00"]) {
        //获取订单信息
        NSString *orderStr = [self orderInfos];
        
        
        NSLog(@"跳转支付页面带入信息：%@", orderStr);
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *urls = [dic objectForKey:@"CFBundleURLTypes"];
        
        
        
        //跳转至支付页面
        [bestpay launchWithType:launchTypePay
                          order:orderStr
                         scheme:[[[urls firstObject] objectForKey:@"CFBundleURLSchemes"] firstObject]
                        seletor:nil
                         target:self];
        
        //            _orderSeq.text = [self getOrderTrSeq];
        //            _orderTranSeq.text = [self getOrderTrSeq];
    }
    else {
        
        
        NSLog(@"下单失败：%@", receiveStr);
        
        [self showAlert:@"下单失败，请稍后再试"];
    }
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败%@",[error localizedDescription]);
    //        [self.loadingView stopAnimating];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}


//获取当前时间
- (NSString *)getOrderTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *  locationString = [dateformatter stringFromDate:senddate];
    return locationString;
    
}
//获取当前时间戳
- (NSString *)getOrderTrSeq
{
    NSDate *  senddate=[NSDate date];
    NSString *  locationString = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    //    if(self.mobile.text != nil) {
    //        locationString = [locationString stringByAppendingString:self.mobile.text];
    //    }
    return locationString;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goods_nameArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CMCPaymentDetailsTableViewCell";
    CMCPaymentDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCPaymentDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell creatPaymentDetailCellImage:[self.default_imageArr objectAtIndex:indexPath.row] nameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] additionalCopiesLabel:[self.quantityArr objectAtIndex:indexPath.row] priceLabel:[self.priceArr objectAtIndex:indexPath.row]];
    //    }
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] init];
    //    self.myTableView.tableHeaderView = sectionView;
    sectionView.backgroundColor = [UIColor whiteColor];
    UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    //    shopImageView.backgroundColor = [UIColor greenColor];
    shopImageView.image = [UIImage imageNamed:@"shangjia"];
    [sectionView addSubview:shopImageView];
    
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopImageView.frame.size.width + shopImageView.frame.origin.x+5, 0, 300, 35)];
    _shopNameLabel.text = self.merchantName;
    _shopNameLabel.textColor = [UIColor colorWithHexString:@"676767"];
    [sectionView addSubview:_shopNameLabel];
    
    UIImageView *rightButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 30, 15, 10, 10)];
    rightButtonImageView.image = [UIImage imageNamed:@"notclick"];
    rightButtonImageView.userInteractionEnabled = YES;
    [sectionView addSubview:rightButtonImageView];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    [rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:rightButton];
    return sectionView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (self.myTableView == tableView) {
//        return 100;
//    }
//    return 0;
//
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.myTableView == tableView) {
        return 40;
    }
    
    return 0;
    
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
