//
//  CMCQScrollView.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCQScrollViewDelegate <NSObject>

- (void)tapImageViewCount:(NSInteger)tapCount;


@end

@interface CMCQScrollView : UIView<UIScrollViewDelegate>
{
    NSTimer *_time;
}

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, assign) id<CMCQScrollViewDelegate> delegate;


- (void)creatWithFrame:(CGRect)frame cout:(NSInteger)count;
- (void)stopScorllView;


@end
