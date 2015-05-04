//
//  CMCOrderConfirmationVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-31.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderConfirmationVC.h"
#import "CMCPaymentDetailsTableViewCell.h"

#import "MAddressViewController.h"
#import "AddAddressViewController.h"
#define k_color [UIColor colorWithHexString:@"808080"]


@interface CMCOrderConfirmationVC ()
{
    BOOL selectOne;
    BOOL selectTwo;
    UIScrollView *_scrollView;
    UIImageView * _onlinePaymentImageView;
    UIImageView * _cashDeliveryImageView;
    UIButton *_onlineButton;
    UIButton *_cashDeliveryButton;
    UILabel *_combinedLabel;
    UITextField *_paymentNamelabelTF;
    UITextField *_paymentMessagelabelTF;
    UILabel *_paymentAddresslabel;
    NetWorkRequest *_request;
    
    UIView *_buttomView;
    UILabel *_totalLabel;
    UIButton *_maidanButton;
    UILabel *_priceLabel;
    UITextField *_paymentMapTF;
    UITableView *_addressTableView;
    UIView *_addressBackView;
    UIButton *_add_addressBtn;//添加收货地址
    UIButton *_cancelButton; //取消
    
    UIImageView *_bestPayImageView;
    UILabel *_bestPayLabel; //翼支付
    UIButton *_bestButton;
    //支付宝
    UIImageView *_payImageView;
    UILabel *_payLabel; //支付宝
    UIButton *_payButton;
    NSInteger _isPay; //是支付还是翼支付
    UIView *_backView;
    
    
}
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSString *pay;
@property (nonatomic, strong) NSMutableArray *goods_nameArr;
@property (nonatomic, strong) NSMutableArray *idArr;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *numArr;
@property (nonatomic, strong) NSMutableArray *priceArr;

@property (nonatomic, strong) NSMutableArray *addressArr;//地址
@property (nonatomic, strong) NSMutableArray *mobile_phoneArr;//手机号
@property (nonatomic, strong) NSMutableArray *nameArr;//用户名
//@property (nonatomic, strong) NSMutableArray *address_idArr;
@property (nonatomic, strong) NSMutableDictionary *addressIdDic;//通过地址找出地址id


@property (nonatomic, strong) NSString *payment; //支付方式 1为线上付款，2为货到付款



@end

@implementation CMCOrderConfirmationVC
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.tempDic = nil;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAddressData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isPay = 0;
    self.addressIdDic = [[NSMutableDictionary alloc] init];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.idArr = [[NSMutableArray alloc] init];
    self.imageArr = [[NSMutableArray alloc] init];
    self.numArr = [[NSMutableArray alloc] init];
    self.priceArr = [[NSMutableArray alloc] init];
    
    self.addressArr = [[NSMutableArray alloc] init];
    self.mobile_phoneArr = [[NSMutableArray alloc] init];
    self.nameArr = [[NSMutableArray alloc] init];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    [self didClickOnlineButton:nil];
    self.title = @"订单确认";
    selectOne = NO;
    selectTwo = NO;
    [self creatTableView];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height - 270)];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 400);
    [self.view addSubview:_scrollView];
//        [self creatBackButton];
    [self creatScrollView];
    [self creatButtom];

    [self loadData];
    
}
#pragma mark-
#pragma mark- 创建scrollView上的控件

