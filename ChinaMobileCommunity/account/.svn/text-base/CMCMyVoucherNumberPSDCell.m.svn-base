//
//  CMCMyVoucherNumberPSDCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyVoucherNumberPSDCell.h"

@implementation CMCMyVoucherNumberPSDCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self creatCell];

}
- (void)creatCell
{

    UILabel *numberLabel = [self createLWithFrame:CGRectMake(16, 5, self.frame.size.width - 32, 12) font:12 textColor:@"666666" superView:self.contentView];
    UILabel *psdLabel = [self createLWithFrame:CGRectMake(16,numberLabel.bottom+5, self.frame.size.width - 32, 12) font:12 textColor:@"666666" superView:self.contentView];
        numberLabel.text = [NSString stringWithFormat:@"券号:%@",self.couponDetail.code];
        psdLabel.text = [NSString stringWithFormat:@"密码:%@",self.couponDetail.pass];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
