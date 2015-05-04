//
//  CMCOrderMakeSureCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderMakeSureCell.h"

@implementation CMCOrderMakeSureCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = k_color(@"f5f4f4");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self createSubViews];
}

- (void)createSubViews{
    //商品图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(12, 3, 52, 52);
    imgView.backgroundColor = [UIColor redColor];
    [imgView setImageWithURL:[BaseUtil systemRandomlyGenerated:self.orderArr.firstObject type:@"" number:@"1"] placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:imgView];
    
    //商品名称
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 8, 6, 200, 13) font:13 textColor:@"5b5b5b" superView:self.contentView];
    nameL.text = self.orderArr[1];
    
    //商品数量
    UILabel *numL = [self createLWithFrame:CGRectMake(imgView.right + 100, 25, 50, 11) font:11 textColor:@"7a7a7a" superView:self.contentView];
    numL.text = [NSString stringWithFormat:@"%@份",self.orderArr[4]];
    
    //价钱
    UILabel *priceL = [self createLWithFrame:CGRectMake(numL.right , 20, self.width - numL.right, 18) font:18 textColor:@"313131" superView:self.contentView];
    priceL.textAlignment = NSTextAlignmentRight;
    priceL.text = [NSString stringWithFormat:@"¥%.2f",([self.orderArr[2] floatValue] * [self.orderArr[4] intValue])];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(imgView.right + 8,self.height - 0.5, self.width - imgView.right - 8 - 10, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
    [self.contentView addSubview:sepeV];
    
    
}

//创建label
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
}



- (void)createBttWithFrame:(CGRect)frame
                 imageName:(NSString *)imageName
                     title:(NSString *)title
                    action:(SEL)action
                 superView:(UIView *)superView
                       tag:(int)tag{
    UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
    btt.frame = frame;
    [btt setTitle:title forState:UIControlStateNormal];
    [btt addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btt.titleLabel.font = [UIFont systemFontOfSize:13];
    [btt setTitleColor:k_color(@"808080") forState:UIControlStateNormal];
    btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    btt.tag = tag;
    [btt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [superView addSubview:btt];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
