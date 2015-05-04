//
//  CMCShoppingGoodsCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCShoppingGoodsCell.h"

@interface CMCShoppingGoodsCell ()
{
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *priceLabel;
    UIImageView *lineImageView;
}

@end


@implementation CMCShoppingGoodsCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self creatCellWithDianCan:self.diancan];
    if ([self returnYesOrNoWithCategory:self.category]) {
        [self changeFrame];
    }
    if ([self isCate:self.category]) {
        [self changeStoreNailFrame];
    }
}

- (void)creatCellWithDianCan:(NSArray *)dianCan{
    self.count = 0;
    goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 80, 80)];
    [goodsImageView setImageWithURL:[BaseUtil systemRandomlyGenerated:dianCan.firstObject type:@"11" number:@"1"] placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:goodsImageView];
    
    goodsNameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(goodsImageView.right + 9, 12, self.frame.size.width - 109, 18)];
    goodsNameLabel.text = dianCan[1];
    goodsNameLabel.font = [UIFont systemFontOfSize:15];
    goodsNameLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    [self.contentView addSubview:goodsNameLabel];
    

    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodsNameLabel.frame.origin.x, 72, self.frame.size.width - goodsImageView.right - 10, 18)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",dianCan[2]];
    priceLabel.font = [UIFont systemFontOfSize:18.0];
    priceLabel.textColor = kAPI_AllMainColor;
    [self.contentView addSubview:priceLabel];
    
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 114, 35, 30, 30)];
    //    _leftButton.backgroundColor = [UIColor orangeColor];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];
    [self.contentView addSubview:_leftButton];
    [_leftButton addTarget:self action:@selector(didClickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    _middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftButton.frame.size.width + _leftButton.frame.origin.x, 35, 30, 30)];
    _middleLabel.textColor = [UIColor colorWithHexString:@"585858"];
    _middleLabel.font = [UIFont systemFontOfSize:15.0];
    _middleLabel.textAlignment = NSTextAlignmentCenter;
    NSString *num = [[CMCUserManager shareManager].dataDic objectForKey:self.diancan];
    
    _middleLabel.text = [NSString stringWithFormat:@"%@",num];
    [self.contentView addSubview:_middleLabel];
    lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftButton.frame.size.width + _leftButton.frame.origin.x, _middleLabel.frame.size.height + _middleLabel.frame.origin.y, _middleLabel.frame.size.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"diancan_line"];
    [self.contentView addSubview:lineImageView];
    
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(_middleLabel.frame.size.width + _middleLabel.frame.origin.x, 35, 30, 30)];
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    //    _rightButton.backgroundColor = [UIColor redColor];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_rightButton];
}

- (void)changeFrame{
    goodsImageView.frame = CGRectMake(5, 5, 170, 130);
    [goodsImageView setImageWithURL:[BaseUtil systemRandomlyGenerated:_diancan.firstObject type:@"11" number:@"4"] placeholderImage:[UIImage imageNamed:@"log"]];
    goodsNameLabel.frame = CGRectMake(goodsImageView.right, 5, self.frame.size.width - 180, 25);
    priceLabel.frame = CGRectMake(goodsImageView.right + 5,goodsNameLabel.bottom+20 , self.frame.size.width - 185, 30);
    _leftButton.frame = CGRectMake(priceLabel.left, 100 , 30, 30);
    _middleLabel.frame = CGRectMake(_leftButton.right, _leftButton.top, 30, 30);
    lineImageView.frame = CGRectMake(_leftButton.right, _middleLabel.bottom - 1, _middleLabel.width, 1);
    _rightButton.frame = CGRectMake(_middleLabel.right, _leftButton.top, 30,30);
    _leftButton.userInteractionEnabled = YES;
    _rightButton.userInteractionEnabled = YES;
    
}
//休闲娱乐
- (void)changeStoreNailFrame
{
    if (self.row %2 == 0) {
        goodsImageView.frame = CGRectMake(5, 5, 150, 150);
        goodsNameLabel.frame = CGRectMake(goodsImageView.right, 5, self.frame.size.width - 160, 25);
        priceLabel.frame = CGRectMake(goodsImageView.right + 5,goodsNameLabel.bottom+20 , 155, 30);
        _leftButton.frame = CGRectMake(goodsImageView.right + 5, 100 , 30, 30);
        _middleLabel.frame = CGRectMake(_leftButton.right, _leftButton.top, 30, 30);
        lineImageView.frame = CGRectMake(_leftButton.right, _middleLabel.bottom - 1, _middleLabel.width, 1);
        _rightButton.frame = CGRectMake(_middleLabel.right, _middleLabel.top, 30, 30);
    } else {
        goodsImageView.frame =CGRectMake(150, 5, self.frame.size.width - 150 - 5, 150);
        goodsNameLabel.frame = CGRectMake(5, 5, self.frame.size.width - 180, 25);
        priceLabel.frame = CGRectMake(5,goodsNameLabel.bottom+20 , self.frame.size.width - 160, 30);
        _leftButton.frame = CGRectMake(10, 100 , 30, 30);
        _middleLabel.frame = CGRectMake(_leftButton.right, _leftButton.top, 30, 30);
        lineImageView.frame = CGRectMake(_leftButton.right, _middleLabel.bottom - 1, _middleLabel.width, 1);
        _rightButton.frame = CGRectMake(_middleLabel.right, _leftButton.top, 30, 30);
    }

    [goodsImageView setImageWithURL:[BaseUtil systemRandomlyGenerated:self.diancan.firstObject type:@"11" number:@"4"] placeholderImage:[UIImage imageNamed:@"log"]];
    

}


- (void)didClickLeftButton:(UIButton *)button
{
    if (self.count) {
        _middleLabel.text = [NSString stringWithFormat:@"%ld",--self.count];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemsWithNumber:andFoodModel:)]) {
        [self.delegate didClickItemsWithNumber:_middleLabel.text andFoodModel:self.diancan];
    }
    

}
- (void)didClickRightButton:(UIButton *)button
{
    _middleLabel.text = [NSString stringWithFormat:@"%ld",++self.count];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemsWithNumber:andFoodModel:)]) {
        [self.delegate didClickItemsWithNumber:_middleLabel.text andFoodModel:self.diancan];
    }

}

- (BOOL)returnYesOrNoWithCategory:(NSString *)cate{
    if ([cate isEqualToString:@"9"]) {//预约洗车
        return YES;
    }
    if ([cate isEqualToString:@"10"]) {//预约装饰
        return YES;
    }
    if ([cate isEqualToString:@"12"]) {//上门装饰
        return YES;
    }
    if ([cate isEqualToString:@"11"]) {//上门洗车
        return YES;
    }
    return NO;
}




- (BOOL)isCate:(NSString *)cate
{
    //到店美甲,到店修脚,到店按摩,上门按摩,上门修脚,上门美甲
    if ([cate isEqualToString:@"18"] | [cate isEqualToString:@"20"]|[cate isEqualToString:@"16"]  |[cate isEqualToString:@"19"] |[cate isEqualToString:@"17"] |[cate isEqualToString:@"21"]) {
        
        return YES;
    }
    return NO;
    
}

@end




