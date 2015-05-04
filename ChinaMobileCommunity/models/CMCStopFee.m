//
//  CMCStopFee.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCStopFee.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation CMCStopFee

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatStopFeeCar_number:(NSString *)car_number park_number:(NSString *)park_number park_price:(NSString *)park_price over_time:(NSString *)over_time real_name:(NSString *)real_name
{
    number = 0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.bounds.size.width, 600);
    [self addSubview:scrollView];
    //缴费信息
    UIImageView *PaymentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, self.bounds.size.width, 40)];
    PaymentImageView.image = [UIImage imageNamed:@"waterDetail"];
    PaymentImageView.backgroundColor = [UIColor greenColor];
    PaymentImageView.userInteractionEnabled = YES;
    [scrollView addSubview:PaymentImageView];
    //    [self creatView:PaymentImageView titleText:@" 缴费信息:" imageNamed:@"缴费_07"];
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 25, 14)];
    logImageView.image = [UIImage imageNamed:@"缴费_07"];
    [PaymentImageView addSubview:logImageView];
    UILabel *paymentlabel = [[UILabel alloc] initWithFrame:CGRectMake(logImageView.frame.origin.x + logImageView.frame.size.width, 0, 100, PaymentImageView.frame.size.height)];
    paymentlabel.font = [UIFont fontWithName:nil size:17.0];
    paymentlabel.text = @"  缴费信息:";
    paymentlabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [PaymentImageView addSubview:paymentlabel];
    
    
    
    
    //姓名
    
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, PaymentImageView.frame.size.height+PaymentImageView.frame.origin.y, self.bounds.size.width, 40)];
    [scrollView addSubview:nameImageView];
    nameImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    
    UIImageView *logNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 13, 18, 15)];
    logNameImageView.image = [UIImage imageNamed:@"userName"];
    [nameImageView addSubview:logNameImageView];
    
    UITextField *paymentNamelabelField = [[UITextField alloc] initWithFrame:CGRectMake(logNameImageView.frame.origin.x + logNameImageView.frame.size.width, 0, 100, nameImageView.frame.size.height)];
    paymentNamelabelField.font = [UIFont fontWithName:nil size:17.0];
    paymentNamelabelField.text = [NSString stringWithFormat:@" %@",real_name];
    paymentNamelabelField.textColor = [UIColor colorWithHexString:@"666666"];
    [nameImageView addSubview:paymentNamelabelField];
    
    
    
    
    //地图
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameImageView.frame.size.height+nameImageView.frame.origin.y, self.bounds.size.width, 40)];
    [scrollView addSubview:mapImageView];
    mapImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    //    mapImageView.userInteractionEnabled = YES;
    UIImageView *logMapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 13, 15, 18)];
    logMapImageView.image = [UIImage imageNamed:@"地_03"];
    [mapImageView addSubview:logMapImageView];
    
    UILabel *paymentMaplabel = [[UILabel alloc] initWithFrame:CGRectMake(logMapImageView.frame.origin.x + logMapImageView.frame.size.width, 0, self.frame.size.width - 43, mapImageView.frame.size.height)];
        paymentMaplabel.font = [UIFont fontWithName:nil size:17.0];
    paymentMaplabel.text = [CMCUserManager shareManager].currentAddress;
    paymentMaplabel.textColor = [UIColor colorWithHexString:@"666666"];
    [mapImageView addSubview:paymentMaplabel];
    

    //详细地址
    UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, mapImageView.frame.size.height+mapImageView.frame.origin.y, self.bounds.size.width, 60)];
    [scrollView addSubview:addressImageView];
    addressImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    addressImageView.backgroundColor = [UIColor orangeColor];
    //    [self creatView:addressImageView titleText:@" 详细地址" imageNamed:nil];
    //
    //
    UIImageView *logAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    //    logAddressImageView.image = [UIImage imageNamed:@"地_03"];
    [mapImageView addSubview:logMapImageView];
    UILabel *paymentAddresslabel = [[UILabel alloc] initWithFrame:CGRectMake(logAddressImageView.frame.origin.x , 0, 150, 40)];
    paymentAddresslabel.font = [UIFont fontWithName:nil size:17.0];
    paymentAddresslabel.text = [NSString stringWithFormat:@"详细地址: "];
     paymentAddresslabel.textColor = [UIColor colorWithHexString:@"666666"];
    [addressImageView addSubview:paymentAddresslabel];
    
     UILabel *detailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(logAddressImageView.frame.origin.x + logAddressImageView.frame.size.width, 30, self.frame.size.width - 50, 20)];
    detailAddressLabel.text = self.address;
     detailAddressLabel.textColor = [UIColor colorWithHexString:@"666666"];
    detailAddressLabel.font = [UIFont systemFontOfSize:12.0];
    [addressImageView addSubview:detailAddressLabel];
    
    //代缴费信息
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, addressImageView.frame.size.height+addressImageView.frame.origin.y + 21, self.bounds.size.width, 46)];
    [scrollView addSubview:billImageView];
    billImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    billImageView.userInteractionEnabled = YES;

    UILabel *paymentBilllabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, billImageView.frame.size.height)];
    paymentBilllabel.font = [UIFont fontWithName:nil size:17.0];
    paymentBilllabel.text = [NSString stringWithFormat:@"车牌号:%@",car_number];
    paymentBilllabel.textColor = [UIColor colorWithHexString:@"666666"];

    [billImageView addSubview:paymentBilllabel];
    //
    
    
    
    //时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, billImageView.frame.size.height+billImageView.frame.origin.y , self.bounds.size.width, 40)];
    timeImageView.userInteractionEnabled = YES;
    [scrollView addSubview:timeImageView];
    timeImageView.image = [UIImage imageNamed:@"waterDetail"];
    

    UILabel *paymentTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, timeImageView.frame.size.height)];
    paymentTimelabel.font = [UIFont fontWithName:nil size:17.0];
    paymentTimelabel.text = [NSString stringWithFormat:@"车位号:%@号",park_number];
    paymentTimelabel.textColor = [UIColor colorWithHexString:@"666666"];

    [timeImageView addSubview:paymentTimelabel];
    
    
    
    
    
    
    //吨数
    UIImageView *tonnageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, timeImageView.frame.size.height+timeImageView.frame.origin.y, self.bounds.size.width, 40)];
    tonnageImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    [scrollView addSubview:tonnageImageView];
    
    //    UIImageView *logTonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    //    [tonnageImageView addSubview:logTonImageView];
    
    UILabel *paymentTonlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, tonnageImageView.frame.size.height)];
    //    paymentTonlabel.font = [UIFont fontWithName:nil size:17.0];
    paymentTonlabel.text = @"缴费时长:";
    paymentTonlabel.textColor = [UIColor colorWithHexString:@"666666"];

    [tonnageImageView addSubview:paymentTonlabel];
    
    //金额
    
    UIImageView *amountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tonnageImageView.frame.size.height+tonnageImageView.frame.origin.y, self.bounds.size.width, 40)];
    [scrollView addSubview:amountImageView];
    amountImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    addressImageView.backgroundColor = [UIColor orangeColor];
    
    //    UIImageView *logAmountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    //    //    logAddressImageView.image = [UIImage imageNamed:@"地_03"];
    //    [amountImageView addSubview:logAmountImageView];
    UILabel *paymentAmountlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, amountImageView.frame.size.height)];
    paymentAmountlabel.font = [UIFont fontWithName:nil size:17.0];
    paymentAmountlabel.text = [NSString stringWithFormat:@"缴费金额:%@元",park_price];
    self.price = park_price;
    paymentAmountlabel.textColor = [UIColor colorWithHexString:@"666666"];

    [amountImageView addSubview:paymentAmountlabel];
    
    //到期时间
    UIImageView *dueTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, amountImageView.frame.size.height+amountImageView.frame.origin.y, self.bounds.size.width, 40)];
    [scrollView addSubview:dueTimeImageView];
    dueTimeImageView.image = [UIImage imageNamed:@"waterDetail"];
    UILabel *dueTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, amountImageView.frame.size.height)];
    dueTimelabel.font = [UIFont fontWithName:nil size:17.0];
    dueTimelabel.text = [NSString stringWithFormat:@"到期时间:%@",over_time];
    dueTimelabel.textColor = [UIColor colorWithHexString:@"666666"];

    [dueTimeImageView addSubview:dueTimelabel];
    
    
    
    //
    //支付方式
    UIImageView *methodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, dueTimeImageView.frame.size.height+dueTimeImageView.frame.origin.y + 10, self.bounds.size.width, 40)];
    [scrollView addSubview:methodPayImageView];
    methodPayImageView.userInteractionEnabled = YES;
    methodPayImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    addressImageView.backgroundColor = [UIColor orangeColor];
    //    [self creatView:methodPayImageView titleText:@" 支付方式:" imageNamed:@"小车_07"];
    UIImageView *logMethodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 18, 14)];
    logMethodPayImageView.userInteractionEnabled = YES;
    logMethodPayImageView.image = [UIImage imageNamed:@"shopCar"];
    [methodPayImageView addSubview:logMethodPayImageView];
    UILabel *paymentMethodlabel = [[UILabel alloc] initWithFrame:CGRectMake(logMethodPayImageView.frame.origin.x + logMethodPayImageView.frame.size.width, 0, 90, dueTimeImageView.frame.size.height)];
    paymentMethodlabel.font = [UIFont fontWithName:nil size:17.0];
    paymentMethodlabel.text = @"  支付方式:";
    paymentMethodlabel.textColor = [UIColor colorWithHexString:@"666666"];

    [methodPayImageView addSubview:paymentMethodlabel];
    
    //翼支付
    _selectButton = [[UIImageView alloc] initWithFrame:CGRectMake(paymentMethodlabel.frame.size.width + paymentMethodlabel.frame.origin.x + 5, paymentMethodlabel.frame.origin.y + 14, 15, 15)];
    _selectButton.image = [UIImage imageNamed:@"circle"];
    
    [methodPayImageView addSubview:_selectButton];
    UILabel *payTreasureLabel = [[UILabel alloc] initWithFrame:CGRectMake(_selectButton.frame.size.width+_selectButton.frame.origin.x + 5, 0, 70, 40)];
    payTreasureLabel.text = @"翼支付";
    payTreasureLabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];

    [methodPayImageView addSubview:payTreasureLabel];
    
    UIButton *payTreasureButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [payTreasureButton addTarget:self action:@selector(didClickpayTreasureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    payTreasureButton.frame = CGRectMake(paymentMethodlabel.frame.size.width + paymentMethodlabel.frame.origin.x + 5, 0, 90, 40);
    [methodPayImageView addSubview:payTreasureButton];
    //支付宝
    _payImageView = [[UIImageView alloc] initWithFrame:CGRectMake(payTreasureButton.frame.size.width + payTreasureButton.frame.origin.x + 5, paymentMethodlabel.frame.origin.y + 14, 15, 15)];
    _payImageView.image = [UIImage imageNamed:@"circle_select"];
    _payImageView.userInteractionEnabled = YES;
    [methodPayImageView addSubview:_payImageView];
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(_payImageView.frame.size.width+_payImageView.frame.origin.x + 5, 0, 80, 40)];
    payLabel.text = @"支付宝";
    payLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [methodPayImageView addSubview:payLabel];
    
    UIButton *payButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [payButton addTarget:self action:@selector(didClickpayButton:) forControlEvents:UIControlEventTouchUpInside];
    payButton.frame = CGRectMake(_payImageView.frame.origin.x, 0, 100, 40);
    [methodPayImageView addSubview:payButton];

    
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(60, methodPayImageView.frame.size.height+methodPayImageView.frame.origin.y + 17, self.bounds.size.width - 120, 40)];
    okButton.backgroundColor = kAPI_AllMainColor;
    okButton.layer.cornerRadius = 10;
    [okButton setTintColor:[UIColor whiteColor]];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(didClickOkButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:okButton];




}
//点击翼支付
- (void)didClickpayTreasureButton:(UIButton *)button
{
//    ++number;
//    if (number % 2 != 0) {
        _selectButton.image = [UIImage imageNamed:@"circle_select"];
        _payImageView.image = [UIImage imageNamed:@"circle"];
//    } else {
//        
//        _selectButton.image = [UIImage imageNamed:@"circle"];
//        
//        
//    }
    number = 0;
    
    
}
//点击支付宝
- (void)didClickpayButton:(UIButton *)button
{
    _selectButton.image = [UIImage imageNamed:@"circle"];
    _payImageView.image = [UIImage imageNamed:@"circle_select"];;
    number = 1;
}
- (void)didClickOkButton:(UIButton *)button
{
    if (number == 1) {
        Order *order = [[Order alloc] init];
        order.partner = PartnerID;
        order.seller = SellerID;
        order.tradeNO = self.order_id;//订单id
        NSLog(@"==========%@",order.tradeNO);
        
        order.productName = @"停车费"; //商品标题
        order.productDescription = @"停车费";//商品描述
        order.amount = self.price;//商品价格
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
            NSLog(@"=======%@",resultDic);
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

    }else{
    
 
    }




}


@end
