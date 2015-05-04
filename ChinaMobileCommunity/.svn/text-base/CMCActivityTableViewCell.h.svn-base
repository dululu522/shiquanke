//
//  CMCActivityTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFood.h"
#import "CMCActivity.h"
#import "CMCActivityNewlyOpened.h"
#import "CMCActivityList.h"
#import "CMCActivityDetail.h"

@interface CMCActivityTableViewCell : UITableViewCell
{
    
    UILabel *_dianCanlabel;
    UILabel *_schedulelabel;
    UILabel *_checklabel;
    UILabel *_takeoutlabel;
    UILabel *_couponlabel;
    UILabel *_timelabel;
    //小区活动
    UIImageView *_photoImageView;
    UILabel *_nameLabel;
    UILabel *_placeLabel;
    UILabel *_endTimeLabel;
    UILabel *_activityTimeLabel;
    UIImageView *_newOpenedImageView;
    UILabel *_shopNewNameLabel;
    UILabel *_timeLabel;
    UILabel *_addressLabel;
}
@property (nonatomic, strong) UIImageView *photoImageView; //餐饮图片
@property (nonatomic, strong) UILabel *titleLabel; //名字
@property (nonatomic, strong) UILabel *distanceLabel; //距离
@property (nonatomic, strong) UILabel *tasteLabel;//口味
@property (nonatomic, strong) UIImageView *tasteImageView;//口味图片
@property (nonatomic, strong) UILabel *speedLabel;//速度
@property (nonatomic, strong) UIImageView *speedImageView;//速度图片
@property (nonatomic, strong) UILabel *severLabel;//服务
@property (nonatomic, strong) UIImageView *severImageView;//服务图片
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) NSString *sectionName;

//创建小区活动的cell
- (void)creatCommunityActivitiesCell:(CMCActivity *)activity;
- (void)creatCommunityActivitiesListCell:(CMCActivityList *)activity;

//创建我的小区活动列表
- (void)creatMyCommunityActivitiesCell:(CMCActivityDetail *)activity;
//本周新开张
- (void)creatNewlyopenedCell:(CMCActivityNewlyOpened *)newlyOpened;

//- (void)creatThisWeekOpenedCell:(CMCFood *)food;
//本周最低
//- (void)creatThisWeekTheLowestCell;
@end
