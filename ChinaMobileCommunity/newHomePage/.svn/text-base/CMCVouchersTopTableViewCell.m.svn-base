//
//  CMCVouchersTopTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVouchersTopTableViewCell.h"

@implementation CMCVouchersTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCellVouchersLable:(NSString *)vouchers detailLabel:(NSString *)detailStr flashLabel:(NSString *)flash
{
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width - 10, 1)];
    topImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:topImageView];
    UIImageView *vouchersImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 16, 16)];
    vouchersImageView.image = [UIImage imageNamed:@"店铺_07"];
//    vouchersImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:vouchersImageView];
    
    UILabel *vouchersLable = [[UILabel alloc] initWithFrame:CGRectMake(vouchersImageView.frame.size.width + 15, 9, 200, 16)];
    vouchersLable.textColor = [UIColor colorWithHexString:@"666666"];
    vouchersLable.text = vouchers;
    vouchersLable.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:vouchersLable];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(vouchersImageView.frame.size.width + 15, vouchersLable.frame.size.height + vouchersLable.frame.origin.y +2 , 200, 10)];
    detailLabel.text = detailStr;
    detailLabel.font = [UIFont systemFontOfSize:10.0];
    detailLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:detailLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 48, self.frame.size.width - 10, 1)];
    lineImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:lineImageView];
    
    UIImageView *flashImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48 + 16, 16, 16)];
    flashImageView.image = [UIImage imageNamed:@"我的券包"];
//    flashImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:flashImageView];
    
    //限时抢购
    UILabel *flashLabel = [[UILabel alloc] initWithFrame:CGRectMake(flashImageView.frame.size.width + 10 +2, flashImageView.frame.origin.y, 200, 17)];
    flashLabel.text = [NSString stringWithFormat:@"限时抢购:%@",flash];
    flashLabel.textColor = [UIColor colorWithHexString:@"666666"];
    flashLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:flashLabel];
    
    UIImageView *lineImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 96, self.frame.size.width - 10, 1)];
    lineImageView2.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:lineImageView2];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 96+ 19, 11, 11)];
//    leftImageView.backgroundColor = [UIColor greenColor];
    leftImageView.image = [UIImage imageNamed:@"对号_13"];
    [self.contentView addSubview:leftImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + 15, leftImageView.frame.origin.y - 2, 100, 15)];
    [self.contentView addSubview:leftLabel];
    leftLabel.text = @"支持随时退款";
    leftLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
    leftLabel.font = [UIFont systemFontOfSize:12.0];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+ leftLabel.frame.origin.x + 20, leftImageView.frame.origin.y, 11, 11)];
    rightImageView.image = [UIImage imageNamed:@"对号_13"];
    
//    rightImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:rightImageView];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightImageView.frame.size.width+ rightImageView.frame.origin.x + 5, leftImageView.frame.origin.y-2, 100, 15)];
    rightLabel.text = @"过期自动退款";
    rightLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
    rightLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:rightLabel];
}
- (void)creatOfferDetailsCellNameLabel:(NSString *)name numberLabel:(NSString *)num priceText:(NSString *)price
{

}
- (void)creatOfferDetailsCell
{

    UILabel *_nameLabel;
    UILabel *_numberLabel;
    UILabel *_priceLabel;
    [_nameLabel removeFromSuperview];
    [_numberLabel removeFromSuperview];
    [_priceLabel removeFromSuperview];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    _nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _nameLabel.font = [UIFont systemFontOfSize:12.0];
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 20, 0, 40, 40)];
//    if (num) {
//        _numberLabel.text = [NSString stringWithFormat:@"%@",num];
//        
//    } else {
//        _numberLabel.text= @"";
//        
//    }
    _numberLabel.font = [UIFont systemFontOfSize:12.0];
    _nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 110, 0, 100, 40)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    //    priceLabel.text = @"36元";
//    if (price) {
//        _priceLabel.text = [NSString stringWithFormat:@"%@",price];
//        
//    } else {
//        _priceLabel.text= @"";
//        
//    }
    _priceLabel.font = [UIFont systemFontOfSize:12.0];
    _priceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:_priceLabel];
    if (self.offerStr) {
        NSArray *arr = [self.offerStr componentsSeparatedByString:@","];
        if (arr.count) {
            NSLog(@"==========%@",[arr objectAtIndex:1]);
            _nameLabel.text = [Base64Encoder encode:[arr objectAtIndex:1]];
            
            _priceLabel.text = [NSString stringWithFormat:@"%@",[arr objectAtIndex:3]];
            _numberLabel.text = [NSString stringWithFormat:@"%@份",[arr objectAtIndex:2]];
            
        }

    }


}
- (void)creatPurchaseInformationVailLabel:(NSString *)vail detailInfomationLabel:(NSString *)detailInfomation detailRuleLabel:(NSString *)detailRule
{

    UILabel *purchaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 300, 21)];
    purchaseLabel.text = @"购买须知";
    purchaseLabel.textColor = [UIColor colorWithHexString:@"666666"];
    purchaseLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:purchaseLabel];
    UIImageView *longImageView = [[UIImageView alloc] initWithFrame:CGRectMake(39, 30, 1, 294)];
    longImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:longImageView];
    UIImageView *availImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 65, 45, 1)];
    availImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:availImageView];
    UILabel *vailLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 51, 100, 21)];
    vailLabel.text = [NSString stringWithFormat:@"有效期%@天",vail];
    vailLabel.textColor = [UIColor colorWithHexString:@"666666"];
    vailLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:vailLabel];
    
    //预约信息的详情
    UILabel *detailAvailLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 87, 204, 21)];
    detailAvailLabel.text = @"用户下载后即日起开始生效";
    detailAvailLabel.textColor = [UIColor colorWithHexString:@"666666"];
    detailAvailLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:detailAvailLabel];
    
    
    UIImageView *infomationView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 130, 45, 1)];
    infomationView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:infomationView];
    UILabel *infomationLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 116, 100, 30)];
    infomationLabel.text = @"预约信息";
    infomationLabel.textColor = [UIColor colorWithHexString:@"666666"];
    infomationLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:infomationLabel];
    
    UILabel *detailInfomationLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 152, 340, 25)];
    detailInfomationLabel.text = detailInfomation;
    detailInfomationLabel.font = [UIFont systemFontOfSize:12.0];
    detailInfomationLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:detailInfomationLabel];
    
    UIImageView *ruleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 195, 45, 1)];
    ruleImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:ruleImageView];
    UILabel *ruleLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 176, 100, 30)];
    ruleLabel.font = [UIFont systemFontOfSize:12.0];
    ruleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    ruleLabel.text = @"使用规则";
    [self.contentView addSubview:ruleLabel];
    
    //使用规则的详情
    UILabel *detailRuleLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 209, 265, 85)];
    detailRuleLabel.font = [UIFont systemFontOfSize:12.0];
    detailRuleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    detailRuleLabel.text = detailRule;
    [self.contentView addSubview:detailRuleLabel];
    



}
//图文详情中的图片
- (void)creatGraphicDetailsCellArr:(NSArray *)imageArr
{

    for (int i = 0; i < imageArr.count - 1; i++) {
        for (int j = 0; j < 2; j++) {
            if (i*2 + j > imageArr.count) {
                return;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 153 * j + 5 *j, 0 + i * 125 + 4*i, 153, 125)];
            imageView.backgroundColor = [UIColor orangeColor];
            [self.contentView addSubview:imageView];
        }
    }





}

@end