- (void)creatScrollView
{
//    [_scrollView removeFromSuperview];
    [_paymentNamelabelTF removeFromSuperview];
    

    UIImageView *_nameImageView;
    UIImageView *_callImageView;
    UIImageView *_logMapImageView;
    UIImageView *_addressImageView;
    UIImageView * _messageImageView;
    UIImageView * _payMethodImageView;
    UIImageView *_logMessageImageView;
    UILabel *_payMethodLabel;
    UILabel *_onlinePaymentLabel;
    UILabel *_cashDeliveryLabel;
    UIImageView *_logAddressImageView;

    [_nameImageView removeFromSuperview];
    [_paymentNamelabelTF removeFromSuperview];
    [_nameImageView removeFromSuperview];
    [_callImageView removeFromSuperview];
    [_addressImageView removeFromSuperview];
    [_logAddressImageView removeFromSuperview];
    [_paymentAddresslabel removeFromSuperview];
    [_messageImageView removeFromSuperview];
    [_logMessageImageView removeFromSuperview];
    [_paymentMessagelabelTF removeFromSuperview];
    [_payMethodImageView removeFromSuperview];
    [_payMethodLabel removeFromSuperview];
    [_onlinePaymentImageView removeFromSuperview];
    [_onlineButton removeFromSuperview];
    [_cashDeliveryImageView removeFromSuperview];
    [_cashDeliveryButton removeFromSuperview];
    [_cashDeliveryLabel removeFromSuperview];

     //姓名
    _nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 40)];
    [_scrollView addSubview:_nameImageView];
    _nameImageView.image = [UIImage imageNamed:@"waterDetail"];
    _nameImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_nameImageView];

    UIImageView *logNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 18, 15)];
    logNameImageView.image = [UIImage imageNamed:@"order_confirmPeople"];
    [_nameImageView addSubview:logNameImageView];
    _paymentNamelabelTF = [[UITextField alloc] initWithFrame:CGRectMake(logNameImageView.frame.origin.x + logNameImageView.frame.size.width, 0, 100, _nameImageView.frame.size.height)];
    _paymentNamelabelTF.userInteractionEnabled = NO;
    _paymentNamelabelTF.font = [UIFont fontWithName:nil size:17.0];
    _paymentNamelabelTF.textColor = k_color;
    if (self.addressArr.count == 0) {
        _paymentNamelabelTF.placeholder = @"姓名";
        
    } else{
        
        _paymentNamelabelTF.placeholder =  [self.addressArr objectAtIndex:0];
    }
    [_nameImageView addSubview:_paymentNamelabelTF];
    [_callImageView removeFromSuperview];
    [_logMapImageView removeFromSuperview];
    [_paymentMapTF removeFromSuperview];
    //电话
    _callImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nameImageView.frame.size.height+_nameImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    [_scrollView addSubview:_callImageView];
    _callImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    
    _logMapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 15, 18)];
    _logMapImageView.image = [UIImage imageNamed:@"order_confirmPhone"];
    
    [_callImageView addSubview:_logMapImageView];
    
    _paymentMapTF = [[UITextField alloc] initWithFrame:CGRectMake(_logMapImageView.frame.origin.x + _logMapImageView.frame.size.width, 0, 200, _callImageView.frame.size.height)];
    _paymentMapTF.placeholder = @"  手机号";
    _paymentMapTF.textColor = k_color;
    
    [_callImageView addSubview:_paymentMapTF];
    
    
    
    //收货地址
    _addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _callImageView.frame.size.height+_callImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    _addressImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_addressImageView];
    _addressImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    _logAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 15, 15)];
    _logAddressImageView.image = [UIImage imageNamed:@"order_confirmAddress"];
    [_addressImageView addSubview:_logAddressImageView];
    _logAddressImageView.userInteractionEnabled = YES;
    _paymentAddresslabel = [[UILabel alloc] initWithFrame:CGRectMake(_logAddressImageView.frame.origin.x + _logAddressImageView.frame.size.width, 0, 200, _addressImageView.frame.size.height)];
    _paymentAddresslabel.textColor = k_color;
    _paymentAddresslabel.font = [UIFont fontWithName:nil size:17.0];
    if (self.addressArr.count == 0) {
        _paymentAddresslabel.text = @"  收货地址";
        
    }
    [_addressImageView addSubview:_paymentAddresslabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTapGestureRecognizer:)];
    [_addressImageView addGestureRecognizer:tap];

    //留言
    _messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _addressImageView.frame.size.height+_addressImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    [_scrollView addSubview:_messageImageView];
    _messageImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    _logMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 15, 15)];
    _logMessageImageView.image = [UIImage imageNamed:@"order_confirmAsk"];
    _logMessageImageView.userInteractionEnabled = YES;
    
    [_messageImageView addSubview:_logMessageImageView];
    _paymentMessagelabelTF = [[UITextField alloc] initWithFrame:CGRectMake(_logMessageImageView.frame.origin.x + _logMessageImageView.frame.size.width+5, 0, 200, _messageImageView.frame.size.height)];
    _paymentNamelabelTF.delegate = self;
    _paymentMessagelabelTF.font = [UIFont fontWithName:nil size:17.0];
    _paymentMessagelabelTF.placeholder = @"如有特殊要求,请留言";
    _paymentMessagelabelTF.textColor = kAPI_color;
    _paymentMessagelabelTF.delegate = self;
    
    _messageImageView.userInteractionEnabled = YES;
    [_messageImageView addSubview:_paymentMessagelabelTF];

    //支付方式
    _payMethodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _messageImageView.frame.size.height+_messageImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    _payMethodImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    [_scrollView addSubview:_payMethodImageView];
    _payMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 40)];
    _payMethodLabel.text = @" 支付方式:";
    _payMethodLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    
    [_payMethodImageView addSubview:_payMethodLabel];



    //在线支付
    _onlinePaymentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _payMethodImageView.frame.size.height+_payMethodImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    _onlinePaymentImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_onlinePaymentImageView];
    
    _onlineButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 13, 15, 15)];
    [_onlinePaymentImageView addSubview:_onlineButton];
    _onlineButton.userInteractionEnabled = YES;
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"选_25.png"] forState:UIControlStateNormal];
    _onlinePaymentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_onlineButton.frame.origin.x + _onlineButton.frame.size.width+5, 0, 80, _onlinePaymentImageView.frame.size.height)];
    _onlinePaymentLabel.text = @"在线支付";
    _onlinePaymentLabel.textColor = k_color;
    [_onlinePaymentImageView addSubview:_onlinePaymentLabel];
    UIButton *tapOnlinePay = [UIButton buttonWithType:UIButtonTypeCustom];
    tapOnlinePay.frame = CGRectMake(_onlineButton.frame.origin.x, 0, 100, 40);
    [tapOnlinePay addTarget:self action:@selector(didClicktapOnlinePay:) forControlEvents:UIControlEventTouchUpInside];
    [_onlinePaymentImageView addSubview:tapOnlinePay];
    
    //翼支付
    _bestPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tapOnlinePay.frame.origin.x + tapOnlinePay.frame.size.width, 13, 15, 15)];
    [_onlinePaymentImageView addSubview:_bestPayImageView];
    _bestPayImageView.userInteractionEnabled = YES;
