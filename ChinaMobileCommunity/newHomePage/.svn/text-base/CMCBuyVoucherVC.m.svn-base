//
//  CMCBuyVoucherVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//
static int numberP = 0;
#import "CMCBuyVoucherVC.h"
#import "CMCBestPayModel.h"

@interface CMCBuyVoucherVC ()
{
    UIButton *_numberBtn;
    UILabel *_nameL;
    UIButton *_bestPayBtn;
    UIButton *_payButton;
    float _allPrice; //总价格
}

@property (nonatomic,strong)UIScrollView *myScrollView;
@property (nonatomic, strong) NSString *priceStr;//价格
@property (nonatomic, strong) NSString *payment;


@end

@implementation CMCBuyVoucherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单详情";
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.payment = @"1";
    // Do any additional setup after loading the view.
    [self createSubViews];
//    [[NSUserDefaults standardUserDefaults] objectForKey:@"voucherDetails"];
    
}


#pragma mark - 创建子视图 － 



- (void)createSubViews{
    
    [self setupScrollView];
    [self setupBottomView];
    
}


- (void)setupScrollView{

    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
    _myScrollView.backgroundColor = k_color(@"f5f4f4");
    _myScrollView.contentSize = CGSizeMake(self.view.width, self.view.height);
    [self.view addSubview:_myScrollView];
    
}


- (void)setupBottomView{
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            view.frame = CGRectMake(0, 4, self.view.width, 150);
            [self setupFirstViewWithView:view];
        }
        if (i == 1) {
            view.frame = CGRectMake(0, 173, self.view.width, 48);
            [self setupSecondViewWithView:view];
        }
        if (i == 2) {
            view.frame = CGRectMake(0, 237, self.view.width, 51);
            [self setupThirdViewWithView:view];
        }
        [_myScrollView addSubview:view];
    }
    
    
}

