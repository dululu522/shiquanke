//
//  CMCMyVoucherTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//
#define k_gap  10
#import "CMCMyVoucherTableViewCell.h"

@interface CMCMyVoucherTableViewCell ()
{
    UILabel *_orderNumberLabel;
    UILabel *_priceLabel;
    UILabel *_desLabel;
    UILabel *_descripLabel1;
    UILabel *_totalLabel;
    UILabel *_usePriceLabel;


}
@end


@implementation CMCMyVoucherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCellAccountVouchers:(CMCAccountVouchers *)accountVouchers
{

    [_orderNumberLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    [_desLabel removeFromSuperview];
    [_descripLabel1 removeFromSuperview];
    [_totalLabel removeFromSuperview];
    [_usePriceLabel removeFromSuperview];

    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.contentView.frame.size.width- 20, 163)];
    backImageView.image = [UIImage imageNamed:@"myVoucher_back"];
    [self.contentView addSubview:backImageView];

    NSLog(@"代金券名字 === %@",[accountVouchers.detail objectForKey:@"name"]);
    _orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, 45)];
    _orderNumberLabel.textColor = [UIColor colorWithHexString:@"676767"];
    
    _orderNumberLabel.textColor = [UIColor colorWithHexString:@"676767"];
    _orderNumberLabel.text = [NSString stringWithFormat:@"  %@",[accountVouchers.detail objectForKey:@"name"]];
    _orderNumberLabel.font = [UIFont fontWithName:nil size:14.0];
    [self.contentView addSubview:_orderNumberLabel];
    
    UILabel *usedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width -60, 15, 60, 40)];
    if ([accountVouchers.state isEqualToString:@"0"]) {
        usedLabel.text = @"可使用";
    }else if([accountVouchers.state isEqualToString:@"1"]){
        usedLabel.text = @"已使用";
    }else if([accountVouchers.state isEqualToString:@"2"]){
        usedLabel.text = @"已过期";
    }
    usedLabel.textColor = k_color(@"676767");
    usedLabel.font = k_font(14.0);
    usedLabel.transform = CGAffineTransformMakeRotation( M_PI_4 * 0.8);
    [self.contentView addSubview:usedLabel];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 45+k_gap, self.frame.size.width - 20, 66)];
    backView.backgroundColor = kAPI_AllMainColor;
    [self.contentView addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 48, 48)];
    [backView addSubview:imageView];
    NSURL *url = [BaseUtil systemRandomlyGenerated:[accountVouchers.detail objectForKey:@"image"] type:@"20" number:@"1"];

    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    NSLog(@"self.type ==========%@",self.type);
    if ([[accountVouchers.detail objectForKey:@"type"] intValue] == 0) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 5, 0, self.frame.size.width/2 - 33, 66)];
        _priceLabel.font = [UIFont systemFontOfSize:18.0];
        _priceLabel.text = [NSString stringWithFormat:@"%@折",[accountVouchers.detail objectForKey:@"discount"]];
        _priceLabel.textColor = k_color(@"FC0300");
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_priceLabel];
    }
    if ([[accountVouchers.detail objectForKey:@"type"] intValue] == 1) {
        
        float WID = self.frame.size.width/2 - 33;
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 5, 0, [[accountVouchers.detail objectForKey:@"money_buy"] length]+ 100, 66)];
        _priceLabel.font = [UIFont systemFontOfSize:18.0];
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",[accountVouchers.detail objectForKey:@"money_buy"]];
        _priceLabel.textColor = k_color(@"FC0300");
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_priceLabel];
        
       _usePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel.right, _priceLabel.top, WID, 66)];
        _usePriceLabel.text = [NSString stringWithFormat:@"￥%@",[accountVouchers.detail objectForKey:@"money_use"]];
        [BaseUtil setCenterLineView:_usePriceLabel];

        [backView addSubview:_usePriceLabel];
    }
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(24, 5+backView.frame.size.height + backView.frame.origin.y+ 10, 16, 16)];
    imageView1.image = [UIImage imageNamed:@"myVoucher_time"];
    [self.contentView addSubview:imageView1];
    
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.frame.size.width + imageView1.frame.origin.x + 15, imageView1.frame.origin.y, 200, 16)];
    _totalLabel.font = [UIFont fontWithName:nil size:13.0];
    
    _totalLabel.text = [NSString stringWithFormat:@"使用截止日期:%@",[BaseUtil returnDateFrom1970:accountVouchers.expire_time]];
    
    _totalLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    totalLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_totalLabel];
    
}
//我的券包 代金券详情
- (void)creatCellVouchersImageView:(NSString *)imageStr label:(NSString *)labelText
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 16, 16)];
    imageView.image = [UIImage imageNamed:imageStr];
    [self.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width +imageView.frame.origin.x + 6, 0, self.contentView.frame.size.width - 46, 37)];
    label.text = labelText;
    label.textColor = [UIColor colorWithHexString:@"656565"];
    label.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:label];
    

    
