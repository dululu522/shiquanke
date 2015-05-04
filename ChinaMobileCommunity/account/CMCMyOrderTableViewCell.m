//
//  CMCMyOrderTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//
#import "CMCMyOrderTableViewCell.h"

@implementation CMCMyOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatMyOrderCell:(CMCMyOrder *)myOrder
{

    [_shopNameLabel removeFromSuperview];
    [_timeLabel removeFromSuperview];
    [_typeLabel removeFromSuperview];
    [_statusLabel removeFromSuperview];
    //店铺名称
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.contentView.frame.size.width/2-10, 13)];
    _shopNameLabel.text = myOrder.merchant_name;
    _shopNameLabel.textColor = k_color(@"3a3a3a");
    _shopNameLabel.font = k_font(13);
    [self.contentView addSubview:_shopNameLabel];
    
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2, 18, self.contentView.frame.size.width/2-10, 11)];
    _timeLabel.font = k_font(11);
    _timeLabel.textColor = k_color(@"424242");
    _timeLabel.text = [BaseUtil becomeNormalWithString:myOrder.create_time];
    [self.contentView addSubview:_timeLabel];
    //类型:点菜,预订,外卖,购物,买单...
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _shopNameLabel.bottom+19, self.contentView.frame.size.width/2-10, 13)];
    _typeLabel.font = k_font(12);
    _typeLabel.textColor = k_color(@"424242");
    _typeLabel.text = [self.serviceDic objectForKey:myOrder.service_id];
    [self.contentView addSubview:_typeLabel];
    //状态:已接单,未接单,已完成,已拒单...
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.origin.x, _typeLabel.frame.origin.y, _timeLabel.frame.size.width, 12)];
    
   NSString *process = [self.processDic objectForKey:myOrder.service_id];
    NSArray *proceArr = [k_order objectForKey:process];
    for (NSDictionary *tempDic in proceArr) {
        NSString *state = [tempDic objectForKey:@"state"];
        if ([state intValue] == [myOrder.state intValue]) {
            _statusLabel.text = [tempDic objectForKey:@"text"];
            break;
        }
    }
    
    _statusLabel.font = k_font(12);
    _statusLabel.textColor = k_color(@"424242");
    [self.contentView addSubview:_statusLabel];

}

@end
