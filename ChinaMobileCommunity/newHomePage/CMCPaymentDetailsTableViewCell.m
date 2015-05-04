//
//  CMCPaymentDetailsTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPaymentDetailsTableViewCell.h"

@implementation CMCPaymentDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatPaymentDetailCellImage:(NSString *)imageStr nameLabel:(NSString *)nameLabelText additionalCopiesLabel:(NSString *)CopiesLabelText priceLabel:(NSString *)priceLabelText
{
        UIImageView *foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    if (imageStr == nil) {
        foodImageView.image = [UIImage imageNamed:@"log"];
        
    } else {
        NSURL *url = [BaseUtil systemRandomlyGenerated:imageStr type:@"11" number:@"1"];
        
        [foodImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    }
//    foodImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:foodImageView];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(foodImageView.frame.size.width + foodImageView.frame.origin.x+5, 5, 100, 20)];
    if (nameLabelText == nil) {
        
    } else {
        nameLabel.text = nameLabelText;

    
    }
    nameLabel.textColor = [UIColor colorWithHexString:@"676767"];
    [self.contentView addSubview:nameLabel];
    
    UILabel *additionalCopiesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 20, nameLabel.frame.size.height + nameLabel.frame.origin.y, 40, 20)];
    additionalCopiesLabel.textColor = [UIColor colorWithHexString:@"666666"];
    additionalCopiesLabel.text = [NSString stringWithFormat:@"%@份",CopiesLabelText];
    [self.contentView addSubview:additionalCopiesLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, self.frame.size.height/2 - 15, 60, 30)];
//    priceLabel.backgroundColor = [UIColor redColor];

    priceLabel.text = [NSString stringWithFormat:@"￥%@",priceLabelText];
    priceLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    priceLabel.font = [UIFont systemFontOfSize:17.0];
    [self.contentView addSubview:priceLabel];




}
@end
