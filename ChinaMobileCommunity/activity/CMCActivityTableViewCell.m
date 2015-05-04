//
//  CMCActivityTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCActivityTableViewCell.h"

@implementation CMCActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(45, 45, self.bounds.size.width - 60, 100 - 50)];
        label.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:label];
        //大标题
        UILabel *bigtitle = [[UILabel alloc] initWithFrame:CGRectMake(imageView.bounds.size.width + 10, 5, (self.bounds.size.width - imageView.bounds.size.width - 10) / 2, 25)];
//        bigtitle.backgroundColor = [UIColor orangeColor];
        bigtitle.font = [UIFont fontWithName:nil size:12.0];
        bigtitle.text = @"大标题";
        [self.contentView addSubview:bigtitle];
        //发布时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, 5, 100, 25)];
//        //        bigtitle.backgroundColor = [UIColor orangeColor];
//        timeLabel.backgroundColor = [UIColor grayColor];
        timeLabel.text = @"发布时间";
        timeLabel.font = [UIFont fontWithName:nil size:12.0];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:timeLabel];
        
        
        
        
        
        
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
