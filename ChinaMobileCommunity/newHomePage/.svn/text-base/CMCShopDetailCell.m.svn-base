//
//  CMCShopDetailCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailCell.h"
#import "CommentStarView.h"

@interface CMCShopDetailCell ()


@property (nonatomic,strong)photoBlock block;

@end

@implementation CMCShopDetailCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}



- (void)createSubViews{
    //头像
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 80, 80)];
    imgView.layer.cornerRadius = 40;
    imgView.clipsToBounds = YES;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [imgView addGestureRecognizer:tap];
    
    NSURL *url = [BaseUtil systemRandomlyGenerated:_myModel.image type:@"10" number:@"1"];
    NSLog(@"-------url = %@",url);
    [imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:imgView];
    
    //商铺相册数量
    UIButton *numBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    numBtt.frame = CGRectMake(imgView.right - 22,20,22,14);
    numBtt.titleLabel.font = [UIFont systemFontOfSize:12];
    [numBtt setTitle:self.num forState:UIControlStateNormal];
    [numBtt setBackgroundImage:[UIImage imageNamed:@"photoNum"] forState:UIControlStateNormal];
//    numBtt.enabled = NO;
    [self.contentView addSubview:numBtt];
    
    //超市名称
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width + imgView.frame.origin.x + 5, 14, self.frame.size.width - 121, 25)];
    titleL.text = _myModel.name;
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = [UIColor colorWithHexString:@"5b5b5b"];
    [self.contentView addSubview:titleL];
    
    //时间
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.origin.x,titleL.frame.origin.y + titleL.frame.size.height + 10, self.frame.size.width - 121, 24)];
    timeL.font = [UIFont systemFontOfSize:11];
    //加分割号
    if (_myModel.time) {
        NSMutableString *timeStr = [NSMutableString stringWithString:_myModel.time];
        [timeStr insertString:@":" atIndex:2];
        [timeStr insertString:@":" atIndex:8];
        timeL.text = [NSString stringWithFormat:@"营业时间:%@",timeStr];
    }
    timeL.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:timeL];
    
    
    CommentStarView *star = [[CommentStarView alloc]initWithFrame:CGRectMake(timeL.frame.origin.x, timeL.frame.origin.y + timeL.frame.size.height + 10, 150, 14)];
    star.startNum = [_myModel.star intValue];
    star.titleStr = @"综合评价:";
    [self.contentView addSubview:star];
    
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
}

- (void)tap:(UITapGestureRecognizer *)sender{
    if (_block) {
        _block();
    }
}

- (void)setupPhotoBlock:(photoBlock)myBlock{
    if (_block != myBlock) {
        _block = myBlock;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
