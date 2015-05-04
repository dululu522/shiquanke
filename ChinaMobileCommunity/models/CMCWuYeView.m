//
//  CMCWuYeView.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCWuYeView.h"



@implementation CMCWuYeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatWuyeView:(NSDictionary *)dic
{
    [_paymentAddresslabel removeFromSuperview];
    [_paymentNamelabelField removeFromSuperview];
    [_paymentTimelabel removeFromSuperview];
    [_paymentTonlabel removeFromSuperview];
    [_paymentAmountlabel removeFromSuperview];
    [_unitAmountlabel removeFromSuperview];
    count = 0;
    self.order_id = [dic objectForKey:@"id"]; //订单号
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.frame.size.width, 650);
    [self addSubview:scrollView];
    //缴费信息
    UIImageView *PaymentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, self.frame.size.width, 40)];
    PaymentImageView.image = [UIImage imageNamed:@"waterDetail"];
    PaymentImageView.userInteractionEnabled = YES;
    [scrollView addSubview:PaymentImageView];
    //    [self creatView:PaymentImageView titleText:@" 缴费信息:" imageNamed:@"缴费_07"];
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 25, 14)];
    logImageView.image = [UIImage imageNamed:@"缴费_07"];
    [PaymentImageView addSubview:logImageView];
    UILabel *paymentlabel = [[UILabel alloc] initWithFrame:CGRectMake(logImageView.frame.origin.x + logImageView.frame.size.width, 0, 100, PaymentImageView.frame.size.height)];
    paymentlabel.font = [UIFont fontWithName:nil size:17.0];
    paymentlabel.text = @"  业主信息:";
    paymentlabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [PaymentImageView addSubview:paymentlabel];
    //姓名
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, PaymentImageView.frame.size.height+PaymentImageView.frame.origin.y, self.frame.size.width, 40)];
    [scrollView addSubview:nameImageView];
    nameImageView.image = [UIImage imageNamed:@"waterDetail"];
    UIImageView *logNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 13, 18, 15)];
    logNameImageView.image = [UIImage imageNamed:@"userName"];
    [nameImageView addSubview:logNameImageView];
    
    _paymentNamelabelField = [[UITextField alloc] initWithFrame:CGRectMake(logNameImageView.frame.origin.x + logNameImageView.frame.size.width, 0, 100, nameImageView.frame.size.height)];
    
    _paymentNamelabelField.font = [UIFont fontWithName:nil size:13.0];
    _paymentNamelabelField.text = [NSString stringWithFormat:@" 姓名:%@",[dic objectForKey:@"name"]];
    _paymentNamelabelField.textColor = [UIColor colorWithHexString:@"666666"];
    [nameImageView addSubview:_paymentNamelabelField];
    
    
    
    
    //地图
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameImageView.frame.size.height+nameImageView.frame.origin.y, self.frame.size.width, 40)];
    [scrollView addSubview:mapImageView];
    mapImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    //    mapImageView.userInteractionEnabled = YES;
    
    UIImageView *logMapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 13, 15, 18)];
    logMapImageView.image = [UIImage imageNamed:@"地_03"];
    [mapImageView addSubview:logMapImageView];
    
    UILabel *paymentMaplabel = [[UILabel alloc] initWithFrame:CGRectMake(logMapImageView.frame.origin.x + logMapImageView.frame.size.width, 0, self.frame.size.width - 43, mapImageView.frame.size.height)];
    paymentMaplabel.text = [NSString stringWithFormat:@" %@",[CMCUserManager shareManager].currentAddress];
    paymentMaplabel.font = [UIFont systemFontOfSize:13.0];
    paymentMaplabel.textColor = [UIColor colorWithHexString:@"666666"];
    [mapImageView addSubview:paymentMaplabel];
    //
    //
    //详细地址
    UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, mapImageView.frame.size.height+mapImageView.frame.origin.y, self.frame.size.width, 60)];
    [scrollView addSubview:addressImageView];
    addressImageView.image = [UIImage imageNamed:@"waterDetail"];
    addressImageView.userInteractionEnabled = YES;
    
    UIImageView *logAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    logAddressImageView.userInteractionEnabled = YES;
    [mapImageView addSubview:logMapImageView];
    _paymentAddresslabel = [[UILabel alloc] initWithFrame:CGRectMake(logAddressImageView.frame.origin.x , 0, self.frame.size.width - 50, 40)];
    _paymentAddresslabel.font = [UIFont fontWithName:nil size:13.0];
    _paymentAddresslabel.text = [NSString stringWithFormat:@"详细地址:"];
    _paymentAddresslabel.textColor = [UIColor colorWithHexString:@"666666"];
    
    [addressImageView addSubview:_paymentAddresslabel];
    UILabel *detailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(logAddressImageView.frame.origin.x + logAddressImageView.frame.size.width, 30, self.frame.size.width - 50, 20)];
    detailAddressLabel.text = [dic objectForKey:@"address"];
    detailAddressLabel.font = [UIFont systemFontOfSize:12.0];
    detailAddressLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [addressImageView addSubview:detailAddressLabel];
    
    UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addressButton.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    [addressButton addTarget:self action:@selector(didClickAddressButton) forControlEvents:UIControlEventTouchUpInside];
    [addressImageView addSubview:addressButton];
    //
    //
    //
    //
    //代缴费信息
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, addressImageView.frame.size.height+addressImageView.frame.origin.y + 21, self.frame.size.width, 46)];
    [scrollView addSubview:billImageView];
    billImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    billImageView.userInteractionEnabled = YES;
    
    UIImageView *logBillImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 25, 14)];
    logBillImageView.image = [UIImage imageNamed:@"钱_19"];
    [billImageView addSubview:logBillImageView];
    UILabel *paymentBilllabel = [[UILabel alloc] initWithFrame:CGRectMake(logBillImageView.frame.origin.x + logBillImageView.frame.size.width, 0, 100, billImageView.frame.size.height)];
    paymentBilllabel.font = [UIFont fontWithName:nil size:17.0];
    paymentBilllabel.text = @"  代缴费信息:";
    paymentBilllabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [billImageView addSubview:paymentBilllabel];
    //
    
    
    
    //时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, billImageView.frame.size.height+billImageView.frame.origin.y , self.frame.size.width, 40)];
    timeImageView.userInteractionEnabled = YES;
    [scrollView addSubview:timeImageView];
    timeImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    addressImageView.backgroundColor = [UIColor orangeColor];
    
    UIImageView *logTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    //    logAddressImageView.image = [UIImage imageNamed:@"地_03"];
    [billImageView addSubview:logTimeImageView];
    _paymentTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(logTimeImageView.frame.origin.x + logTimeImageView.frame.size.width, 0, 250, timeImageView.frame.size.height)];
    _paymentTimelabel.font = [UIFont fontWithName:nil size:13.0];
    NSString *start_time = [BaseUtil becomeNormalWithString:[dic objectForKey:@"start_time"]];
    NSString *over_time = [BaseUtil becomeNormalWithString:[dic objectForKey:@"over_time"]];
    _paymentTimelabel.text = [NSString stringWithFormat:@"缴费周期:%@至%@",start_time,over_time];
    
    _paymentTimelabel.textColor = [UIColor colorWithHexString:@"666666"];
    [timeImageView addSubview:_paymentTimelabel];
    
    //吨数
    UIImageView *unitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, timeImageView.frame.size.height+timeImageView.frame.origin.y, self.frame.size.width, 40)];
    [scrollView addSubview:unitImageView];
    unitImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    UIImageView *unitAmountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    //    logAddressImageView.image = [UIImage imageNamed:@"地_03"];
    [unitImageView addSubview:unitAmountImageView];
    _unitAmountlabel = [[UILabel alloc] initWithFrame:CGRectMake(unitAmountImageView.frame.origin.x + unitAmountImageView.frame.size.width, 0, 250, unitImageView.frame.size.height)];
    _unitAmountlabel.font = [UIFont fontWithName:nil size:13.0];
    if ([self.category isEqualToString:@"物业费"] | [self.category isEqualToString:@"停车费"]) {
            _unitAmountlabel.text = [NSString stringWithFormat:@"月份: %@个月",[dic objectForKey:@"month"]];
    }
    if ([self.category isEqualToString:@"水费"]) {
                    _unitAmountlabel.text = [NSString stringWithFormat:@"吨数: %@吨",[dic objectForKey:@"month"]];
    }
    if ([self.category isEqualToString:@"电费"]) {
         _unitAmountlabel.text = [NSString stringWithFormat:@"用量: %@度",[dic objectForKey:@"month"]];
    }
    
    if ([self.category isEqualToString:@"煤气费"]) {
        _unitAmountlabel.text = [NSString stringWithFormat:@"体积: %@立方米",[dic objectForKey:@"month"]];
    }
