//
//  CMCPropertyFeeCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-12.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPropertyFeeCell.h"

@implementation CMCPropertyFeeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatPropertyFee:(CMCPropertyFeeList *)propertyFee
{
    [_timeLabel removeFromSuperview];
    [_feeStatusLabel removeFromSuperview];
    
    
    NSString *time = [BaseUtil becomeNormalWithString:propertyFee.create_time];
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 80, 44)];
    _timeLabel.text = [NSString stringWithFormat:@"%@ %@",time,propertyFee.comment];
    
    [self.contentView addSubview:_timeLabel];
    
    _feeStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 0, 60, 44)];
    if ([propertyFee.state intValue] == 0) {
        _feeStatusLabel.text = @"待缴费";
 
    }
    if ([propertyFee.state intValue] == 1) {
        _feeStatusLabel.text = @"已缴费";
    }
    [self.contentView addSubview:_feeStatusLabel];



}

@end
