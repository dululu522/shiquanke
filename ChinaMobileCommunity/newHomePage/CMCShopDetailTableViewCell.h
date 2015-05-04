//
//  CMCShopDetailTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCShopDetailTableViewCell : UITableViewCell
- (void)creatCell;
@property (nonatomic, strong) UIImageView *takeOutImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end