//    _priceText = price;
    _unitAmountlabel.textColor = [UIColor colorWithHexString:@"666666"];
    [unitImageView addSubview:_unitAmountlabel];
    
    UIImageView *amountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, unitImageView.frame.size.height+unitImageView.frame.origin.y, self.frame.size.width, 40)];
    [scrollView addSubview:amountImageView];
    amountImageView.image = [UIImage imageNamed:@"waterDetail"];
    
    addressImageView.backgroundColor = [UIColor orangeColor];
    UIImageView *logAmountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 10)];
    [amountImageView addSubview:logAmountImageView];
    _paymentAmountlabel = [[UILabel alloc] initWithFrame:CGRectMake(logAmountImageView.frame.origin.x + logAmountImageView.frame.size.width, 0, 250, amountImageView.frame.size.height)];
    _paymentAmountlabel.font = [UIFont fontWithName:nil size:13.0];
    
    _paymentAmountlabel.text = [NSString stringWithFormat:@"金额: ￥%@",[dic objectForKey:@"money"]];
//    _priceText = price;
    _paymentAmountlabel.textColor = [UIColor colorWithHexString:@"666666"];
    [amountImageView addSubview:_paymentAmountlabel];
    
    //判断是否缴费
    if ([[dic objectForKey:@"state"] intValue] == 0) {
        //备注
        UIImageView *noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, amountImageView.frame.size.height+amountImageView.frame.origin.y + 15, self.frame.size.width, 40)];
        [scrollView addSubview:noteImageView];
        noteImageView.userInteractionEnabled = YES;
        noteImageView.image = [UIImage imageNamed:@"waterDetail"];
        
        addressImageView.backgroundColor = [UIColor orangeColor];
        //    [self creatView:methodPayImageView titleText:@" 支付方式:" imageNamed:@"小车_07"];
        UIImageView *notePayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 18, 28)];
        notePayImageView.userInteractionEnabled = YES;
        [noteImageView addSubview:notePayImageView];
        UILabel *notelabel = [[UILabel alloc] initWithFrame:CGRectMake(notePayImageView.frame.origin.x + notePayImageView.frame.size.width, 0, self.frame.size.width - 40, noteImageView.frame.size.height)];
        notelabel.font = [UIFont fontWithName:nil size:13.0];
        notelabel.numberOfLines = 0;
        notelabel.text = [NSString stringWithFormat:@"  备注:%@",[dic objectForKey:@"comment"]];
        notelabel.textColor = [UIColor colorWithHexString:@"666666"];
        [noteImageView addSubview:notelabel];
        
        //    支付方式
        //    支付宝
        UIImageView *methodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, noteImageView.frame.size.height+noteImageView.frame.origin.y + 15, self.frame.size.width, 40)];
        [scrollView addSubview:methodPayImageView];
        methodPayImageView.userInteractionEnabled = YES;
        methodPayImageView.image = [UIImage imageNamed:@"waterDetail"];
        
        addressImageView.backgroundColor = [UIColor orangeColor];
        UIImageView *logMethodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 18, 14)];
        logMethodPayImageView.userInteractionEnabled = YES;
        logMethodPayImageView.image = [UIImage imageNamed:@"shopCar"];
        [methodPayImageView addSubview:logMethodPayImageView];
        UILabel *paymentMethodlabel = [[UILabel alloc] initWithFrame:CGRectMake(logMethodPayImageView.frame.origin.x + logMethodPayImageView.frame.size.width, 0, 90, methodPayImageView.frame.size.height)];
        paymentMethodlabel.font = [UIFont fontWithName:nil size:13.0];
        paymentMethodlabel.text = @"  支付方式:";
        paymentMethodlabel.textColor = [UIColor colorWithHexString:@"666666"];
        [methodPayImageView addSubview:paymentMethodlabel];
        _selectButton = [[UIImageView alloc] initWithFrame:CGRectMake(paymentMethodlabel.frame.size.width + paymentMethodlabel.frame.origin.x + 5, paymentMethodlabel.frame.origin.y + 14, 15, 15)];
        _selectButton.image = [UIImage imageNamed:@"circle_select"];
        
        [methodPayImageView addSubview:_selectButton];
        UILabel *payTreasureLabel = [[UILabel alloc] initWithFrame:CGRectMake(_selectButton.frame.size.width+_selectButton.frame.origin.x + 5, 0, 70, 40)];
        payTreasureLabel.text = @"支付宝";
        payTreasureLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [methodPayImageView addSubview:payTreasureLabel];
        
        
        UIButton *okButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(20, methodPayImageView.frame.size.height+methodPayImageView.frame.origin.y + 15, self.frame.size.width - 40, 40);
        [scrollView addSubview:okButton];
        okButton.layer.cornerRadius = 5;
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        okButton.backgroundColor = kAPI_AllMainColor;
        [okButton addTarget:self action:@selector(didClickOkButton:) forControlEvents:UIControlEventTouchUpInside];

        
    } else {
    
        //缴费时间
        UIImageView *noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, amountImageView.frame.size.height+amountImageView.frame.origin.y + 15, self.frame.size.width, 40)];
        [scrollView addSubview:noteImageView];
        noteImageView.userInteractionEnabled = YES;
        noteImageView.image = [UIImage imageNamed:@"waterDetail"];
        
        addressImageView.backgroundColor = [UIColor orangeColor];
        //    [self creatView:methodPayImageView titleText:@" 支付方式:" imageNamed:@"小车_07"];
        UIImageView *notePayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 18, 28)];
        notePayImageView.userInteractionEnabled = YES;
        [noteImageView addSubview:notePayImageView];
        UILabel *notelabel = [[UILabel alloc] initWithFrame:CGRectMake(notePayImageView.frame.origin.x + notePayImageView.frame.size.width, 0, self.frame.size.width - 40, noteImageView.frame.size.height)];
        notelabel.font = [UIFont fontWithName:nil size:13.0];
        notelabel.numberOfLines = 0;
        NSString *update_time = [BaseUtil becomeNormalWithString:[dic objectForKey:@"update_time"]];
        notelabel.text = [NSString stringWithFormat:@"  缴费时间:%@",update_time];
        notelabel.textColor = [UIColor colorWithHexString:@"666666"];
        [noteImageView addSubview:notelabel];
        
        //   备注
        UIImageView *methodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, noteImageView.frame.size.height+noteImageView.frame.origin.y, self.frame.size.width, 80)];
        [scrollView addSubview:methodPayImageView];
        methodPayImageView.userInteractionEnabled = YES;
        methodPayImageView.image = [UIImage imageNamed:@"waterDetail"];
        
        addressImageView.backgroundColor = [UIColor orangeColor];
        UIImageView *logMethodPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 18, 14)];
        logMethodPayImageView.userInteractionEnabled = YES;
        [methodPayImageView addSubview:logMethodPayImageView];
        UILabel *paymentMethodlabel = [[UILabel alloc] initWithFrame:CGRectMake(logMethodPayImageView.frame.origin.x + logMethodPayImageView.frame.size.width, 0, self.frame.size.width - 40, methodPayImageView.frame.size.height )];
        paymentMethodlabel.font = [UIFont fontWithName:nil size:13.0];
        paymentMethodlabel.numberOfLines = 0;
        paymentMethodlabel.text = [NSString stringWithFormat:@"  备注:%@",[dic objectForKey:@"comment"]];
        paymentMethodlabel.textColor = [UIColor colorWithHexString:@"666666"];
        [methodPayImageView addSubview:paymentMethodlabel];
        
