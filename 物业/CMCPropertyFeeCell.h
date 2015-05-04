//
//  CMCPropertyFeeCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-12.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCPropertyFeeList.h"

@interface CMCPropertyFeeCell : UITableViewCell
{
    UILabel *_timeLabel;
    UILabel *_feeStatusLabel;

}
- (void)creatPropertyFee:(CMCPropertyFeeList *)propertyFee;
@end
