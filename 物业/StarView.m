//
//  StarView.m
//  Comment
//
//  Created by 武鹏 on 14-11-10.
//  Copyright (c) 2014年 武鹏. All rights reserved.
//

#import "StarView.h"
#define ZOOM 0.8f


@interface StarView ()

@property (nonatomic,strong) UIView *bottomView;//底部视图
@property (nonatomic,strong) UIView *topView;//显示视图
@property (nonatomic,assign) CGFloat starWidth;
@property (nonatomic,strong)numberBlock block;


@end

@implementation StarView

- (void)setButtonBlock:(numberBlock)myBlock{
    self.block = myBlock;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bottomView = [[UIView alloc]initWithFrame:self.bounds];
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        //基本配置
        self.topView.clipsToBounds = YES;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        
        //加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        //加图片
        CGFloat width = frame.size.width / 6.0;
        self.starWidth = width;
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width * ZOOM , width * ZOOM)];
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18 , 17)];
            img.center = CGPointMake((i + 1.5)*width, frame.size.height / 2);
            img.image = [UIImage imageNamed:@"convenience_star"];
            [self.bottomView addSubview:img];
            
            UIImageView *img2 = [[UIImageView alloc]initWithFrame:img.frame];
            img2.center = img.center;
            img2.image = [UIImage imageNamed:@"convenience_starSelect"];
//            img2.backgroundColor = [UIColor orangeColor];
            [self.topView addSubview:img2];
        }
        
        self.enable = YES;
    }
    
    return self;
}

- (void)setViewColor:(UIColor *)viewColor{
    if (_viewColor != viewColor) {
        self.backgroundColor = viewColor;
        self.topView.backgroundColor = viewColor;
        self.bottomView.backgroundColor = viewColor;
    }
    
}

- (void)setStarNumber:(NSInteger)starNumber{
    if (_starNumber != starNumber) {
        _starNumber = starNumber;
        self.topView.frame = CGRectMake(0, 0, self.starWidth*(starNumber+1), self.bounds.size.height);
        
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    if (self.enable) {
        CGPoint point = [gesture locationInView:self];//得到点击的位置
        NSInteger count = (int)(point.x/self.starWidth)+1;//得到点击星的位置
        self.topView.frame = CGRectMake(0, 0, self.starWidth*count, self.bounds.size.height);
        if(count>5){
            _starNumber = 5;
        }else{
            _starNumber = count-1;
        }
    }
    
    //传参数
    if (_block) {
        _block(_starNumber);
    }
    
}
    
    
    
    


- (void)pan:(UIPanGestureRecognizer *)gesture{
    
    if(self.enable){
        CGPoint point = [gesture locationInView:self];//得到点击的位置
        NSInteger count = (int)(point.x/self.starWidth);
        if(count>=0 && count<=5 && _starNumber!=count){
            self.topView.frame = CGRectMake(0, 0, self.starWidth*(count+1), self.bounds.size.height);
            _starNumber = count;
        }
    }

    //传参数
    if (_block != nil) {
        _block(_starNumber);
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
