//
//  CMCShopDetailTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailTableViewCell.h"

@implementation CMCShopDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCell
{
    _takeOutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 0.16 *self.bounds.size.width + 20, 0.16 *self.bounds.size.width+ 20)];
//    [_takeOutImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    //    _takeOutImageView.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:_takeOutImageView];
    
    //商品名称
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_takeOutImageView.frame.size.width + _takeOutImageView.frame.origin.x + 5, _takeOutImageView.frame.origin.y, 100, 40)];
    _nameLabel.textColor = [UIColor colorWithHexString:@"676767"];
//    _nameLabel.text = dianCan.goods_name;
    //    _nameLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_nameLabel];
    
//    UILabel *addCopiesLabel = [[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]



}

@end
