//
//  ChitCell.m
//  CMCYouHuiVC
//
//  Created by 武鹏 on 14-11-11.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "ChitCell.h"
#import "UIColor+ChangeColor.h"
#import "MBProgressHUD.h"
@interface ChitCell ()

@property (nonatomic,strong)UILabel *originalPrice;
@property (nonatomic,strong)UILabel *nowPrice;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *beforeLabel;


@end


@implementation ChitCell

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self.button setTitle:@"立即购买" forState:UIControlStateNormal];
////        
//        _originalPrice = [[UILabel alloc]initWithFrame:CGRectMake(140, 60, 62, 20)];
//        _originalPrice.text = @"sss";
//        
//        [self addSubview:_originalPrice];
//        
//        
//    }
//    return self;
//}
- (void)creatCellWithVoucher:(CMCDiscount *)vouchers
{
    [self.myImageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.detailLabel removeFromSuperview];
    [self.beforeLabel removeFromSuperview];
    [self.discountLabel removeFromSuperview];
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 83, 65)];
    [self.contentView addSubview:self.myImageView];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, 10, 100, 12)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"646464"];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self addSubview:self.titleLabel];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.button.frame = CGRectMake(self.frame.size.width - 90, 55, 74, 26);
    
    [self.contentView addSubview:self.button];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, 30, 175, 19)];
    self.detailLabel.textColor = [UIColor colorWithHexString:@"acacac"];
    self.detailLabel.font = [UIFont systemFontOfSize:10];
    self.detailLabel.numberOfLines = 0;
    
    
    [self.contentView addSubview:self.detailLabel];


    [self.button setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(didClickBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = kAPI_AllMainColor;
    self.button.layer.cornerRadius = 5;
    NSURL *url = [BaseUtil systemRandomlyGenerated:vouchers.image type:@"20" number:@"2"];
//    [self.myImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    self.titleLabel.text = vouchers.title;
    self.detailLabel.text = vouchers.description;

    self.id = vouchers.id;
    
    
    
    
    _discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, 55, 120, 15)];
    _discountLabel.text = [NSString stringWithFormat:@"￥%@",vouchers.price];
    _discountLabel.font = [UIFont systemFontOfSize:14.0];
    _discountLabel.textColor = [UIColor colorWithHexString:@"96d01a"];

    [self.contentView addSubview:_discountLabel];
    

    _beforeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, self.discountLabel.frame.origin.y+self.discountLabel.frame.size.height+2 , 150, 10)];
    _beforeLabel.font = [UIFont systemFontOfSize:12.0];
    _beforeLabel.text =[NSString stringWithFormat:@"￥%@",vouchers.before_price];
    _beforeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_beforeLabel];
    [self setCenterLineView:_beforeLabel];
//        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 3, _beforeLabel.frame.origin.y + _beforeLabel.frame.size.height/2, _beforeLabel.frame.size.width+4 , 1)];
//        middleView.backgroundColor = [UIColor colorWithHexString:@"666666"];
//        [self.contentView addSubview:middleView];


}
//设置中划线
- (void)setCenterLineView:(UILabel *)label
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],NSStrikethroughStyleAttributeName, nil];
    label.font = [UIFont fontWithName:nil size:12];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text attributes:dic];
    label.attributedText = str;
}
- (void)didClickBuyButton:(UIButton *)button
{
    [MBProgressHUD showHUDAddedTo:self animated:YES];

    NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"id":self.id};
    
    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponBuy];
    NSLog(@"代金券购买  postDic ===%@",postDic);
    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"info"] intValue] == 0) {
        if ([postDic objectForKey:@"data"]) {
            NSDictionary *dataDic = [postDic objectForKey:@"data"];
            NSDictionary *dataDicTwo = [dataDic objectForKey:@"data"];
            NSArray *goodslistArr = [dataDicTwo objectForKey:@"goodslist"];
            NSDictionary *allGoodDic = [goodslistArr objectAtIndex:0];
            NSLog(@"allGoodDic == %@",allGoodDic);
            [BaseUtil PaymentForGoodsTradeNO:[dataDicTwo objectForKey:@"order_id"] productName:[allGoodDic objectForKey:@"goods_name"] amount:[dataDicTwo objectForKey:@"pay"]];
            [MBProgressHUD hideAllHUDsForView:self animated:YES];
        } else {
            [BaseUtil toast:@"暂时不能购买"];
            [MBProgressHUD hideAllHUDsForView:self animated:YES];
        
        }
        
    }else {
    
        [BaseUtil toast:@"购买失败,请重新购买"];
        [MBProgressHUD hideAllHUDsForView:self animated:YES];

    
    }


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
