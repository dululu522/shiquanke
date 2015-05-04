//
//  CMCCommunityTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCCommunityTableViewCell.h"

@interface CMCCommunityTableViewCell ()

@property (nonatomic,strong)RemoveFromSuperViewBlock block;


@end


@implementation CMCCommunityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self creatTableViewcommunityLabel:self.community];

}
- (void)creatTableViewcommunityLabel:(CMCCommunity *)community
{
    [communityLabel removeFromSuperview];
    [distanceLabel removeFromSuperview];
    [placeLabel removeFromSuperview];

    communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.frame.size.width - 20, 15)];
    [self.contentView addSubview:communityLabel];
    communityLabel.text = community.name;
    communityLabel.font = [UIFont systemFontOfSize:14];
    communityLabel.textColor = [UIColor colorWithHexString:@"656565"];

    placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, communityLabel.frame.size.height + communityLabel.frame.origin.y+13, self.frame.size.width - 20, 14)];
    placeLabel.text = community.address;
    placeLabel.font = [UIFont systemFontOfSize:11.0];
    placeLabel.textColor = [UIColor colorWithHexString:@"818181"];
    [self.contentView addSubview:placeLabel];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,64 - 0.5, self.width - 10, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [sepeV addGestureRecognizer:tap];
    

}


- (void)tap:(UIGestureRecognizer *)sender{
    if (_block) {
        _block();
    }
    
}


- (void)setupRemoveSuperViewBlock:(RemoveFromSuperViewBlock)myBlock{
    if (_block != myBlock) {
        _block = myBlock;
    }
}

@end
