//
//  CMCActivitiesDetailTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCActivitiesDetailTableViewCell : UITableViewCell
{
    UILabel *_timeLabel;
    UILabel *_nameLabel;
    UIImageView *_leftImageView;
    UILabel *_contentLabel;
    UIImageView *_imageView;
    UILabel *_label;

}
//活动名称
- (void)creatTheNameOfEvent:(NSString *)photo activeContent:(NSString *)content;
//我的活动 详情里的cell

//我也说一句
- (void)creatMyActivityDetailNameText:(NSString *)name timeText:(NSString *)time contentText:(NSString *)content;
@end