//    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width - 10, 1)];
//    topImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//    [self.contentView addSubview:topImageView];
//    UIImageView *vouchersImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 16, 16)];
//    vouchersImageView.image = [UIImage imageNamed:@"店铺_07"];
//    //    vouchersImageView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:vouchersImageView];
//    
//    UILabel *vouchersLable = [[UILabel alloc] initWithFrame:CGRectMake(vouchersImageView.frame.size.width + 15, 9, 200, 16)];
//    vouchersLable.textColor = [UIColor colorWithHexString:@"666666"];
//    vouchersLable.text = vouchers;
//    vouchersLable.font = [UIFont systemFontOfSize:12.0];
//    [self.contentView addSubview:vouchersLable];
//    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(vouchersImageView.frame.size.width + 15, vouchersLable.frame.size.height + vouchersLable.frame.origin.y +2 , 200, 10)];
//    detailLabel.text = detailStr;
//    detailLabel.font = [UIFont systemFontOfSize:10.0];
//    detailLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    [self.contentView addSubview:detailLabel];
    
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 48, self.frame.size.width - 10, 1)];
//    lineImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//    [self.contentView addSubview:lineImageView];
//    
//    UIImageView *flashImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48 + 16, 16, 16)];
//    flashImageView.image = [UIImage imageNamed:@"我的券包"];
//    //    flashImageView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:flashImageView];
//    
//    //限时抢购
//    UILabel *flashLabel = [[UILabel alloc] initWithFrame:CGRectMake(flashImageView.frame.size.width + 10 +2, flashImageView.frame.origin.y, 200, 17)];
//    flashLabel.text = [NSString stringWithFormat:@"限时抢购:%@",flash];
//    flashLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    flashLabel.font = [UIFont systemFontOfSize:12.0];
//    [self.contentView addSubview:flashLabel];
//    
//    UIImageView *lineImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 96, self.frame.size.width - 10, 1)];
//    lineImageView2.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//    [self.contentView addSubview:lineImageView2];
//    
//    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 96+ 19, 11, 11)];
//    //    leftImageView.backgroundColor = [UIColor greenColor];
//    leftImageView.image = [UIImage imageNamed:@"对号_13"];
//    [self.contentView addSubview:leftImageView];
//    
//    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + 15, leftImageView.frame.origin.y - 2, 100, 15)];
//    [self.contentView addSubview:leftLabel];
//    leftLabel.text = @"支持随时退款";
//    leftLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
//    leftLabel.font = [UIFont systemFontOfSize:12.0];
//    
//    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+ leftLabel.frame.origin.x + 20, leftImageView.frame.origin.y, 11, 11)];
//    rightImageView.image = [UIImage imageNamed:@"对号_13"];
//    
//    //    rightImageView.backgroundColor = [UIColor greenColor];
//    [self.contentView addSubview:rightImageView];
//    
//    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightImageView.frame.size.width+ rightImageView.frame.origin.x + 5, leftImageView.frame.origin.y-2, 100, 15)];
//    rightLabel.text = @"过期自动退款";
//    rightLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
//    rightLabel.font = [UIFont systemFontOfSize:12];
//    [self.contentView addSubview:rightLabel];
}
//我的券包 代金券详情 说明部分
- (void)creatInstructionsCell
{
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 14, 11, 11)];
        //    leftImageView.backgroundColor = [UIColor greenColor];
        leftImageView.image = [UIImage imageNamed:@"对号_13"];
        [self.contentView addSubview:leftImageView];
    
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + 15, 0, 100, 40)];
        [self.contentView addSubview:leftLabel];
        leftLabel.text = @"支持随时退款";
        leftLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
        leftLabel.font = [UIFont systemFontOfSize:12.0];
    
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+ leftLabel.frame.origin.x + 20, leftImageView.frame.origin.y, 11, 11)];
        rightImageView.image = [UIImage imageNamed:@"对号_13"];
    
        //    rightImageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:rightImageView];
    
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightImageView.frame.size.width+ rightImageView.frame.origin.x + 5, 0, 100, 40)];
        rightLabel.text = @"过期自动退款";
        rightLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
        rightLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:rightLabel];



}
- (void)didClickOkButton:(UIButton *)button
{
    
    
}

@end
