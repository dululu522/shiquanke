//
//  PickUpView.m
//  YoungCrops
//
//  Created by mac on 14-11-26.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "PickUpView.h"

@interface PickUpView ()

@property (nonatomic,strong)UIButton *normalBtt;//日常接送
@property (nonatomic,strong)UIButton *entrustBtt;//委托接送

@property (nonatomic,strong)PickUpBlock block;

@end


@implementation PickUpView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubViews];
    }
    return self;
}


- (void)creatSubViews{
    //日常接送
    self.normalBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normalBtt.frame = CGRectMake(0, 0,self.frame.size.width * 0.5 - 0.5,self.frame.size.height);
    self.normalBtt.tag = 200;
    [self.normalBtt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.normalBtt setTitle:@"代金券" forState:UIControlStateNormal];
    [self.normalBtt setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    self.normalBtt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.normalBtt addTarget:self action:@selector(ClickBttAction:) forControlEvents:UIControlEventTouchUpInside];
    //分割线
    UIView *seperatorView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 0.5, (1 - 0.55) * self.frame.size.height / 2, 1, 0.55 * self.frame.size.height)];
    seperatorView.backgroundColor = k_color(@"edecec");
    
    
     //委托接送
    self.entrustBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.entrustBtt.frame = CGRectMake(self.frame.size.width * 0.5, 0,self.frame.size.width * 0.5, self.frame.size.height);
//    self.entrustBtt.backgroundColor = [UIColor blueColor];
    [self.entrustBtt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.entrustBtt.tag = 201;
    [self.entrustBtt setTitle:@"折扣券" forState:UIControlStateNormal];
    [self.entrustBtt setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    self.entrustBtt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.entrustBtt addTarget:self action:@selector(ClickBttAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //代金券
    self.discoutImgV = [[UIImageView alloc]init];
    self.discoutImgV.frame = CGRectMake(106, 10, 15, 11);
    self.discoutImgV.image = [UIImage imageNamed:@"icon_onsalezone_voun_press "];
    self.discoutImgV.userInteractionEnabled = YES;
    //折扣券
    self.voucherImgV = [[UIImageView alloc]init];
    self.voucherImgV.frame = CGRectMake(266, 10, 15, 11);
    self.voucherImgV.image = [UIImage imageNamed:@"icon_onsalezone_dis_unpress "];;
    self.voucherImgV.userInteractionEnabled = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    view.backgroundColor = k_color(@"bebebe");
    

    
    [self addSubview:self.normalBtt];
    [self addSubview:seperatorView];
    [self addSubview:self.entrustBtt];
    [self addSubview:self.discoutImgV];
    [self addSubview:self.voucherImgV];
    [self addSubview:view];
 
    
}


- (void)ClickBttAction:(UIButton *)sender{
    
    if (_block) {
        _block(sender.tag);
    }
    
    
}


- (void)setMyBlock:(PickUpBlock)myBlock{
    
    self.block = myBlock;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
