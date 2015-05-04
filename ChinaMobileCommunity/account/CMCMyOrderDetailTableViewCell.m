//
//  CMCMyOrderDetailTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderDetailTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
@interface CMCMyOrderDetailTableViewCell ()
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *order_num;
@property (nonatomic, strong) NSString *shop_name;
@property (nonatomic, strong) NSString *goodsinfo;



@end

@implementation CMCMyOrderDetailTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatMyOrderDetailCell
{
    NSLog(@"self.myOrderDetailDic %@",self.myOrderDetailDic);
    //店铺名称
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, self.frame.size.width/2-10, 15)];
    _shopNameLabel.font = k_font(15);
    _shopNameLabel.textColor = k_color(@"444444");
    [self.contentView addSubview:_shopNameLabel];
    //是否接单
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 12, self.frame.size.width/2-10, 13)];

    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.textColor = k_color(@"555555");
    _statusLabel.font = k_font(13.0);
    [self.contentView addSubview:_statusLabel];
    
    //类型
    _typelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shopNameLabel.bottom + 12, _shopNameLabel.frame.size.width, 13)];
    _typelabel.textColor = k_color(@"666666");
    _typelabel.font = k_font(13);

    [self.contentView addSubview:_typelabel];
    //订单号
    _orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_statusLabel.frame.origin.x, _typelabel.frame.origin.y, _shopNameLabel.frame.size.width, 13)];
    _orderNumberLabel.font = k_font(13);
    _orderNumberLabel.textColor = k_color(@"666666");

    _orderNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_orderNumberLabel];
    //下单时间
    UILabel *_orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _typelabel.bottom + 12, self.frame.size.width-20, 13)];
    _orderTimeLabel.font = k_font(13);
    _orderTimeLabel.textColor = k_color(@"666666");

    [self.contentView addSubview:_orderTimeLabel];
    //商家电话
    _shopPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _orderTimeLabel.bottom+9, self.frame.size.width - 20, 13)];
    _shopPhoneLabel.textColor = k_color(@"666666");
    _shopPhoneLabel.font = k_font(13);
    [self.contentView addSubview:_shopPhoneLabel];
    
    //商家地址
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shopPhoneLabel.bottom+9, self.frame.size.width - 20, 13)];
    _addressLabel.textColor = k_color(@"666666");
    _addressLabel.font = k_font(12.0);
    [self.contentView addSubview:_addressLabel];
    
    UIImage *phoneImage = [UIImage imageNamed:@"myOrder_phone"];
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(self.frame.size.width - 55, 80, phoneImage.size.width, phoneImage.size.height);
    [phoneBtn setBackgroundImage:phoneImage forState:UIControlStateNormal];
    phoneBtn.userInteractionEnabled = YES;
    [phoneBtn addTarget:self action:@selector(didClickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneBtn];
    if (self.myOrderDetailDic) {
            _shopNameLabel.text = [self.myOrderDetailDic objectForKey:@"merchant_name"];
        
//            _statusLabel.text = status;
//            _typelabel.text = type;
            _orderNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",[self.myOrderDetailDic objectForKey:@"order_id"]];
        NSString *time = [BaseUtil becomeNormalWithString:[self.myOrderDetailDic objectForKey:@"create_time"]];
            _orderTimeLabel.text = [NSString stringWithFormat:@"下单时间:%@",time];
        _addressLabel.text = [self.myOrderDetailDic objectForKey:@"merchant_address"];
        if ([self.myOrderDetailDic objectForKey:@"merchant_phone"]) {
            _shopPhoneLabel.text = [NSString stringWithFormat:@"商家电话: %@",[self.myOrderDetailDic objectForKey:@"merchant_phone"]];
        }
//        NSString *address = [self.myOrderDetailDic objectForKey:@"address"];
//        _shopPhoneLabel.text = [NSString stringWithFormat:@"商家电话:",[self.myOrderDetailDic objectForKey:@"merchant_address"]];

        

    }



}
- (void)creatMyOrderDetailCellStatus:(NSString *)status type:(NSString *)type name:(NSString *)name time:(NSString *)time orderNumber:(NSString *)orderNumber
{

//    //店铺名称
//    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, self.frame.size.width/2-10, 15)];
//    _shopNameLabel.text = name;
//    _shopNameLabel.font = k_font(15);
//    _shopNameLabel.textColor = k_color(@"444444");
//    [self.contentView addSubview:_shopNameLabel];
//    //是否接单
//    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 12, self.frame.size.width/2-10, 13)];
//    _statusLabel.text = status;
//    _statusLabel.textAlignment = NSTextAlignmentCenter;
//    _statusLabel.textColor = k_color(@"555555");
//    _statusLabel.font = k_font(13.0);
//    [self.contentView addSubview:_statusLabel];
//    
//    //类型
//    _typelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shopNameLabel.bottom + 12, _shopNameLabel.frame.size.width, 13)];
//    _typelabel.textColor = k_color(@"666666");
//    _typelabel.font = k_font(13);
//    _typelabel.text = type;
//    [self.contentView addSubview:_typelabel];
//  //订单号
//    _orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_statusLabel.frame.origin.x, _typelabel.frame.origin.y, _shopNameLabel.frame.size.width, 13)];
//    _orderNumberLabel.font = k_font(13);
//    _orderNumberLabel.textColor = k_color(@"666666");
//    _orderNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",orderNumber];
//    _orderNumberLabel.textAlignment = NSTextAlignmentRight;
//    [self.contentView addSubview:_orderNumberLabel];
//    //下单时间
//    UILabel *_orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _typelabel.bottom + 12, self.frame.size.width-20, 13)];
//    _orderTimeLabel.font = k_font(13);
//    _orderTimeLabel.textColor = k_color(@"666666");
//    _orderTimeLabel.text = [NSString stringWithFormat:@"下单时间:%@",time];
//    [self.contentView addSubview:_orderTimeLabel];
//    //商家电话
//    _shopPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _orderTimeLabel.bottom+9, self.frame.size.width - 20, 13)];
//    _shopPhoneLabel.text = @"商家电话:";
//    _shopPhoneLabel.textColor = k_color(@"666666");
//    _shopPhoneLabel.font = k_font(13);
//    [self.contentView addSubview:_shopPhoneLabel];
//
////商家地址
//    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shopPhoneLabel.bottom+9, self.frame.size.width - 20, 13)];
//    _addressLabel.textColor = k_color(@"666666");
//    _addressLabel.font = k_font(12.0);
//    _addressLabel.text = @"苹果园你南路通景大厦702室";
//    [self.contentView addSubview:_addressLabel];
//    
//    UIImage *phoneImage = [UIImage imageNamed:@"myOrder_phone"];
//    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    phoneBtn.frame = CGRectMake(self.frame.size.width - 55, 80, phoneImage.size.width, phoneImage.size.height);
//    [phoneBtn setBackgroundImage:phoneImage forState:UIControlStateNormal];
//    phoneBtn.userInteractionEnabled = YES;
//    [phoneBtn addTarget:self action:@selector(didClickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:phoneBtn];

}
- (void)didClickPhoneButton:(UIButton *)button
{



}
- (void)creatMyOrderDetailCopyLabelText:(NSString *)copyText priceText:(NSString *)price onlinePay:(NSString *)onlinePay note:(NSString *)note
{


}
// 创建订单详情 总价 线上支付 备注
- (void)creatMyOrderDetailCopyLabelText
{
    [_totalLabel removeFromSuperview];
    [_copyLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    [_onlinePayLabel removeFromSuperview];
    [_noteLabel removeFromSuperview];
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 14)];
    _totalLabel.text = @"总价";
    _totalLabel.font = k_font(14);
    
    _totalLabel.textColor = k_color(@"666666");
    
    [self.contentView addSubview:_totalLabel];
    
    _copyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2- 20, 10, 40, 14)];
    _copyLabel.text = @"4份";
    _copyLabel.textColor = k_color(@"666666");
    _copyLabel.font = k_font(14);
    [self.contentView addSubview:_copyLabel];
    
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, 10, 90, 14)];
    _priceLabel.text = @"￥36";
    _priceLabel.textColor = k_color(@"666666");
    _priceLabel.font = k_font(14);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    
    _onlinePayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalLabel.bottom + 5, self.frame.size.width - 20, 14)];
    _onlinePayLabel.text = @"线上支付:未付款";
    _onlinePayLabel.textColor = k_color(@"666666");
    _onlinePayLabel.font = k_font(14.0);
    [self.contentView addSubview:_onlinePayLabel];
    
    _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _onlinePayLabel.bottom + 5, self.frame.size.width - 20, 14)];
    _noteLabel.textColor = k_color(@"666666");
    _noteLabel.font = k_font(14.0);
    _noteLabel.text = @"备注";
    [self.contentView addSubview:_noteLabel];


}
- (void)creatName:(NSString *)name phone:(NSString *)phone
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 14)];
    nameLabel.textColor = k_color(@"666666");
    nameLabel.font = k_font(14);
    [self.contentView addSubview:nameLabel];

    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nameLabel.bottom + 10, self.frame.size.width - 20, 14)];
    telLabel.textColor = k_color(@"666666");
    telLabel.font = k_font(14);
    [self.contentView addSubview:telLabel];
    if ([self.myOrderDetailDic objectForKey:@"address"]) {
        NSString *address =[self.myOrderDetailDic objectForKey:@"address"];
        NSArray *addressArr = [address componentsSeparatedByString:@","];
        nameLabel.text = [addressArr objectAtIndex:1];
        telLabel.text = [addressArr objectAtIndex:0];
    }
}

- (void)creatName:(NSString *)name phone:(NSString *)phone address:(NSString *)address
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 14)];
    nameLabel.text = name;
    nameLabel.textColor = k_color(@"666666");
    nameLabel.font = k_font(14);
    [self.contentView addSubview:nameLabel];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nameLabel.bottom + 10, self.frame.size.width - 20, 14)];
    telLabel.text = phone;
    telLabel.textColor = k_color(@"666666");
    telLabel.font = k_font(14);
    [self.contentView addSubview:telLabel];
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, telLabel.bottom + 10, self.frame.size.width - 20, 14)];
    addressLabel.text = address;
    addressLabel.textColor = k_color(@"666666");
    addressLabel.font = k_font(14);
    [self.contentView addSubview:addressLabel];
}
@end
