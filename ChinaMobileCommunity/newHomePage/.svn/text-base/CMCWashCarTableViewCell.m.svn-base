//
//  CMCWashCarTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCWashCarTableViewCell.h"

@implementation CMCWashCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatWashCarCell
{
    [_phoneView removeFromSuperview];
    [_priceLabel removeFromSuperview];
    [_minusBtn removeFromSuperview];
    [_labelBtn removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_addBtn removeFromSuperview];

    
    _phoneView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 170, 130)];
    _phoneView.image = [UIImage imageNamed:@"log"];
    [self.contentView addSubview:_phoneView];
    
    //名字
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneView.right, 5, self.frame.size.width - 180, 25)];
    _nameLabel.text = @"汽车座椅清洗";
    [self.contentView addSubview:_nameLabel];
    
    //价格
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneView.right + 5,_nameLabel.bottom+20 , self.frame.size.width - 185, 30)];
    _priceLabel.text = [NSString stringWithFormat:@"￥ 120.00"];
    [self.contentView addSubview:_priceLabel];
    
    //按钮
    UIImage *addImage = [UIImage imageNamed:@"add_new"];
    UIImage *subImage = [UIImage imageNamed:@"sub_new"];

    _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _minusBtn.frame = CGRectMake(_priceLabel.left, 100 , 30, 30);
    [_minusBtn addTarget:self action:@selector(didClickminusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_minusBtn setImage:subImage forState:UIControlStateNormal];
    [self.contentView addSubview:_minusBtn];
    
    _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _labelBtn.frame = CGRectMake(_minusBtn.right, _minusBtn.top, _minusBtn.width, _minusBtn.height);
    [self.contentView addSubview:_labelBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(_labelBtn.right, _minusBtn.top, addImage.size.width, addImage.size.height);
    [_addBtn addTarget:self action:@selector(didClickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:addImage forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
}
- (void)didClickminusBtn:(UIButton *)button
{


}
- (void)didClickaddBtn:(UIButton *)button
{

}
@end
