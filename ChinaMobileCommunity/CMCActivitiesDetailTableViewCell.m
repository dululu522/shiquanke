//
//  CMCActivitiesDetailTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivitiesDetailTableViewCell.h"

@implementation CMCActivitiesDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//活动名称
- (void)creatTheNameOfEvent:(NSString *)photo activeContent:(NSString *)content
{

    [_imageView removeFromSuperview];
    [_label removeFromSuperview];
    //活动名称左边的图标
    UIImage *image = [UIImage imageNamed:photo];
    _imageView = [[UIImageView alloc] init];
    _imageView.image = image;
    [self.contentView addSubview:_imageView];
    //活动内容
    _label = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.size.width +_imageView.frame.origin.x+10, 0, self.frame.size.width - (_imageView.frame.size.width +_imageView.frame.origin.x + 36), 22)];
    _label.text = content;
    _label.font = [UIFont systemFontOfSize:11];
    _label.textColor = [UIColor colorWithHexString:@"555555"];
    [self.contentView addSubview:_label];


}
//我也说一句
- (void)creatMyActivityDetailNameText:(NSString *)name timeText:(NSString *)time contentText:(NSString *)content
{
    [_timeLabel removeFromSuperview];
    [_leftImageView removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_contentLabel removeFromSuperview];
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50 )];
    [self.contentView addSubview:_leftImageView];
//    _leftImageView.backgroundColor = [UIColor grayColor];
    _leftImageView.image = [UIImage imageNamed:@"log"];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.frame.size.width + _leftImageView.frame.origin.x + 5, 20, 50, 20)];
    //    nameLabel.backgroundColor = [UIColor orangeColor];
    _nameLabel.font = [UIFont fontWithName:nil size:14.0];
    if ([name intValue] == 0) {
        _nameLabel.text = @"";
    }else {
        _nameLabel.text = name;
    
    }
    _nameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 55, _nameLabel.frame.origin.y, 50, 20)];
    //    timeLabel.backgroundColor = [UIColor blueColor];
    if (time.length) {
        _timeLabel.text = time;

    }
    _timeLabel.font = [UIFont fontWithName:nil size:12.0];
    _timeLabel.textColor = [UIColor colorWithHexString:@"bebebe"];
    [self.contentView addSubview:_timeLabel];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.frame.size.width + _leftImageView.frame.origin.x, _leftImageView.frame.size.height +_leftImageView.frame.origin.y, self.bounds.size.width - 5- _leftImageView.frame.size.width - _leftImageView.frame.origin.x, 30)];
    if (content.length) {
        _contentLabel.text = content;
    }
    _contentLabel.font = [UIFont systemFontOfSize:14.0];
    _contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_contentLabel];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _contentLabel.frame.size.height + _contentLabel.frame.origin.y, self.bounds.size.width - 20, 0.5)];
    topImageView.image = [UIImage imageNamed:@"line"];
    [self.contentView addSubview:topImageView];
//    //上传的图片
//    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, topImageView.frame.size.height + topImageView.frame.origin.y + 1, 50, 40)];
//    //    photoImageView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:photoImageView];
//    
//    
//    UIImageView *buttomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, photoImageView.frame.size.height + photoImageView.frame.origin.y+ 1, self.bounds.size.width - 20, 0.5)];
//    buttomImageView.image = [UIImage imageNamed:@"line"];
//    [self.contentView addSubview:buttomImageView];
//    
//    UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, buttomImageView.frame.size.height + buttomImageView.frame.origin.y , self.bounds.size.width - 10, 20)];
//    replyLabel.text = @"掌柜子回复:";
//    replyLabel.textColor = [UIColor colorWithHexString:@"96d01a"];
//    //    replyLabel.backgroundColor = [UIColor orangeColor];
//    [self.contentView addSubview:replyLabel];
//    
//    UILabel *replyContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, replyLabel.frame.size.height + replyLabel.frame.origin.y, self.bounds.size.width - 15-5, 30)];
//    replyContentLabel.text = foodDetail.reply_content;
//    replyContentLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    [self.contentView addSubview:replyContentLabel];
    
    
}

@end
