//
//  CMCGoodsInfoCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCGoodsInfoCell.h"
#import "GTMBase64.h"

@interface CMCGoodsInfoCell ()
{
    UILabel *cash;
}
@end

@implementation CMCGoodsInfoCell

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
    //优惠
    if ([self.dataModel.service_id isEqualToString:@"5"]) {
        return;
    }
    //家政服务
    if ([self.dataModel.service_id  isEqualToString:@"7"]) {
        
        [self houseworking];
        
        
    }else if ([self.dataModel.service_id isEqualToString:@"8"]){//房源信息
        
        [self houseInfo];
        
    }else if ([self.dataModel.service_id isEqualToString:@"4"]){//订座
        
        [self preBook];
        
    }else{
        
        [self other];
        
    }
    
}
//家政服务
- (void)houseworking{
    UILabel *timeL = [self createLWithFrame:CGRectMake(15, 10, self.width - 30, 13) font:13 textColor:@"444444" superView:self.contentView];
    timeL.text = [NSString stringWithFormat:@"服务时间：%@",@"2015-09-01 15:32"];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,timeL.bottom + 12, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
    
    //备注
    UILabel *beizhuL = [self createLWithFrame:CGRectMake(15, sepeV.bottom + 10, self.width - 30, 13) font:13 textColor:@"444444" superView:self.contentView];
    beizhuL.text = [NSString stringWithFormat:@"备注：%@",self.dataModel.comment];
    
}

//房源信息
- (void)houseInfo{
    
    //0319
    NSArray *array = [self.myModel.detail componentsSeparatedByString:@"|"];
    NSString *string;
    if (array.count == 1) {
        string = [NSString stringWithFormat:@"看房时间：%@",array.firstObject];
    }else{
        //解码
        NSData *data = [GTMBase64 decodeString:array[1]];
        string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.contentView.width - 30, 180)];
    label.text = string;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:@"444444"];
    label.numberOfLines = 0;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:5];
    [attri addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, label.text.length)];
    label.attributedText = attri;
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,label.bottom + 5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
    //看房时间
    UILabel *timeL = [self createLWithFrame:CGRectMake(15, sepeV.bottom + 10, self.width - 30, 13) font:13 textColor:@"444444" superView:self.contentView];
    timeL.text = [NSString stringWithFormat:@"看房时间：%@",[BaseUtil becomeNormalWithString:self.myModel.create_time]];//看房时间是哪个字段不清楚
    
    
    
    //备注
    UILabel *beizhuL = [self createLWithFrame:CGRectMake(15, timeL.bottom + 10, self.width - 30, 13) font:13 textColor:@"444444" superView:self.contentView];
    beizhuL.text = [NSString stringWithFormat:@"备注：%@",self.dataModel.comment];
    
    
    
}

