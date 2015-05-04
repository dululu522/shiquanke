//
//  CMCActivityTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivityTableViewCell.h"

@implementation CMCActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//创建小区活动的cell
- (void)creatCommunityActivitiesCell:(CMCActivity *)activity
{
    [_photoImageView removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_activityTimeLabel removeFromSuperview];
    [_endTimeLabel removeFromSuperview];
    [_placeLabel removeFromSuperview];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 107, 74)];
    if ([activity.images count]) {
//            NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject]];
            NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject] type:@"31" number:@"1"];
            [_photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    }

    [self.contentView addSubview:_photoImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, 13, self.frame.size.width-130, 13)];
    _nameLabel.text = activity.name;
    _nameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_nameLabel];
    _activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _nameLabel.frame.size.height +_nameLabel.frame.origin.y+12, self.frame.size.width-130, 11)];
    _activityTimeLabel.font = [UIFont systemFontOfSize:11.0];
    _activityTimeLabel.text = [NSString stringWithFormat:@"报名截止时间:%@",[BaseUtil becomeNormalWithString:activity.end_time]];
    _activityTimeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_activityTimeLabel];
    //地点
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _activityTimeLabel.frame.size.height+_activityTimeLabel.frame.origin.y+7, self.frame.size.width-130, 11)];
    _placeLabel.text = [NSString stringWithFormat:@"活动地点:%@",activity.address];
    _placeLabel.font = [UIFont systemFontOfSize:11];
    _placeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_placeLabel];
}

//创建我的小区活动列表
- (void)creatMyCommunityActivitiesCell:(CMCActivity *)activity
{
    [_photoImageView removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_activityTimeLabel removeFromSuperview];
    [_endTimeLabel removeFromSuperview];
    [_placeLabel removeFromSuperview];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 107, 74)];
    if ([activity.images count]) {
        //            NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject]];
        NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject] type:@"31" number:@"1"];
        [_photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    }
    
    [self.contentView addSubview:_photoImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, 13, self.frame.size.width-130, 13)];
    _nameLabel.text = activity.name;
    _nameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_nameLabel];
    _activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _nameLabel.frame.size.height +_nameLabel.frame.origin.y+12, self.frame.size.width-130, 11)];
    _activityTimeLabel.font = [UIFont systemFontOfSize:11.0];
    _activityTimeLabel.text = [NSString stringWithFormat:@"报名截止时间:%@",[BaseUtil becomeNormalWithString:activity.end_time]];
    _activityTimeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_activityTimeLabel];
    //地点
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _activityTimeLabel.frame.size.height+_activityTimeLabel.frame.origin.y+7, self.frame.size.width-130, 11)];
    _placeLabel.text = [NSString stringWithFormat:@"活动地点:%@",activity.address];
    _placeLabel.font = [UIFont systemFontOfSize:11];
    _placeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_placeLabel];
}

- (void)creatCommunityActivitiesListCell:(CMCActivityList *)activity
{
    [_photoImageView removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_activityTimeLabel removeFromSuperview];
    [_endTimeLabel removeFromSuperview];
    [_placeLabel removeFromSuperview];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 107, 74)];
    if ([activity.images count]) {
        //            NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject]];
        NSURL *url = [BaseUtil systemRandomlyGenerated:[activity.images firstObject] type:@"31" number:@"1"];
        [_photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    }
    
    [self.contentView addSubview:_photoImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, 13, self.frame.size.width-130, 13)];
    _nameLabel.text = activity.name;
    _nameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_nameLabel];
    _activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _nameLabel.frame.size.height +_nameLabel.frame.origin.y+12, self.frame.size.width-130, 11)];
    _activityTimeLabel.font = [UIFont systemFontOfSize:11.0];
    _activityTimeLabel.text = [NSString stringWithFormat:@"报名截止时间:%@",[BaseUtil becomeNormalWithString:activity.end_time]];
    _activityTimeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_activityTimeLabel];
    //地点
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width + _photoImageView.frame.origin.x+5, _activityTimeLabel.frame.size.height+_activityTimeLabel.frame.origin.y+7, self.frame.size.width-130, 11)];
    _placeLabel.text = [NSString stringWithFormat:@"活动地点:%@",activity.address];
    _placeLabel.font = [UIFont systemFontOfSize:11];
    _placeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_placeLabel];






}

- (void)creatNewlyopenedCell:(CMCActivityNewlyOpened *)newlyOpened
{

    [_newOpenedImageView removeFromSuperview];
    [_shopNewNameLabel removeFromSuperview];
    [_timeLabel removeFromSuperview];
    [_addressLabel removeFromSuperview];
    _newOpenedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 106, 73)];
    if (newlyOpened.image.length) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:newlyOpened.image type:@"10" number:@"4"];
        [_newOpenedImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    } else {
        _newOpenedImageView.image = [UIImage imageNamed:@"log"];
    
    }

    [self.contentView addSubview:_newOpenedImageView];
    
    //超市名称
    _shopNewNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_newOpenedImageView.frame.size.width + _newOpenedImageView.frame.origin.x + 5, 14, self.frame.size.width - 121, 25)];
    //    shopNameLabel.backgroundColor = [UIColor grayColor];
    _shopNewNameLabel.text =newlyOpened.name;
    _shopNewNameLabel.font = [UIFont systemFontOfSize:14];
    _shopNewNameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:_shopNewNameLabel];
    
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_newOpenedImageView.frame.size.width + _newOpenedImageView.frame.origin.x + 5, _shopNewNameLabel.frame.size.height + _shopNewNameLabel.frame.origin.y, self.frame.size.width - 121, 48)];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.text = [NSString stringWithFormat:@"地址:%@",newlyOpened.address];
    _timeLabel.textColor = [UIColor colorWithHexString:@"606060"];
    [self.contentView addSubview:_timeLabel];
    
//    //地图
//    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_newOpenedImageView.frame.size.width + _newOpenedImageView.frame.origin.x + 5 , _timeLabel.frame.size.height + _timeLabel.frame.origin.y, self.frame.size.width - 121, 24)];
//    _addressLabel.textColor = [UIColor colorWithHexString:@"606060"];
//    _addressLabel.font = [UIFont systemFontOfSize:11];
//    _addressLabel.text = newlyOpened.address;
//    [self.contentView addSubview:_addressLabel];
}


@end
