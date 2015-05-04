//
//  CMCDiscountDetailCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDiscountDetailCell.h"

@implementation CMCDiscountDetailCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self createSubViews];
//    
//}


- (void)createSubViews{
    if ([self.category isEqualToString:@"折扣券详情"]) {
        //标题
        UILabel *nameL = [self createLWithFrame:CGRectMake(16, 7, 135, 11) font:11 textColor:@"656565" superView:self.contentView];
        nameL.text = @"肥牛套餐";
        
        //份数
        UILabel *numberL = [self createLWithFrame:CGRectMake(nameL.right, nameL.top, 50, 11) font:11 textColor:@"656565" superView:self.contentView];
        numberL.text = @"1份";
        
        //价格
        UILabel *priceL = [self createLWithFrame:CGRectMake(self.width - 11 - 100, 7, 100, 11) font:11 textColor:@"656565" superView:self.contentView];
        priceL.text = @"36元";
        priceL.textAlignment = NSTextAlignmentRight;
    }else{
        UILabel *contentL = [self createLWithFrame:CGRectMake(16, 6, self.width - 32, 50) font:12 textColor:@"666666" superView:self.contentView];
        contentL.text = @"本代金券为回馈广大消费者的支持特此发布";
    
    }
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


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

@end
