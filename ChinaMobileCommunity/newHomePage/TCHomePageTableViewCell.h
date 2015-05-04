//
//  TCHomePageTableViewCell.h
//  TelecomCommunity
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCHomePageMerchant.h"

@protocol TCHomePageTableViewCellDelegate <NSObject>

- (void)didClickItems:(NSInteger)merchant_id;

@end


@interface TCHomePageTableViewCell : UITableViewCell
@property (nonatomic, assign) id<TCHomePageTableViewCellDelegate> delegate;

- (void)creatLabel:(NSArray *)labelTextArr imageStr:(NSArray *)imageUrlArr;


@end
