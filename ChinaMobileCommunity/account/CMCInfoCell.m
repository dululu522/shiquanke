//
//  CMCInfoCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCInfoCell.h"

@interface CMCInfoCell ()
{
    UILabel *phoneL;
}

@end

@implementation CMCInfoCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}


- (void)createSubViews{
    [self setupSubViews];
    
}

- (void)setupSubViews{
    
    //商家名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(15, 11, self.frame.size.width/2 - 15, 15) font:15 textColor:@"666666" superView:self.contentView];
    nameL.text = [NSString stringWithFormat:@"%@",self.dataModel.merchant_name];
    
    //状态
    UILabel *stateL = [self createLWithFrame:CGRectMake(nameL.right, nameL.top, self.width - nameL.right - 25, 13) font:13 textColor:@"666666" superView:self.contentView];
    stateL.textAlignment = NSTextAlignmentRight;
    NSString *text = [BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state];
    stateL.text = text;
    //状态图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(stateL.right, stateL.top, 15, 15);
    imageView.image = [UIImage imageNamed:@"已拒单"];
    [self.contentView addSubview:imageView];
    
    
    //点菜
    UILabel *cateL = [self createLWithFrame:CGRectMake(15, nameL.bottom + 15, 150, 15) font:15 textColor:@"666666" superView:self.contentView];
    cateL.text = [BaseUtil returnCategoryWithService_id:self.dataModel.service_id];
    
    
    
    //订单号
    UILabel *orderNumL = [self createLWithFrame:CGRectMake(cateL.right, cateL.top, self.width - cateL.right - 10, 13) font:13 textColor:@"666666" superView:self.contentView];
    orderNumL.textAlignment = NSTextAlignmentRight;
    orderNumL.text = [NSString stringWithFormat:@"订单号：%@",self.myModel.order_id];
    
    
    //下单时间
    UILabel *orderTimeL = [self createLWithFrame:CGRectMake(15, cateL.bottom + 15, 245, 15) font:15 textColor:@"666666" superView:self.contentView];
    NSString *time = [BaseUtil returnDateFrom1970:self.myModel.create_time];
    orderTimeL.text = [NSString stringWithFormat:@"下单时间：%@",time];
    
    
    //商家电话
    phoneL = [self createLWithFrame:CGRectMake(15, orderTimeL.bottom + 10, 245, 15) font:15 textColor:@"666666" superView:self.contentView];
    phoneL.text = [NSString stringWithFormat:@"商家电话：%@",self.myModel.merchant_phone];
    
    
    
    
   //商户地址
    CGRect rect = [BaseUtil returnHeightWithContent:[NSString stringWithFormat:@"商家地址：%@",self.myModel.merchant_address] WithFont:15 width:245 height:0];
    UILabel *placeL = [self createLWithFrame:CGRectMake(15, phoneL.bottom + 10, 245, rect.size.height) font:15 textColor:@"666666" superView:self.contentView];
    placeL.numberOfLines = 0;
    placeL.text = [NSString stringWithFormat:@"商家地址：%@",self.myModel.merchant_address];
    
    
    //打电话
    UIButton *callBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    callBtt.frame = CGRectMake(phoneL.right,80, 38, 38);
    [callBtt setImage:[UIImage imageNamed:@"myOrder_phone"] forState:UIControlStateNormal];
    [callBtt addTarget:self action:@selector(callPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:callBtt];
    
    //拒单
    if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已拒单"]) {
        
        //分割线
        UIView *sepeV = [[UIView alloc]init];
        sepeV.frame = CGRectMake(10,placeL.bottom + 11, self.width - 20, 0.5);
        sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [self.contentView addSubview:sepeV];
        
        
        //拒绝原因
        UILabel *resonL = [self createLWithFrame:CGRectMake(15, sepeV.bottom + 11, 245, 15) font:15 textColor:@"666666" superView:self.contentView];
        resonL.text = [NSString stringWithFormat:@"拒单原因：%@",self.dataModel.reply];//0316
    }
    
    
    
    
    
    
}

- (void)callPhoneAction:(UIButton *)sender{
//    NSArray *infoArr = [self.myModel.address componentsSeparatedByString:@","];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否拨打商户电话?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:[NSString stringWithFormat:@"电话：%@",self.myModel.merchant_phone], nil];
    [alertView show];
    
    
}

#pragma mark - alertViewDelegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.myModel.merchant_phone]]];
    }
}


#pragma mark - 公共方法 －
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
