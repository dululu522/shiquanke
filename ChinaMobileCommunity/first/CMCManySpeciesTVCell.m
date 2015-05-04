//
//  CMCManySpeciesTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCManySpeciesTVCell.h"

@implementation CMCManySpeciesTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTitleLabel:(NSString *)title contentLabel:(NSString *)content
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bounds.size.width - 10, 20)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:titleLabel];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, titleLabel.frame.size.height +titleLabel.frame.origin.y, self.bounds.size.width - 10, 44)];
    contentLabel.text = content;
    contentLabel.textColor = [UIColor colorWithHexString:@"666666"
                              ];
    [self.contentView addSubview:contentLabel];
}

@end
