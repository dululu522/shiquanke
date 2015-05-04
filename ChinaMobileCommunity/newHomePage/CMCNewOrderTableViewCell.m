//
//  CMCNewOrderTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCNewOrderTableViewCell.h"

@implementation CMCNewOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatLeftImageCellleftX:(float)X rightY:(float)Y dianCan:(CMCFoodModel *)dianCan
{
    [_nameLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    [_leftImageView removeFromSuperview];
    [_deslabel removeFromSuperview];
    [_middleButton setTitle:nil forState:UIControlStateNormal];
    self.count = 0;
    
      _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 80)];
    [_leftImageView setImageWithURL:[BaseUtil systemRandomlyGenerated:dianCan.image.firstObject type:@"11" number:@"1"] placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:_leftImageView];
    
    //右边
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.frame.size.width + _leftImageView.frame.origin.x + 10,10,20, 20)];
    _nameLabel.text = dianCan.name;
    _nameLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_nameLabel];
    NSString *str = dianCan.name;
    CGSize size = [str sizeWithFont:_nameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, _nameLabel.bounds.size.height)];
    [_nameLabel setFrame:CGRectMake(_leftImageView.frame.size.width + _leftImageView.frame.origin.x + 10, 10, size.width, 20)];
    
    _deslabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.frame.size.width + _leftImageView.frame.origin.x + 10, _nameLabel.frame.size.height + _nameLabel.frame.origin.y, self.bounds.size.width/2 - 15, 20)];
    _deslabel.text = dianCan.price;
    _deslabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _deslabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_deslabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.size.width+_nameLabel.frame.origin.x + 5, 10, 120, 20)];
    _priceLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
    
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",dianCan.price];
    _priceLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_priceLabel];
    
    
    

    
//    for (int i = 0; i < 5; i++) {
//        UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 25*i, priceLabel.frame.size.height + priceLabel.frame.origin.y+5, 20, 20)];
//        starImageView.backgroundColor = [UIColor blueColor];
//        [rightView addSubview:starImageView];
//    }
//    _leftImageView.frame.size.width + _leftImageView.frame.origin.x + 10
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 114, _deslabel.frame.size.height + _deslabel.frame.origin.y + 10, 35, 30)];
//    _leftButton.backgroundColor = [UIColor orangeColor];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];
    [self.contentView addSubview:_leftButton];
    [_leftButton addTarget:self action:@selector(didClickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    _middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftButton.frame.size.width + _leftButton.frame.origin.x, _deslabel.frame.size.height + _deslabel.frame.origin.y + 10, 30, 30)];
    _middleLabel.textColor = [UIColor colorWithHexString:@"585858"];
    _middleLabel.font = [UIFont systemFontOfSize:15.0];
    _middleLabel.textAlignment = NSTextAlignmentCenter;
    _middleLabel.text = [NSString stringWithFormat:@"%d",self.count];
    [self.contentView addSubview:_middleLabel];
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftButton.frame.size.width + _leftButton.frame.origin.x, _middleLabel.frame.size.height + _middleLabel.frame.origin.y, _middleLabel.frame.size.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"diancan_line"];
    [self.contentView addSubview:lineImageView];
    
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(_middleLabel.frame.size.width + _middleLabel.frame.origin.x, _deslabel.frame.size.height + _deslabel.frame.origin.y + 10, 30, 30)];
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//    _rightButton.backgroundColor = [UIColor redColor];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_rightButton];
    
}
//减一
- (void)didClickLeftButton:(UIButton *)button
{
    
    if (--self.count > 0) {

        _middleLabel.text = [NSString stringWithFormat:@"%d",--self.count];

    } else {
        _middleLabel.text = @"0";
        
        self.count = 0;
    }



    [self.delegate loadItems];

}

//加一
- (void)didClickRightButton:(UIButton *)button
{
        _middleLabel.text = [NSString stringWithFormat:@"%d",++self.count];



    [self.delegate loadItems];
    
    
}

@end
