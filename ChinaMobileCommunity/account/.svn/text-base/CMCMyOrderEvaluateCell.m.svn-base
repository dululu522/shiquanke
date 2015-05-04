//
//  CMCMyOrderEvaluateCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderEvaluateCell.h"
#import "StarView.h"

@implementation CMCMyOrderEvaluateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatMyOrderEvaluateCell
{
    StarView *star = [[StarView alloc] initWithFrame:CGRectMake(25, 5, 100, 14)];
    star.enable = NO;
    star.starNumber = 4;
    [self.contentView addSubview:star];
    UILabel *evaluateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 14)];
    evaluateLabel.text = @"评价:";
    evaluateLabel.textColor = k_color(@"585858");
    evaluateLabel.font = k_font(14);
    [self.contentView addSubview:evaluateLabel];
    
    UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, evaluateLabel.bottom + 10, self.frame.size.width - 20, 14)];
    describeLabel.text = @"阿姨干活很干净,仔细又认真";
    describeLabel.font = k_font(14);
    describeLabel.textColor = k_color(@"585858");
    [self.contentView addSubview:describeLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, describeLabel.bottom + 10, 40, 40)];
    imageView.image = [UIImage imageNamed:@"log"];
    [self.contentView addSubview:imageView];




}

@end
