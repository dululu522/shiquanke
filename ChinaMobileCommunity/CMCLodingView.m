//
//  CMCLodingView.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCLodingView.h"

@implementation CMCLodingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatLoading
{
    self.loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.window.frame.size.width/2 - 20, self.window.frame.size.height/2 - 20, 40, 40)];
    _loadImageView.image = [UIImage imageNamed:@"loading"];
    [self.window addSubview:_loadImageView];
    CABasicAnimation *animagtion = [CABasicAnimation animationWithKeyPath:@"transform"];
    animagtion.delegate =self;
    animagtion.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.0)];
    animagtion.duration = 1;
    animagtion.cumulative = YES;
    animagtion.repeatCount = INT_MAX;
    [_loadImageView.layer addAnimation:animagtion forKey:@"animagtion"];
}
- (void)stopLoading
{

    [self.loadImageView removeFromSuperview];

}
@end
