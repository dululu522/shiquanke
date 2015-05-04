//
//  WashColthesCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "WashColthesCell.h"

@interface WashColthesCell ()
{
    UILabel *nameL;
    UILabel *priceL;
    UIImageView *topImgV;
    UIImageView *lineImageView;
}

@end

@implementation WashColthesCell




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
    
}


- (void)createSubViews{
    [self setupSubViews];
    
    //到店美容，美发，上门美容，美发
    if ([self.category isEqualToString:@"22"] | [self.category isEqualToString:@"23"] | [self.category isEqualToString:@"24"] | [self.category isEqualToString:@"25"]) {
        //重新坐标
        [self hairDressing];
        
    }
}

- (void)setupSubViews{
    
    
    //底部
    UIView *btmV = [[UIView alloc]init];
    btmV.frame = CGRectMake(0, 0, self.width, 165);
    btmV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:btmV];
    
    //image
    UIImageView *btmImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, 145)];
    btmImgV.backgroundColor = [UIColor redColor];
    btmImgV.userInteractionEnabled = YES;
    [btmImgV setImageWithURL:[BaseUtil systemRandomlyGenerated:_diancan.firstObject type:@"11" number:@"5"] placeholderImage:[UIImage imageNamed:@"log"]];
    [btmV addSubview:btmImgV];
    
    //topImgV
    topImgV = [[UIImageView alloc]initWithFrame:btmImgV.frame];
    topImgV.userInteractionEnabled = YES;
    topImgV.image = [UIImage imageNamed:@"黑_03"];
    [btmV addSubview:topImgV];
    
    //名字
    nameL = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 200, 15)];
    nameL.font = [UIFont systemFontOfSize:15];
    nameL.textColor = [UIColor whiteColor];
    nameL.text = _diancan[1];
    [topImgV addSubview:nameL];
    
    //价格
    priceL = [[UILabel alloc]initWithFrame:CGRectMake(5, nameL.bottom + 10, 200, 15)];
    priceL.font = [UIFont systemFontOfSize:15];
    priceL.textColor = [UIColor whiteColor];
    priceL.text = [NSString stringWithFormat:@"¥%@",_diancan[2]];
    [topImgV addSubview:priceL];
    
    
    
    //三个按钮
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(topImgV.width - 113, 12, 36, 36)];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(didClickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [topImgV addSubview:_leftButton];
    
    _middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftButton.right, 12, 36, 36)];
    _middleLabel.textColor = [UIColor whiteColor];
    _middleLabel.font = [UIFont systemFontOfSize:15.0];
    _middleLabel.textAlignment = NSTextAlignmentCenter;
    NSString *num = [[CMCUserManager shareManager].dataDic objectForKey:self.diancan];
    
    _middleLabel.text = [NSString stringWithFormat:@"%@",num];
    [topImgV addSubview:_middleLabel];
    
    
    lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftButton.right, _leftButton.bottom, _middleLabel.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"diancan_line"];
    [topImgV addSubview:lineImageView];
    
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(_middleLabel.right, 12, 36, 36)];
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    
    [topImgV addSubview:_rightButton];
}

//美容美发坐标
- (void)hairDressing{
    //名字
    nameL.frame = CGRectMake(0, 0, 145, 23);
    nameL.textAlignment = NSTextAlignmentCenter;
    
    //背景图
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"project_rightPhoto"]];
    imgV.frame = nameL.frame;
    [topImgV addSubview:imgV];
    [topImgV bringSubviewToFront:nameL];
    
    
    //价格
    priceL.frame = CGRectMake(7, topImgV.height - 40, 145, 25);
    priceL.font = [UIFont systemFontOfSize:25];
    priceL.textColor  = kAPI_AllMainColor;
    
    //加减号
    _leftButton.frame = CGRectMake(topImgV.width - 113, priceL.top, 36, 36);
    _middleLabel.frame = CGRectMake(_leftButton.right, _leftButton.top, 36, 36);
    lineImageView.frame = CGRectMake(_leftButton.right, _leftButton.bottom, _middleLabel.width, 1);
    _rightButton.frame = CGRectMake(_middleLabel.right, _middleLabel.top, 36, 36);
    topImgV.image = [UIImage imageNamed:@"到店美发_03"];
}




#pragma mark - 点击方法 －
- (void)didClickLeftButton:(UIButton *)button
{
    if (self.count) {
        _middleLabel.text = [NSString stringWithFormat:@"%ld",--self.count];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemsWithNumber:andFoodModel:)]) {
        [self.delegate didClickItemsWithNumber:_middleLabel.text andFoodModel:self.diancan];
    }
    
    
}
- (void)didClickRightButton:(UIButton *)button
{
    _middleLabel.text = [NSString stringWithFormat:@"%ld",++self.count];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemsWithNumber:andFoodModel:)]) {
        [self.delegate didClickItemsWithNumber:_middleLabel.text andFoodModel:self.diancan];
    }
    
}


#pragma mark - 公共方法 － 




#pragma end
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
