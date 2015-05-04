//
//  CMCPropertyAddressTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPropertyAddressTVCell.h"

@implementation CMCPropertyAddressTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatNameStr:(NSString *)nameStr title:(NSString *)title
{
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 25, 20, 20)];
//    topImageView.backgroundColor = [UIColor grayColor];
    topImageView.image = [UIImage imageNamed:@"wuye_Address"];
    [self.contentView addSubview:topImageView];
    UIImageView *leftLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 1.5, 100)];
    leftLineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:leftLineImageView];
    //横着的线
    UIImageView *horizonLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 70, 1.5)];
    horizonLineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:horizonLineImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(horizonLineImageView.frame.size.width+horizonLineImageView.frame.origin.x + 15, 30, self.bounds.size.width - 150 + 20, 30)];
    
//    nameLabel.text = nameStr;
    [self.contentView addSubview:nameLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.size.height+nameLabel.frame.origin.y+2, nameLabel.frame.size.width, 30)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:nil size:14.0];
    titleLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:titleLabel];
    
    
    





}

@end