//    [_bestPayButton setBackgroundImage:[UIImage imageNamed:@"选_25.png"] forState:UIControlStateNormal];
    _bestPayImageView.image = [UIImage imageNamed:@"选_25.png"];
    _bestPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bestPayImageView.frame.origin.x + _bestPayImageView.frame.size.width+5, 0, 80, _onlinePaymentImageView.frame.size.height)];
    _bestPayLabel.text = @"翼支付";

    _bestPayLabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    [_onlinePaymentImageView addSubview:_bestPayLabel];
    
    _bestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bestButton.frame = CGRectMake(_bestPayImageView.frame.origin.x, 0, 100, 40);
    [_bestButton addTarget:self action:@selector(didClickbestButton:) forControlEvents:UIControlEventTouchUpInside];
    [_onlinePaymentImageView addSubview:_bestButton];
    
    
    //支付宝
    _payImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_bestButton.frame.origin.x + tapOnlinePay.frame.size.width, 13, 15, 15)];
    [_onlinePaymentImageView addSubview:_payImageView];
    _payImageView.userInteractionEnabled = YES;
    _payImageView.image = [UIImage imageNamed:@"未选_25"];
    _payLabel = [[UILabel alloc] initWithFrame:CGRectMake(_payImageView.frame.origin.x + _payImageView.frame.size.width+5, 0, 80, _onlinePaymentImageView.frame.size.height)];
    _payLabel.text = @"支付宝";
    _payLabel.textColor = k_color;
    [_onlinePaymentImageView addSubview:_payLabel];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(_payImageView.frame.origin.x, 0, 100, 40);
    [_payButton addTarget:self action:@selector(didClickPayButton:) forControlEvents:UIControlEventTouchUpInside];
    [_onlinePaymentImageView addSubview:_payButton];
    
    
    
    //货到付款
    _cashDeliveryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _onlinePaymentImageView.frame.size.height+_onlinePaymentImageView.frame.origin.y, self.view.bounds.size.width, 40)];
    [_scrollView addSubview:_cashDeliveryImageView];
    _cashDeliveryImageView.userInteractionEnabled = YES;
    _cashDeliveryButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 13, 15, 15)];
    _cashDeliveryButton.userInteractionEnabled = YES;
    [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"未选_25.png"] forState:UIControlStateNormal];
    [_cashDeliveryImageView addSubview:_cashDeliveryButton];
    
    
    _cashDeliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cashDeliveryButton.frame.origin.x + _cashDeliveryButton.frame.size.width+10, 0, 80, _cashDeliveryImageView.frame.size.height)];
    _cashDeliveryLabel.text = @" 货到付款";
    _cashDeliveryLabel.textColor = k_color;
    [_cashDeliveryImageView addSubview:_cashDeliveryLabel];
    UITapGestureRecognizer *cashDeliveryGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cashDeliveryGestureRecognizer:)];
    [_cashDeliveryImageView addGestureRecognizer:cashDeliveryGestureRecognizer];

}
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, self.view.bounds.size.width - 10, 150)];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
//UIImageView *_bestPayImageView;
//UILabel *_bestPayLabel; //翼支付
//UIButton *_bestButton;
////支付宝
//UIImageView *_payImageView;
//UILabel *_payLabel; //支付宝
//UIButton *_payButton;
//点击在线支付
- (void)didClicktapOnlinePay:(UIButton *)button
{
    self.payment = @"1";
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
    _bestPayImageView.image = [UIImage imageNamed:@"选_25"];
    _payImageView.image = [UIImage imageNamed:@"未选_25"];
    [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    
}
//点击翼支付
- (void)didClickbestButton:(UIButton *)button
{
    self.payment = @"2";
    _bestPayImageView.image = [UIImage imageNamed:@"选_25"];
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
   [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    _payImageView.image = [UIImage imageNamed:@"未选_25"];
    _isPay = 0;

}
//点击支付宝
- (void)didClickPayButton:(UIButton *)button
{
    self.payment = @"1";
    _bestPayImageView.image = [UIImage imageNamed:@"未选_25"];
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
   [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    _payImageView.image = [UIImage imageNamed:@"选_25"];
    _isPay = 1;

}
//点击货到付款
- (void)cashDeliveryGestureRecognizer:(UITapGestureRecognizer *)tap
{
    self.payment = @"0";
    [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    _bestPayImageView.image = [UIImage imageNamed:@"未选_25"];
    _payImageView.image = [UIImage imageNamed:@"未选_25"];


}
#pragma mark -
#pragma mark - 点击收货地址

- (void)didClickTapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    
    //    AddAddressViewController *addDressVC = [[AddAddressViewController alloc] init];
    //    addDressVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:addDressVC animated:YES];
    //点击地址后的数据遮罩
    _addressBackView = [[UIView alloc] initWithFrame:self.view.bounds];
    _addressBackView.backgroundColor = [UIColor blackColor];
    _addressBackView.alpha = 0.5;
    [self.view addSubview:_addressBackView];

    //在遮罩上添加手势
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAddressTap:)];
    [_addressBackView addGestureRecognizer:addressTap];
    
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height /2 - 80, self.view.frame.size.width - 20, 220)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    //点击地址可以进行数据的更改
    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height /2 - 80, self.view.frame.size.width - 20, 160)];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    [BaseUtil setExtraCellLineHidden:_addressTableView];
    [self.view addSubview:_addressTableView];

    _add_addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _add_addressBtn.backgroundColor = kAPI_AllMainColor;
    _add_addressBtn.frame = CGRectMake(20, _addressTableView.frame.size.height +_addressTableView.frame.origin.y + 10, 100, 40);
    [_add_addressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    _add_addressBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_add_addressBtn addTarget:self action:@selector(didClickAdd_addressBtn:) forControlEvents:UIControlEventTouchUpInside];
    _add_addressBtn.layer.cornerRadius = 5;
    [_add_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_add_addressBtn];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(self.view.frame.size.width - 120, _addressTableView.frame.size.height +_addressTableView.frame.origin.y + 10, 100, 40);
    [_cancelButton addTarget:self action:@selector(didClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelButton.backgroundColor = kAPI_AllMainColor;
    _cancelButton.layer.cornerRadius = 5;
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_cancelButton];
    
    
    
}
#pragma mark-
#pragma mark- 遮罩上添加的手势

