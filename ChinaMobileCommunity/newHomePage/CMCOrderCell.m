//
//  CMCOrderCell.m
//  ChinaMobileCommunity
//
//  Created by 武鹏 on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderCell.h"
#import "StarView.h"

@interface CMCOrderCell ()

@property (nonatomic,strong)UILabel *foodL;//菜名
@property (nonatomic,strong)UILabel *priceL;//价格
@property (nonatomic,strong)StarView *commentView;//评价
@property (nonatomic,strong)UIButton *addBtt;//加
@property (nonatomic,strong)UIButton *reduBtt;//减
@property (nonatomic,strong)UILabel *numL;//个数

@end


@implementation CMCOrderCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"-----------------");
    }
    return self;
}




- (void)setStr:(NSString *)str{
    if (_str != str) {
        _str = str;
    }
    
    self.picImageView = [[UIImageView alloc]init];
    self.picImageView.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    [self addSubview:self.picImageView];
    
    self.detailImageView = [[UIImageView alloc]init];
    self.detailImageView.layer.cornerRadius = 5;
    self.detailImageView.clipsToBounds = YES;
    [self addSubview:self.detailImageView];
    
    self.foodL = [[UILabel alloc]initWithFrame:CGRectMake(20, 18, 70, 30)];
    self.foodL.text = @"照烧牛排";
    [self.detailImageView addSubview:self.foodL];
    
    self.priceL = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 70, 30)];
    self.priceL.text = @" 58/份";
    [self.detailImageView addSubview:self.priceL];
    
    self.commentView = [[StarView alloc]initWithFrame:CGRectMake(13, 75, 80, 30)];
    self.commentView.enable = NO;
    self.commentView.starNumber = 4;
    [self.detailImageView addSubview:self.commentView];
    
    self.addBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtt.frame = CGRectMake(20, 145, 33, 33);
    [self.addBtt setTitle:@"-" forState:UIControlStateNormal];
    [self.detailImageView addSubview:self.addBtt];
    
    self.numL = [[UILabel alloc]initWithFrame:CGRectMake(55, 145, 33, 33)];
    self.numL.text = @"1";
    [self.detailImageView addSubview:self.numL];
    
    self.reduBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduBtt.frame = CGRectMake(90, 145, 33, 33);
    //        self.reduBtt.backgroundColor = [UIColor redColor];
    [self.reduBtt setTitle:@"+" forState:UIControlStateNormal];
    [self.detailImageView addSubview:self.reduBtt];

    
}



@end
