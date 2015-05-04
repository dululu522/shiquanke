//
//  CMCNoticeTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCNoticeTableViewCell.h"

@implementation CMCNoticeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self creatNoticeCell];
    
    
}
- (void)creatNoticeCell
{
    UIImageView *_imageView;
    [_nameLabel removeFromSuperview];
    [self.timeLabel removeFromSuperview];
    [_imageView removeFromSuperview];
    UIImage *image = [UIImage imageNamed:@"红点"];
    float height = self.contentView.frame.size.height - image.size.height;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, height/2+2, image.size.width, image.size.height)];
    //    aLine.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];;
//    _imageView.image = image;
    [self.contentView addSubview:_imageView];
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right + 5, 0, self.frame.size.width/2, 50)];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2 - 5,50)];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:_timeLabel];
    if ([self.category isEqualToString:@"小区通知"]) {
        _nameLabel.text = self.community.title;
        self.timeLabel.text = [BaseUtil becomeNormalWithString:self.community.create_time];
        
    }
    if ([self.category isEqualToString:@"投诉列表"] | [self.category isEqualToString:@"报修列表"]) {
        _nameLabel.text = [BaseUtil becomeNormalWithString:self.complaint.create_time];
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
