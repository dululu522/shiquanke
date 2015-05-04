//
//  CMCHoseDetailCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-7.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFoodModel.h"
@interface CMCHoseDetailCell : UITableViewCell<UIAlertViewDelegate>

@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic, strong) CMCFoodModel *foodModel;

@end
