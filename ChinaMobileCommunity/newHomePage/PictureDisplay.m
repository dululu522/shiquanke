//
//  PictureDisplay.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-2.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "PictureDisplay.h"

@implementation PictureDisplay



- (id)initWithImage:(UIImage *) image withFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.contentSize = self.frame.size;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 10.0;
        self.zoomScale = 1.0;
        self.delegate = self;
        
        self.picImageView = [[UIImageView alloc] initWithImage:image];
        self.picImageView.backgroundColor = [UIColor redColor];
        [self getSizeWithImage:image];
        [self addSubview:self.picImageView];
    }
    return self;
}

+ (id)pictureWith:(UIImage *) image withFrame:(CGRect)frame{
    return [[PictureDisplay alloc] initWithImage:image withFrame:frame];
}



//得到size
- (void)getSizeWithImage:(UIImage *)image{
    float imageW = image.size.width;
    float imageH = image.size.height;
    
    if (imageW <= self.width && imageH <= self.height) {
        self.picImageView.frame = CGRectMake(0, 0, imageW, imageW);
        self.picImageView.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, self.center.y);
    }
    
    if (imageW > self.width && imageH <= self.height) {
        self.picImageView.frame = CGRectMake(0, 0, self.width, imageH * self.width  / imageW);
        
        self.picImageView.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, self.center.y);
    }
    
    if (imageW > self.width && imageH > self.height) {
        self.picImageView.frame = CGRectMake(0, 0, self.width, imageH * self.width  / imageW);
        self.contentSize = CGSizeMake(self.width, imageH * self.width  / imageW);
        self.picImageView.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, self.center.y);
    }
    
    if (imageW <= self.width && imageH > self.height) {
        self.picImageView.frame = CGRectMake((self.width - imageW)/2, 0, imageW, imageH);
        self.contentSize = CGSizeMake(imageW, imageH);
    }
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.picImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGRect iamgeViewToCenter = self.picImageView.frame;
    CGFloat x, y;
    if (iamgeViewToCenter.size.width < scrollView.bounds.size.width) {
        x = (scrollView.bounds.size.width - iamgeViewToCenter.size.width) / 2;
    }else{
        x = 0;
    }
    
    if (iamgeViewToCenter.size.height < scrollView.bounds.size.height) {
        y = (scrollView.bounds.size.height - iamgeViewToCenter.size.height) / 2;
    }else{
        y = 0;
    }
    
    iamgeViewToCenter.origin.x = x;
    iamgeViewToCenter.origin.y = y;
    self.picImageView.frame = iamgeViewToCenter;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
