//
//  CMCNetCommentsTVCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFoodDetailEvaluation.h"
@interface CMCNetCommentsTVCell : UITableViewCell
- (void)creatTableViewCellfoodDetail:(CMCFoodDetailEvaluation *)foodDetail;
- (void)creatLabel:(NSString *)labelText image:(NSString *)imageName;


@end
