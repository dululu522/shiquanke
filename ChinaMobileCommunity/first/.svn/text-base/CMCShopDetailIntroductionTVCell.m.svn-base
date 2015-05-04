//
//  CMCShopDetailIntroductionTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailIntroductionTVCell.h"

@implementation CMCShopDetailIntroductionTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTitleLabel:(NSString *)title contentLabel:(NSString *)content
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.bounds.size.width - 10, 12)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:titleLabel];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, titleLabel.frame.size.height +titleLabel.frame.origin.y+11, self.bounds.size.width - 10, 44)];
    contentLabel.text = [NSString stringWithFormat:@"  %@",content];
    contentLabel.font = [UIFont systemFontOfSize:12.0];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:contentLabel];
}
@end
