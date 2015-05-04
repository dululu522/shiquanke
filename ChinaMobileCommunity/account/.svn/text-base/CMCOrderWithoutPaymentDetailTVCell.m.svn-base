//
//  CMCOrderWithoutPaymentDetailTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//
#define k_thirteenFont [UIFont systemFontOfSize:13.0]
#define k_color [UIColor colorWithHexString:@"666666"]
#import "CMCOrderWithoutPaymentDetailTVCell.h"
#import "StarView.h"

@implementation CMCOrderWithoutPaymentDetailTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatLabel:(NSArray *)foodNameArr numArr:(NSArray *)numArr priceArr:(NSArray *)priceArr
{
    NSInteger count = 0;
    if (foodNameArr.count%2== 0) {
        count = foodNameArr.count/2;
    } else {
        count = foodNameArr.count/2+1;
    
    }
    
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < 2; j++) {
            if (i*2+j > foodNameArr.count - 1) {
                return;
            }
                UILabel *foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 +j*(self.contentView.frame.size.width - 30)/2, 0+ 30 *i, self.contentView.frame.size.width/2, 30)];
            foodNameLabel.text = [NSString stringWithFormat:@"%@ (%@份 ￥%@)",[foodNameArr objectAtIndex:i*2+j],[numArr objectAtIndex:i*2+j],[priceArr objectAtIndex:i*2+j]];
            foodNameLabel.font = [UIFont systemFontOfSize:13.0];
            foodNameLabel.textColor = [UIColor colorWithHexString:@"555555"];
                [self.contentView addSubview:foodNameLabel];
        }
    }
}
- (void)creatLeftLabel:(NSString *)totalPrice
{

    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 25)];
    [self.contentView addSubview:leftLabel];
    leftLabel.text = @"总计";
    leftLabel.font = [UIFont systemFontOfSize:13.0];
    leftLabel.textColor = [UIColor colorWithHexString:@"666666"];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 200, 0, 182, 25)];
    priceLabel.text = @"价格";
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = kAPI_AllMainColor;
    priceLabel.font = [UIFont systemFontOfSize:13.0];
    priceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:priceLabel];




}
- (void)creatButtomPrice:(NSString *)priceText comment:(NSString *)comment phone:(NSString *)phone realName:(NSString *)realName
{
    [_priceLabel removeFromSuperview];
    [_noteLabel removeFromSuperview];
    [_phoneLabel removeFromSuperview];
    [_nameLabel removeFromSuperview];
    
    UIView *buttomView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:buttomView];
    UILabel *combinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100 , 25)];
    combinedLabel.text = @"总计";
    combinedLabel.font = k_thirteenFont;
    combinedLabel.textColor = k_color;
    [buttomView addSubview:combinedLabel];
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 200, 0, 182, 25)];
    _priceLabel.text =[NSString stringWithFormat: @"￥%@",priceText];
    _priceLabel.textColor = kAPI_AllMainColor;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [buttomView addSubview:_priceLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 25, self.contentView.frame.size.width, 1)];
    lineImageView.backgroundColor = KAPI_lineColor;
    [buttomView addSubview:lineImageView];
    //备注
    _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, combinedLabel.frame.size.height +combinedLabel.frame.origin.y , self.contentView.frame.size.width - 28, 26)];
    _noteLabel.text = [NSString stringWithFormat:@"备注:%@",comment];
    _noteLabel.font = k_thirteenFont;
    _noteLabel.textColor = k_color;
    [buttomView addSubview:_noteLabel];
    //姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, _noteLabel.frame.size.height + _noteLabel.frame.origin.y, self.contentView.frame.size.width - 28, 26)];
    _nameLabel.text = [NSString stringWithFormat:@"姓名: %@",realName];
    _nameLabel.font = k_thirteenFont;
    _nameLabel.textColor = k_color;
    [buttomView addSubview:_nameLabel];
    //手机号
   _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, _nameLabel.frame.size.height + _nameLabel.frame.origin.y, self.contentView.frame.size.width - 28, 26)];
    _phoneLabel.text = [NSString stringWithFormat:@"手机号: %@",phone];
    _phoneLabel.textColor = k_color;
    _phoneLabel.font = k_thirteenFont;
    [buttomView addSubview:_phoneLabel];
}
//评价
- (void)creatEvaluation
{
    UILabel *evaluationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 50, 25)];
    evaluationLabel.text = @"评价";
    evaluationLabel.textColor = [UIColor colorWithHexString:@"7c7c7c"];
    [self.contentView addSubview:evaluationLabel];
    StarView *starView = [[StarView alloc] initWithFrame:CGRectMake(65,9, 80, 25)];
    starView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:starView];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, evaluationLabel.frame.size.height + evaluationLabel.frame.origin.y+13, self.frame.size.width - 30, 50)];
    commentLabel.text = @"味道不错";
    commentLabel.textColor = [UIColor colorWithHexString:@"7c7c7c"];
    [self.contentView addSubview:commentLabel];


}
@end