- (void)didClickAddressTap:(UITapGestureRecognizer *)tap
{
    [_addressBackView removeFromSuperview];
    [_addressTableView removeFromSuperview];
    [_add_addressBtn removeFromSuperview];
    [_cancelButton removeFromSuperview];
    [_backView removeFromSuperview];

}
#pragma mark -
#pragma mark - 取消按钮
- (void)didClickCancelButton:(UIButton *)button
{
    [self loadAddressData];
    [self creatScrollView];
    [_addressBackView removeFromSuperview];
    [_addressTableView removeFromSuperview];
    [_add_addressBtn removeFromSuperview];
    [_cancelButton removeFromSuperview];
    [_backView removeFromSuperview];


}
//添加收货地址
#pragma mark - 
#pragma mark - 添加收货地址
- (void)didClickAdd_addressBtn:(UIButton *)button
{
    MAddressViewController *addVC = [[MAddressViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}
#pragma mark -
#pragma mark - 创建底部栏
- (void)creatButtom
{
    
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height + _scrollView.frame.origin.y , self.view.bounds.size.width, 64)];
    [self.view addSubview:_buttomView];
    _buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_buttomView];
    UIImageView *shopCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
    shopCarImageView.image = [UIImage imageNamed:@"shopCar"];
    [_buttomView addSubview:shopCarImageView];
    
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCarImageView.frame.size.width +10 , 10, 40, 50)];
    [_buttomView addSubview:_totalLabel];
    _totalLabel.text = @"合计:";
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_totalLabel.frame.size.width + _totalLabel.frame.origin.x, _totalLabel.frame.origin.y, 120, 50)];
    
    [_buttomView addSubview:_priceLabel];
    
    
    //买单
    _maidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_maidanButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [_buttomView addSubview:_maidanButton];
    [_maidanButton addTarget:self action:@selector(didClickMaiDanButton:) forControlEvents:UIControlEventTouchUpInside];
    [_maidanButton setTitle:@"完成" forState:UIControlStateNormal];
    
    _maidanButton.frame = CGRectMake(self.view.bounds.size.width - 95, 20, 80, 30);
    
    
    
    
    
}


