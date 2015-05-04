//
//  CMCAboutUSTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAboutUSTableViewCell.h"

@implementation CMCAboutUSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)creatLabel:(NSString *)LabelStr dataLabel:(NSString *)dataLabelStr
{
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    leftLabel.text = LabelStr;
    [self.contentView addSubview:leftLabel];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+leftLabel.frame.origin.x, 0, self.frame.size.width - 10-80, leftLabel.frame.size.height)];
    rightLabel.text = dataLabelStr;
    [self.contentView addSubview:rightLabel];
    



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