//        UIImage *image = [UIImage imageNamed:@"paycostFee"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, noteImageView.bottom -10, 73, 57)];
        imageView.image = [UIImage imageNamed:@"alreadypay"];
        [scrollView addSubview:imageView];


    
    
    }
    
    
}

- (void)creatViewPriceText:(NSString *)price address:(NSString *)address real_name:(NSString *)realName time:(NSString *)time unitTitle:(NSString *)unitTitle unitNumber:(NSString *)unumber uint:(NSString *)uint
{
    



}
- (void)didClickAddressButton
{

    [self.delegate didClickItems];



}
- (void)didClickOkButton:(UIButton *)button
{
    

        NSString *timestamp = kAPI_timestamp;
        if ([CMCUserManager shareManager].token) {
                    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":self.order_id,@"payment":@"1",@"timestamp":timestamp};
            
            NSString *sig = KAPI_GetSig(dic);
            NSString *requestUrl = KAPI_propertyorderpay(timestamp, sig, [CMCUserManager shareManager].token, self.order_id,@"1");
            [BaseUtil get:requestUrl success:^(id respondObject) {
                NSLog(@"物业缴费订单支付 %@",respondObject);
                NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    if ([respondObject objectForKey:@"data"]) {
                        NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                        [BaseUtil reWritePayForGoodsPartnerID:[dataDic objectForKey:@"partner_id"] sellerID:[dataDic objectForKey:@"alipay"] price:[dataDic objectForKey:@"money"] orderNO:[dataDic objectForKey:@"order_id"] notifyURL:[dataDic objectForKey:@"notify"] subject:[dataDic objectForKey:@"subject"] privateKey:[dataDic objectForKey:@"partner_private_key"]];

                    }
                    
                }
            } failure:^(NSError *error) {
                
            }];
        }


}


@end
