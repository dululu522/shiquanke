//
//  CneeInfoCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CneeInfoCell.h"
#import "GTMBase64.h"

@implementation CneeInfoCell


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
    
    NSArray *detailArr = [self.myModel.address componentsSeparatedByString:@","];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(15, 10, self.width - 30, self.height - 20);
    label.textColor = [UIColor colorWithHexString:@"666666"];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    
    //购物类
//    NSString *cate = [BaseUtil returnCategoryWithService_id:self.dataModel.service_id];
    
   //点菜，房源信息,预约洗车,预约装饰,家政服务,到店美发,到店修脚,到店美甲，到店美容,上门美容
    
//    [self.dataModel.service_id isEqualToString:@"1"] | [self.dataModel.service_id isEqualToString:@"8"] | [self.dataModel.service_id isEqualToString:@"9"] | [self.dataModel.service_id isEqualToString:@"10"] | [self.dataModel.service_id isEqualToString:@"7"] | [self.dataModel.service_id isEqualToString:@"22"] | [self.dataModel.service_id isEqualToString:@"17"] | [self.dataModel.service_id isEqualToString:@"23"] | [self.dataModel.service_id isEqualToString:@"21"]| [self.dataModel.service_id isEqualToString:@"21"]
    
    if ([[BaseUtil returnProcessWithService_id:self.dataModel.service_id] isEqualToString:@"S"] | [self.dataModel.service_id isEqualToString:@"7"] | [self.dataModel.service_id isEqualToString:@"8"]) {
        label.text = [NSString stringWithFormat:@"姓名：%@\n手机号：%@",detailArr[0],detailArr[1]];
    }else if([self.dataModel.service_id isEqualToString:@"4"]){//订座
        NSArray *tmpArr = [self.myModel.detail  componentsSeparatedByString:@"|"];
        NSString *sex;
        if ([tmpArr[4] isEqualToString:@"0"]) {
            sex = @"女士";//0为女
        }else{
            sex = @"先生";//1为男
        }
        
        label.text = [NSString stringWithFormat:@"姓名：%@\n性别：%@\n手机号：%@",detailArr[1],sex,detailArr[0]];
        
    }else if([self.dataModel.service_id isEqualToString:@"5"]){//优惠
        NSString *name;
        if (![CMCUserManager shareManager].nickname) {
            name = @"";
        }else{
            name = [CMCUserManager shareManager].nickname;
        }
        label.text = [NSString stringWithFormat:@"姓名：%@\n手机号：%@",name,k_phone];
        
    }else{
        NSString *string;
        if (detailArr.count == 3) {
            NSData *data = [GTMBase64 decodeString:detailArr[2]];
            string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        }else{
            string = @"";
        }
        
        label.text = [NSString stringWithFormat:@"姓名：%@\n手机号：%@\n地址：%@",detailArr[1],detailArr[0],string];
        
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *pra = [[NSMutableParagraphStyle alloc]init];
    [pra setLineSpacing:5];
    [attri addAttribute:NSParagraphStyleAttributeName value:pra range:NSMakeRange(0, label.text.length)];
    label.attributedText = attri;
    [self.contentView addSubview:label];
    
}

- (BOOL)returnIsHavePlaceYesOrNoWithCate:(NSString *)cate{
    if ([cate isEqualToString:@"汽车用品"]) {
        return YES;
    }
    if ([cate isEqualToString:@"外卖"]) {
        return YES;
    }
    if ([cate isEqualToString:@"购物"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门美容"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门装饰"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门洗车"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门美甲"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门修脚"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门按摩"]) {
        return YES;
    }
    if ([cate isEqualToString:@"到店修脚"]) {
        return YES;
    }
    if ([cate isEqualToString:@"到店按摩"]) {
        return YES;
    }
    if ([cate isEqualToString:@"洗衣"]) {
        return YES;
    }
    if ([cate isEqualToString:@"修鞋"]) {
        return YES;
    }
    if ([cate isEqualToString:@"订座"]) {
        return YES;
    }
    
    
    return NO;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
