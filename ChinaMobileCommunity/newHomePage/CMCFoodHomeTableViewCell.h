//
//  CMCFoodHomeTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFood.h"

@interface CMCFoodHomeTableViewCell : UITableViewCell
{

    UILabel *_dianCanlabel;
    UILabel *_schedulelabel;
    UILabel *_checklabel;
    UILabel *_takeoutlabel;
    UILabel *_couponlabel;
    UILabel *_timelabel;
}
- (void)creatcellfood:(CMCFood *)food;

@property (nonatomic, strong) UIImageView *photoImageView; //餐饮图片
@property (nonatomic, strong) UILabel *titleLabel; //名字
@property (nonatomic, strong) UILabel *distanceLabel; //距离
@property (nonatomic, strong) UILabel *tasteLabel;//口味
@property (nonatomic, strong) UIImageView *tasteImageView;//口味图片
@property (nonatomic, strong) UILabel *speedLabel;//速度
@property (nonatomic, strong) UIImageView *speedImageView;//速度图片
@property (nonatomic, strong) UILabel *severLabel;//服务
@property (nonatomic, strong) UIImageView *severImageView;//服务图片
@property (nonatomic, strong) UILabel *priceLabel;
@end
