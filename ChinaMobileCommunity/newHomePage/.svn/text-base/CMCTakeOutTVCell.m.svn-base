//
//  CMCTakeOutTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCTakeOutTVCell.h"


@implementation CMCTakeOutTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCellDianCan:(CMCDianCan *)dianCan
{
    self.selectNumber = 0;
    [_takeOutImageView removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    [_materialLabel removeFromSuperview];
    [_midLabel removeFromSuperview];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kAPI_image,dianCan.default_image]];
    //
    _takeOutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 0.16 *self.bounds.size.width + 20, 0.16 *self.bounds.size.width+ 20)];
    [_takeOutImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
//    _takeOutImageView.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:_takeOutImageView];
    
    //商品名称
  _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_takeOutImageView.frame.size.width + _takeOutImageView.frame.origin.x + 5, _takeOutImageView.frame.origin.y, 100, 40)];
    _nameLabel.textColor = [UIColor colorWithHexString:@"676767"];
    _nameLabel.text = dianCan.goods_name;
//    _nameLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_nameLabel];
    //价格
   _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.size.width +_nameLabel.frame.origin.x + 5, _nameLabel.frame.origin.y, 80, _nameLabel.frame.size.height)];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",dianCan.price];
//    _priceLabel.backgroundColor = [UIColor greenColor];
    _priceLabel.textColor = [UIColor colorWithHexString:@"96d01a"];
    [self.contentView addSubview:_priceLabel];
    
    //原材料
   _materialLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x , _nameLabel.frame.size.height + _nameLabel.frame.origin.y +5, _nameLabel.frame.size.width + 20 , 20)];
    _materialLabel.font = [UIFont fontWithName:nil size:12.0];
    _materialLabel.text = dianCan.discription;
//    _materialLabel.backgroundColor = [UIColor blueColor];
    _materialLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_materialLabel];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(_materialLabel.frame.origin.x + _materialLabel.frame.size.width + 10, _materialLabel.frame.origin.y, 30, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(didClickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftButton];
    _midLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftButton.frame.size.width + leftButton.frame.origin.x, leftButton.frame.origin.y, 30, 30)];
    [self.contentView addSubview:_midLabel];
    _midLabel.text = [NSString stringWithFormat:@"%d",self.selectNumber];
    _midLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _midLabel.textAlignment = NSTextAlignmentCenter;
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_midLabel.frame.origin.x, _midLabel.frame.origin.y + _midLabel.frame.size.height , _midLabel.frame.size.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"diancan_line"];
    [self.contentView addSubview:lineImageView];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(_midLabel.frame.origin.x + _midLabel.frame.size.width, leftButton.frame.origin.y, 30, 30);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(didClickrightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightButton];
    


}
- (void)didClickLeftButton:(UIButton *)button
{
    if (self.selectNumber == 0) {
        return;
    }
    _midLabel.text = [NSString stringWithFormat:@"%d",--self.selectNumber];
    [self.delegate clickWaiCellItems];

}
- (void)didClickrightButton:(UIButton *)button
{
    _midLabel.text = [NSString stringWithFormat:@"%d",++self.selectNumber];
    [self.delegate clickWaiCellItems];
    
}

@end
