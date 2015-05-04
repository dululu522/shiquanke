//
//  CMCConvenientLifeListTVCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFood.h"
#import "CMCFoodDetail.h"
#import "StarView.h"
#import "CMCActivityLowest.h"

@interface CMCConvenientLifeListTVCell : UITableViewCell
{
    UILabel *_phoneLabel;
    UILabel *_shopNameLabel;
    UILabel *_evaluationLabel;
    StarView *_star;
    UILabel *_detailListLabel;
    
    UIImageView *_photoListImageView;
    UILabel *_shopNameListLabel;
//    UIImageView *_preferentialImagView;
//    UILabel *_mapListLabel;
//    UILabel *_timeListLabel;
    UILabel *_distanceLabel;
    
}
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
- (void)creatCell:(CMCFood *)food; //便利生活列表页 cell
- (void)creatDetailCell:(CMCFoodDetail *)foodDetail; //便利生活详情 cell
- (void)creatActivityLowest:(CMCActivityLowest *)food;
@end