- (void)other{
    NSInteger totalNum = 0;
    float totalPrice = 0.0;
    NSArray *detailArr = [self.myModel.detail componentsSeparatedByString:@"|"];
    for (int i = 0; i < detailArr.count + 1; i++) {
        NSArray *tmpArr;
        if (i < detailArr.count) {
            tmpArr = [detailArr[i] componentsSeparatedByString:@","];
        }
        
        //菜的名字
        UILabel *nameL = [self createLWithFrame:CGRectMake(15, 10 + (13 + 10) * i, 135, 13) font:13 textColor:@"444444" superView:self.contentView];
        
        //解码
        NSData *data = [GTMBase64 decodeString:tmpArr[1]];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        nameL.text = string;//
        //多少份数
        UILabel *numL = [self createLWithFrame:CGRectMake(nameL.right, nameL.top, 50, 13) font:13 textColor:@"444444" superView:self.contentView];
        numL.text = [NSString stringWithFormat:@"%@份",tmpArr[2]];
        totalNum +=[tmpArr[2] integerValue];
        totalPrice += [tmpArr[2] integerValue] * [tmpArr[3] floatValue];
        //多少价格
        UILabel *priceL = [self createLWithFrame:CGRectMake(numL.right, numL.top, self.width - numL.right - 10, 13) font:13 textColor:@"444444" superView:self.contentView];
        priceL.textAlignment = NSTextAlignmentRight;
        priceL.text = [NSString stringWithFormat:@"¥%.2f",[tmpArr[3] floatValue] * [tmpArr[2] integerValue]];
        
        
        if (i == detailArr.count) {
            UIView *sepV = [[UIView alloc]init];
            sepV.frame = CGRectMake(10, 10 + (13 + 10) * i, self.width - 20, 0.5);
            sepV.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
            [self.contentView addSubview:sepV];
            
            nameL.frame = CGRectMake(15, sepV.bottom + 10, nameL.width, nameL.height);
            nameL.text = @"总价：";
            numL.frame = CGRectMake(numL.left, nameL.top, numL.width, numL.height);
            numL.text = [NSString stringWithFormat:@"%ld份",(long)totalNum];
            
            priceL.frame = CGRectMake(priceL.left, nameL.top, priceL.width, priceL.height);
            priceL.textColor = [UIColor redColor];
            priceL.text = [NSString stringWithFormat:@"¥%.2f",totalPrice];
        }
    }
    float y = 0.0;
    UILabel *payTypeL = [self createLWithFrame:CGRectMake(15,20 + 23 * (detailArr.count + 1), 200, 13) font:13 textColor:@"444444" superView:self.contentView];
    NSString *payment_type = [self returnWithPayment_type:self.dataModel.payment_type];
    if ([payment_type isEqualToString:@"货到付款"]) {
        payTypeL.text = [NSString stringWithFormat:@"线下支付：%@",@"货到付款"];
        y = payTypeL.bottom + 8;
    }else{
        payTypeL.text = [NSString stringWithFormat:@"线上支付：%@",payment_type];//0316
        
        if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已拒单"]) {
            cash = [self createLWithFrame:CGRectMake(15, payTypeL.bottom + 8, self.width - 30, 13) font:13 textColor:@"666666" superView:self.contentView];
            cash.text = @"现金退还方式：7个工作日之内退款至原支付方式";
            y = cash.bottom + 8;
        }
    }
    
    
    
    //物流费用(外卖类)
    NSString *process = [BaseUtil returnProcessWithService_id:self.dataModel.service_id];
    if ([process isEqualToString:@"H"]) {
        UILabel *expressL = [self createLWithFrame:CGRectMake(15, y, self.width - 30, 13) font:13 textColor:@"666666" superView:self.contentView];
        NSString *price = [NSString stringWithFormat:@"%.2f",(totalPrice + [self.dataModel.express_money floatValue])];
        
        expressL.text = [NSString stringWithFormat:@"总金额是%@元(含物流费%@元)",price,self.dataModel.express_money];
        
        UILabel *beizhuL = [self createLWithFrame:CGRectMake(15, expressL.bottom + 8, self.width - 30, 13) font:13 textColor:@"666666" superView:self.contentView];
        beizhuL.text = [NSString stringWithFormat:@"备注：%@",self.dataModel.comment];
        
    }else{
        
        UILabel *beizhuL = [self createLWithFrame:CGRectMake(15, y, self.width - 30, 13) font:13 textColor:@"666666" superView:self.contentView];
        beizhuL.text = [NSString stringWithFormat:@"备注：%@",self.dataModel.comment];
    }
    
    
    
    
    
    
}


//订做
- (void)preBook{
    NSArray *tmpArr = [self.myModel.detail componentsSeparatedByString:@"|"];
    if (tmpArr.count == 0) {
        return;
    }
    NSString *type;
    if ([tmpArr[0] isEqualToString:@"0"]) {
        type = @"散桌";
    }else{
        type = @"包间";
    }
    //    NSString *time = [Helper becomeNormalWithString:tmpArr[3]];
    NSArray *nameArr = @[@"预定类型",@"预定人数",@"预定座数",@"预定时间"];
    NSArray *contentArr = @[type,tmpArr[1],tmpArr[2],tmpArr[3]];
    UILabel *contentL;
    for (int i = 0; i < 4; i++) {
        UILabel *nameL = [self createLWithFrame:CGRectMake(15, 10 + 23 * i, 135, 13) font:13 textColor:@"444444" superView:self.contentView];
        nameL.text = nameArr[i];
        
        contentL = [self createLWithFrame:CGRectMake(nameL.right, nameL.top, 135, 13) font:13 textColor:@"444444" superView:self.contentView];
        contentL.text = contentArr[i];
        
    }
    
    UILabel *beizhuL = [self createLWithFrame:CGRectMake(15,contentL.bottom + 8, self.width - 30, 13) font:13 textColor:@"666666" superView:self.contentView];
    beizhuL.text = [NSString stringWithFormat:@"备注：%@",self.dataModel.comment];
    
    
}



#pragma mark - 公共方法 －
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [super addSubview:label];
    return label;
}

- (NSString *)returnWithPayment_type:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        return @"货到付款";
    }
    if ([type isEqualToString:@"1"]) {
        return @"支付宝";
    }
    
    if ([type isEqualToString:@"2"]) {
        return @"翼支付";
    }
    return nil;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