- (void)setupFirstViewWithView:(UIView *)view{
    NSDictionary *voucherDetailsDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"voucherDetails"];
    //image
    UIImage *image = [UIImage imageNamed:@"icon_shop_new"];
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(13, 12, image.size.width, image.size.height);
    imgView.image = [UIImage imageNamed:@"icon_shop_new"];
    [view addSubview:imgView];
    
    //名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 4, 12, 200, 16) font:16 textColor:@"3a3a3a" superView:view];
    nameL.text = [voucherDetailsDic objectForKey:@"name"];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,imgView.bottom + 5,imgView.width + nameL.width + 10, 0.5);
    sepeV.backgroundColor = k_color(@"ededed");
    [view addSubview:sepeV];
    
    
    //原价格
    UILabel *priceL = [self createLWithFrame:CGRectMake(12, sepeV.bottom + 22, 80, 18) font:18 textColor:@"fc0201" superView:view];
    NSString *price = [voucherDetailsDic objectForKey:@"money_buy"];
    priceL.text = [NSString stringWithFormat:@"¥%@",price];
    self.priceStr = [voucherDetailsDic objectForKey:@"money_buy"];
    //老价格
    UILabel *oldPL = [self createLWithFrame:CGRectMake(priceL.right + 5, priceL.top + 8, 60,13) font:13 textColor:@"b5b5b5" superView:view];
    NSString *oldPrice = [voucherDetailsDic objectForKey:@"money_use"];
    oldPL.text = [NSString stringWithFormat:@"¥%@",oldPrice];
    [BaseUtil setCenterLineView:oldPL];

    
    //减
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reduceBtn.frame = CGRectMake(11, priceL.bottom + 26, 34, 34);
    [reduceBtn setBackgroundImage:[UIImage imageNamed:@"icon_coupon_reduce"] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(didClickReduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:reduceBtn];
    
    //数量
    _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _numberBtn.frame = CGRectMake(50, priceL.bottom + 26, 59, 34);
    [_numberBtn setTitle:@"0" forState:UIControlStateNormal];
    _numberBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_numberBtn setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [view addSubview:_numberBtn];
    
    //加
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(114, priceL.bottom + 26, 34, 34);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"icon_coupon_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];

    
}
- (void)didClickReduceBtn:(UIButton *)button
{
    if (numberP < 1) {
        return;
    } else {
        numberP--;
        [_numberBtn setTitle:[NSString stringWithFormat:@"%d",numberP] forState:UIControlStateNormal];
        _nameL.text = [NSString stringWithFormat:@"合计：%.2f",numberP*[self.priceStr floatValue]];
        _allPrice = numberP*[self.priceStr floatValue];

    }

}
- (void)didClickAddBtn:(UIButton *)button
{
    numberP++;
    
    [_numberBtn setTitle:[NSString stringWithFormat:@"%d",numberP]  forState:UIControlStateNormal];

    _nameL.text = [NSString stringWithFormat:@"合计：%.2f",numberP*[self.priceStr floatValue]];
    _allPrice = numberP*[self.priceStr floatValue];

}
- (void)setupSecondViewWithView:(UIView *)view{
    UILabel *methodL = [self createLWithFrame:CGRectMake(10, 18, 110, 16) font:16 textColor:@"4e4e4e" superView:view];
    methodL.text = @"选择支付方式:";
        //翼支付
    _bestPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bestPayBtn.frame = CGRectMake(125, 20, 70, 13);
    [_bestPayBtn setTitle:@"翼支付" forState:UIControlStateNormal];
    [_bestPayBtn setImage:[UIImage imageNamed:@"convenience_select"] forState:UIControlStateNormal];
    [_bestPayBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [_bestPayBtn setTitleColor:k_color(@"808080") forState:UIControlStateNormal];
    
    [_bestPayBtn addTarget:self action:@selector(didClickBestPayAction:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:_bestPayBtn];
    //支付宝
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(125, 20, 70, 13);
    [_payButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [_payButton setTitleColor:k_color(@"808080") forState:UIControlStateNormal];
    [_payButton setImage:[UIImage imageNamed:@"convenience_select"] forState:UIControlStateNormal];
    [_payButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [_payButton addTarget:self action:@selector(didClickPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_payButton];
    
}
//点击翼支付
- (void)didClickBestPayAction:(UIButton *)button
{
    self.payment = @"2";
    [_payButton setImage:[UIImage imageNamed:@"convenience_uncheck"] forState:UIControlStateNormal];
    [_bestPayBtn setImage:[UIImage imageNamed:@"convenience_select"] forState:UIControlStateNormal];


}
//点击支付
- (void)didClickPayAction:(UIButton *)button
{
    self.payment = @"1";
    [_payButton setImage:[UIImage imageNamed:@"convenience_select"] forState:UIControlStateNormal];
    [_bestPayBtn setImage:[UIImage imageNamed:@"convenience_uncheck"] forState:UIControlStateNormal];

}
- (void)setupThirdViewWithView:(UIView *)view{
    
    _nameL = [self createLWithFrame:CGRectMake(10, 17.5, 200, 16) font:16 textColor:@"333333" superView:view];
    _nameL.text = [NSString stringWithFormat:@"合计："];
    
    [self createBttWithFrame:CGRectMake(23, view.bottom + 12.5, self.view.width - 46, 39) imageName:@"" title:@"提交订单" action:@selector(SubmitOrdersAction:) superView:_myScrollView tag:0 textColor:nil imageEdgeInset:UIEdgeInsetsZero backgroudImage:@"确定"];
    
}


- (void)SubmitOrdersAction:(UIButton *)sender{
    NSLog(@"提交订单======");
    
        if (_allPrice && [CMCUserManager shareManager].token) {
            NSDictionary *voucherDetailsDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"voucherDetails"];
            NSString *content = [NSString stringWithFormat:@"%@,%@",[voucherDetailsDic objectForKey:@"id"],[NSString stringWithFormat:@"%d",numberP]];
            NSDictionary *postDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":[voucherDetailsDic objectForKey:@"zid"],@"mid":[voucherDetailsDic objectForKey:@"mid"],@"service_id":@"5",@"money":[NSString stringWithFormat:@"%.2f",_allPrice],@"express_money":@"",@"content":content,@"address_id":@"",@"payment":self.payment,@"comment":@"",@"timestamp":kAPI_timestamp};
            NSString *sig = [BaseUtil getSigWithArray:postDic];
            
            NSDictionary *postDic2 = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":[voucherDetailsDic objectForKey:@"zid"],@"mid":[voucherDetailsDic objectForKey:@"mid"],@"service_id":@"5",@"money":[NSString stringWithFormat:@"%.2f",_allPrice],@"express_money":@"",@"content":content,@"address_id":@"",@"payment":self.payment,@"comment":@"",@"timestamp":kAPI_timestamp,@"sig":[BaseUtil md5:sig]};
            NSLog(@"%@",KAPI_UserNewOrder);
            NSLog(@"postDic ======%@",postDic);
            [BaseUtil post:KAPI_UserNewOrder postBody:postDic2 success:^(id responseObj) {
                NSLog(@"提交订单====== %@",responseObj);
                NSDictionary *infoDic = [responseObj objectForKey:@"info"];
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    if ([responseObj objectForKey:@"data"]) {
                        NSDictionary *dataDic = [responseObj objectForKey:@"data"];
                        NSString *order_id = [dataDic objectForKey:@"order_id"];
                        [self orderPayWithOrder_id:order_id];
                        
                        
                    }
                }
                
                
                
            } ailure:^(NSError *error) {
                
            }];
        
        }
    
 
    
}


- (void)orderPayWithOrder_id:(NSString *)order_id{
    
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":order_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_orderPay(order_id, timestamp, sig);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"----------resopObject === %@",respondObject);
        if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"0"]) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            NSString *money = [dataDic objectForKey:@"money"];
            NSString *order_id = [dataDic objectForKey:@"order_id"];
            NSLog(@"kAPI_NotifyURL  %@",kAPI_NotifyURL);
//            NSString *payment_type = [dataDic objectForKey:@"payment_type"];
            
            //翼支付
            if ([self.payment integerValue] == 2) {
                
                CMCBestPayModel *model = [[CMCBestPayModel alloc] init];
                [model bestWithOrder_id:order_id money:money];
            }
            //支付宝
            if ([self.payment integerValue] == 1) {
                
                [BaseUtil PaymentForGoodsTradeNO:order_id productName:self.title amount:money];

                
            }
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}




#pragma mark - 公共方法 －
//创建label
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
}



- (void)createBttWithFrame:(CGRect)frame
                 imageName:(NSString *)imageName
                     title:(NSString *)title
                    action:(SEL)action
                 superView:(UIView *)superView
                       tag:(int)tag
                 textColor:(NSString *)color
            imageEdgeInset:(UIEdgeInsets)edgeInsets
            backgroudImage:(NSString *)backImgName{
    UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
    btt.frame = frame;
    [btt setTitle:title forState:UIControlStateNormal];
    [btt addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btt.titleLabel.font = [UIFont systemFontOfSize:13];
    [btt setTitleColor:k_color(color) forState:UIControlStateNormal];
//    btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [btt setBackgroundImage:[UIImage imageNamed:backImgName] forState:UIControlStateNormal];
    btt.imageEdgeInsets = edgeInsets;
    btt.tag = tag;
    [btt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [superView addSubview:btt];
    
}



#pragma mark end
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
