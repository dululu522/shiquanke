//
//  CMCHouseInformationCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFoodModel.h"

@interface CMCHouseInformationCell : UITableViewCell
//@property (nonatomic, strong) CMCFoodModel *foodModel;
@property (nonatomic, strong) NSString *category;
- (void)creatHouseInformationCell:(CMCFoodModel *)foodModel;

@end