#pragma mark -
#pragma mark - //获取地址,姓名,电话数据
- (void)loadAddressData
{
//    if ([CMCUserManager shareManager].token) {
//        NSString *sig =  KAPI_MyaddressSig([CMCUserManager shareManager].token);
//        NSString *requestStr = KAPI_Myaddress([CMCUserManager shareManager].token, [BaseUtil md5:sig]);
//        [_request loadDataWithURLString:requestStr];
//    } else {
//        CMCLoginViewController *logVC = [[CMCLoginViewController alloc] init];
//        [self.navigationController pushViewController:logVC animated:YES];
//        
//    }
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_paymentMessagelabelTF resignFirstResponder];
    [_paymentNamelabelTF resignFirstResponder];
    
    return YES;
    
    
}

#pragma mark -
#pragma mark - 点击完成按钮
- (void)didClickMaiDanButton:(UIButton *)button
{
    if (_isPay == 1) {
        NSString *payStr = _paymentMessagelabelTF.text;
        if (payStr.length == 0) {
            payStr = @"0";
        }
        NSMutableArray *goodslistArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.goods_nameArr.count; i++) {
            NSDictionary *dic = @{@"id":[self.idArr objectAtIndex:i],@"num":[self.numArr objectAtIndex:i]};
            [goodslistArr addObject:dic];
        }
        if ([self.addressIdDic objectForKey:_paymentAddresslabel.text] == nil) {
            [BaseUtil toast:@"你还没有收货地址,请添加"];
            return;
        }
        if ([CMCUserManager shareManager].token) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"store_id":self.store_id,@"type":@"2",@"address_id":[self.addressIdDic objectForKey:_paymentAddresslabel.text],@"comment":payStr,@"goodslist":goodslistArr,@"payment":self.payment};
            NSDictionary *requestDic = [BaseUtil postString:[dic JSONString] postUrlString:KAPI_GetSubmitorder];
            
            
            NSDictionary *infoDic = [requestDic objectForKey:@"info"];
            if ([[infoDic objectForKey:@"info"] intValue] == 0) {
                [BaseUtil toast:@"提交订单成功"];
                NSDictionary *dataDic = [requestDic objectForKey:@"data"];
                NSDictionary *dataDic1 = [dataDic objectForKey:@"data"];
                //跳转到支付宝
                [BaseUtil PaymentForGoodsTradeNO:[dataDic1 objectForKey:@"order_id"] productName:@"外卖商品" amount:[dataDic1 objectForKey:@"pay"]];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        }

    }
    if (_isPay == 0) {
        
    }
}
- (void)loadData
{
    [self.goods_nameArr removeAllObjects];
    [self.idArr removeAllObjects];
    [self.imageArr removeAllObjects];
    [self.numArr removeAllObjects];
    [self.priceArr removeAllObjects];
    if ([self.tempDic objectForKey:@"goodslist"]) {
        NSArray *goodslistArr = [self.tempDic objectForKey:@"goodslist"];
        for (NSDictionary *tempDic in goodslistArr) {
            [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
            [self.idArr addObject:[tempDic objectForKey:@"id"]];
            [self.imageArr addObject:[tempDic objectForKey:@"image"]];
            [self.numArr addObject:[tempDic objectForKey:@"num"]];
            [self.priceArr addObject:[tempDic objectForKey:@"price"]];
        }
        
        self.pay = [self.tempDic objectForKey:@"pay"];
    }
    _priceLabel.text = [NSString stringWithFormat:@"￥%@元",self.pay];
    //
    [_tableView reloadData];

    
    
    
}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    [self.addressArr removeAllObjects];
    [self.mobile_phoneArr removeAllObjects];
    [self.nameArr removeAllObjects];
    [self.addressIdDic removeAllObjects];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"我的地址===%@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSArray *dataArr = [dic objectForKey:@"data"];
            for (NSDictionary *tempDic in dataArr) {
                [self.addressArr addObject:[tempDic objectForKey:@"address"]];
                [self.mobile_phoneArr addObject:[tempDic objectForKey:@"mobile_phone"]];
                [self.nameArr addObject:[tempDic objectForKey:@"name"]];
                [self.addressIdDic setObject:[tempDic objectForKey:@"id"] forKey:[tempDic objectForKey:@"address"]];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            _paymentMapTF.text = [NSString stringWithFormat:@"%@",[self.mobile_phoneArr objectAtIndex:0]];
            _paymentAddresslabel.text = [NSString stringWithFormat:@"%@",[self.addressArr objectAtIndex:0]];
            _paymentNamelabelTF.text = [NSString stringWithFormat:@"%@",[self.nameArr objectAtIndex:0]];
            [_addressTableView reloadData];
            
        }else {
            [BaseUtil toast:@"你还没有添加收货地址"];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
            
//            MAddressViewController *addVC = [[MAddressViewController alloc] init];
//            [self.navigationController pushViewController:addVC animated:YES];
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            
        }
    }
    
    
}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{
    
    
    
    
    
}
- (void)didClickOnlineButton:(UIButton *)button
{
    self.payment = @"1";
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
    [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    
}
//货到付款
- (void)didClickCashDeliveryButton:(UIButton *)button
{
    self.payment = @"0";
    [_cashDeliveryButton setBackgroundImage:[UIImage imageNamed:@"选_25"] forState:UIControlStateNormal];
    [_onlineButton setBackgroundImage:[UIImage imageNamed:@"未选_25"] forState:UIControlStateNormal];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return self.goods_nameArr.count;
        
    }
    if (_addressTableView == tableView) {
        return self.addressArr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == tableView) {
        static NSString *str = @"CMCPaymentDetailsTableViewCell";
        CMCPaymentDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCPaymentDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
        [cell creatPaymentDetailCellImage:[self.imageArr objectAtIndex:indexPath.row] nameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] additionalCopiesLabel:[self.numArr objectAtIndex:indexPath.row] priceLabel:[self.priceArr objectAtIndex:indexPath.row]];
        return cell;
    }
    if (_addressTableView == tableView) {
        static NSString *str = @"used";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = [self.addressArr objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == tableView) {
        return 60;
        
    }
    return 44;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_addressTableView == tableView) {
        
        _paymentMapTF.text = [NSString stringWithFormat:@"%@",[self.mobile_phoneArr objectAtIndex:indexPath.row]];
        _paymentAddresslabel.text = [NSString stringWithFormat:@"%@",[self.addressArr objectAtIndex:indexPath.row]];
        _paymentNamelabelTF.text = [NSString stringWithFormat:@"%@",[self.nameArr objectAtIndex:indexPath.row]];
        
        //移除_addressTableView
        [_addressBackView removeFromSuperview];
        [_addressTableView removeFromSuperview];
        [_add_addressBtn removeFromSuperview];
        [_cancelButton removeFromSuperview];
        [_backView removeFromSuperview];
    }
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (self.myTableView == tableView) {
    //        return 40;
    //    }
    if (self.tableView == tableView) {
        return 40;
        
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        UIView *sectionView = [[UIView alloc] init];
        //    self.myTableView.tableHeaderView = sectionView;
        sectionView.backgroundColor = [UIColor whiteColor];
        UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        //    shopImageView.backgroundColor = [UIColor greenColor];
        shopImageView.image = [UIImage imageNamed:@"shangjia"];
        [sectionView addSubview:shopImageView];
        
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopImageView.frame.size.width + shopImageView.frame.origin.x+5, 0, 250, 35)];
        _shopNameLabel.text = self.shopName;
        _shopNameLabel.textColor = [UIColor colorWithHexString:@"a2a2a2"];
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
    return nil;
    
    
}
- (void)didClickRightButton:(UIButton *)button
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
