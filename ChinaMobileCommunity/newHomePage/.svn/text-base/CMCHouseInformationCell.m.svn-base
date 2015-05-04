//
//  CMCHouseInformationCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCHouseInformationCell.h"


@interface CMCHouseInformationCell ()
{
    UIImageView *_phoneImageView;
    UILabel *_shopNameLabel;
    UILabel *_addressLabel;
    UILabel *_priceLabel;
}
@end

@implementation CMCHouseInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    [self creatHouseInformationCell];
//    
//
//
//}

- (void)creatHouseInformationCell:(CMCFoodModel *)foodModel
{

    [_phoneImageView removeFromSuperview];
    [_shopNameLabel removeFromSuperview];
    [_addressLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    //图片
  _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 80)];
    _phoneImageView.image = [UIImage imageNamed:@"log"];
    //0310
    NSURL *url = [BaseUtil systemRandomlyGenerated:foodModel.image.firstObject type:@"" number:@"1"];
    [_phoneImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:_phoneImageView];
    
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageView.right + 5, 15, self.width - _phoneImageView.right - 10, 13)];
    _shopNameLabel.font = [UIFont systemFontOfSize:13.0];
    _shopNameLabel.text = foodModel.name;
    [self.contentView addSubview:_shopNameLabel];
    
    //地址
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageView.right + 5, _shopNameLabel.bottom + 15, _shopNameLabel.frame.size.width, 13)];
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.text = [NSString stringWithFormat:@"地址:"];
    [self.contentView addSubview:_addressLabel];
    
    //价格
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageView.right+5, _addressLabel.bottom + 15, _shopNameLabel.frame.size.width, 13)];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    
    _priceLabel.text = [NSString stringWithFormat:@"价格:%@/月",foodModel.price];
    [self.contentView addSubview:_priceLabel];
    
    if ([self.category isEqualToString:@"家政服务"]) {
        _addressLabel.text = @"";

        _priceLabel.text = [NSString stringWithFormat:@"收费标准: ￥%@",foodModel.price];

    }
    
}

@end
