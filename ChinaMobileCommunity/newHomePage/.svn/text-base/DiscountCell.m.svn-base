//
//  DiscountCell.m
//  CMCYouHuiVC
//
//  Created by 武鹏 on 14-11-11.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "DiscountCell.h"

@interface DiscountCell ()
@property (nonatomic,strong)UILabel *label;//折扣标识


@end




@implementation DiscountCell


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
////          self.button.imageView.image = [UIImage imageNamed:@"确定"];
//        self.button.backgroundColor = [UIColor colorWithHexString:@"96d01a"];
//        self.button.layer.cornerRadius = 5;
//        [self.button setTitle:@"下载按钮" forState:UIControlStateNormal];
//
//        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//      
//        
//       //打折标签
////        _label = [[UILabel alloc]initWithFrame:CGRectMake(-24, 0, 0.21 *self.frame.size.height, 0.21 * self.fr ame.size.height)];
//        _label = [[UILabel alloc]initWithFrame:CGRectMake(-12, 0, 17, 17)];
//        _label.backgroundColor = [UIColor redColor];
//        _label.textColor = [UIColor whiteColor];
//        _label.text = @"折";
//        [self.myImageView addSubview:_label];
//        
////        _discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.36 * self.frame.size.width, 0.65 * self.frame.size.height, 0.14 *self.frame.size.width, 0.23 *self.frame.size.height)];
//        _discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(129, 55, 50, 20)];
//        _discountLabel.textColor = [UIColor colorWithHexString:@"96d01a"];
////        _discountLabel.text = @"八折";
////        _discountLabel.textColor = [UIColor greenColor];
//        
////        _discountLabel.backgroundColor = [UIColor orangeColor];
//        [self addSubview:_discountLabel];
//        
//    }
//    return self;
//}
- (void)creatCellDiscount:(CMCDiscount *)discount
{
    [self.myImageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.detailLabel removeFromSuperview];
    
    NSURL *url = [BaseUtil systemRandomlyGenerated:discount.image type:@"20" number:@"2"];
   self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 83, 65)];
    
    
    [self.myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:self.myImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, 10, 200, 12)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"646464"];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.titleLabel.text = discount.title;
    [self.contentView addSubview:self.titleLabel];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.button.frame = CGRectMake(self.frame.size.width -  90, 49, 74, 26);
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.button];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 7, 175, 25)];
    self.detailLabel.textColor = [UIColor colorWithHexString:@"acacac"];
    self.detailLabel.font = [UIFont systemFontOfSize:10];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = discount.description;
    [self.contentView addSubview:self.detailLabel];
    self.button.backgroundColor = [UIColor colorWithHexString:@"65b9fc"];
    self.button.layer.cornerRadius = 5;
    [self.button setTitle:@"下载按钮" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  idStr = discount.id;
    
    //打折标签
    _label = [[UILabel alloc]initWithFrame:CGRectMake(-12, 0, 17, 17)];
    _label.backgroundColor = [UIColor redColor];
    _label.textColor = [UIColor whiteColor];
    _label.text = @"折";
    [self.myImageView addSubview:_label];
    

    _discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.myImageView.frame.size.width + self.myImageView.frame.origin.x + 5, self.detailLabel.frame.size.height + self.detailLabel.frame.origin.y + 5, 100, 16)];
    _discountLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
    _discountLabel.text = [NSString stringWithFormat:@"%@折",discount.discount];
    _discountLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_discountLabel];




}
//- (void)creatImageView:(UIImageView *)imageView url:(NSURL *)url
//{
//    WebImageManager *manager = [[WebImageManager alloc] init];
//    manager.imageView = imageView;
//    [manager downloadImageWithImageURL:url placeHolderImage:[UIImage imageNamed:@"log"]];
////    self.myImageView.image = [UIImage imageNamed:@"log"];
//
//}
- (void)didClickButton:(UIButton *)button
{

    NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"id":idStr};
    NSLog(@"%@",dic);

  NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponBuy];
    NSLog(@"优惠劵下载 ==== %@",postDic);
    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([postDic objectForKey:@"data"]) {
            NSDictionary *dataDic = [postDic objectForKey:@"data"];
            NSDictionary *dataDictionary = [dataDic objectForKey:@"data"];
            if ([dataDictionary objectForKey:@"couponNumber"]) {
                [BaseUtil toast:@"下载成功"];
            } else {
            
                [BaseUtil toast:@"下载失败"];
            }
            
        }
        
    } else {
    
        [BaseUtil toast:@"请求错误,请重试"];
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
