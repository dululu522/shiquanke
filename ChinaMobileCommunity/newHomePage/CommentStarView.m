//
//  CommentStarView.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CommentStarView.h"
#define ZOOM 0.8f

@interface CommentStarView ()

@property (nonatomic,strong) UIView *bottomView;//底部视图
@property (nonatomic,strong) UIView *topView;//显示视图
@property (nonatomic,assign) CGFloat starWidth;

@end

@implementation CommentStarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, frame.size.width - 50, frame.size.height)];
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        //基本配置
        self.topView.clipsToBounds = YES;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        
        
        //加图片
        CGFloat width = (frame.size.width - 50) / 6.0;
        self.starWidth = width;
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width * ZOOM , width * ZOOM)];
            img.center = CGPointMake(i * width + 0.5 * width, frame.size.height / 2);
            img.image = [UIImage imageNamed:@"convenience_star"];
            [self.bottomView addSubview:img];
            
            UIImageView *img2 = [[UIImageView alloc]initWithFrame:img.frame];
            img2.center = img.center;
            img2.image = [UIImage imageNamed:@"convenience_starSelect"];
            [self.topView addSubview:img2];
        }
        
       
        
    }
    return self;
}

- (void)setStartNum:(NSInteger)startNum{
    if (_startNum != startNum) {
        _startNum = startNum;
        self.topView.frame = CGRectMake(50, 0, self.starWidth*startNum, self.bounds.size.height);
        
    }
}

- (void)setTitleStr:(NSString *)titleStr{
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
        UILabel *titleL = [[UILabel alloc]init];
        titleL.frame = CGRectMake(0, 0, 50, self.frame.size.height);
        titleL.text = _titleStr;
        titleL.lineBreakMode = NSLineBreakByTruncatingMiddle;
        titleL.font = [UIFont systemFontOfSize:11];
        titleL.textColor = [UIColor colorWithHexString:@"6b6b6b"];
        [self addSubview:titleL];
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
