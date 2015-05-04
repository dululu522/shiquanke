//
//  CMCQScrollView.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCQScrollView.h"

static NSInteger i = 0;
@implementation CMCQScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatWithFrame:(CGRect)frame cout:(NSInteger)count
{
    self.myScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(320 * count, frame.size.height);
    [self addSubview:self.myScrollView];
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40, frame.size.height - 25, 80, 10)];
    self.pageControl.numberOfPages = count;
    [self addSubview:self.pageControl];
    [self creatImageArr];
    i = self.pageControl.currentPage;
    /*设置定时器*/
    if (count == 1) {
        
    } else {
    _time  = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollViewRoll) userInfo:nil repeats:YES];
    }

    
    
}
- (void)creatImageArr
{
    NSLog(@"%@",self.imageArr);
    NSLog(@"qqq %lu",(unsigned long)self.imageArr.count);
    
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*320, 0, self.frame.size.width, 120)];
        [imageView setImageWithURL:[self.imageArr objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"log"]];
        imageView.tag = i + 4000;
        imageView.userInteractionEnabled = YES;
        [self.myScrollView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
    }
    
    
}
- (void)tap:(UITapGestureRecognizer *)tap
{
//    [self.delegate tapImageViewCount:tap.view.tag - 4000];
}
/*设置scrollView自动滚动*/
- (void)scrollViewRoll
{
    
    CGPoint newScrollViewContentOffset = self.myScrollView.contentOffset;
    newScrollViewContentOffset.x = 320 * i;
    [self.myScrollView setContentOffset:newScrollViewContentOffset animated:YES];
    
    newScrollViewContentOffset.x = MAX(newScrollViewContentOffset.x , 0);
    ++i;
    if (newScrollViewContentOffset.x == 320 *(self.imageArr.count-1)) {
        newScrollViewContentOffset.x = 0;
        i = 0;
    }
    
}

/*pageControl随scrollView的位置移动改变值*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int halfx = scrollView.frame.size.width / 2;
    int page = (scrollView.contentOffset.x - halfx) / 320 + 1;
    self.pageControl.currentPage = page;
    i = self.pageControl.currentPage;

}
- (void)stopScorllView
{

    [_time invalidate];

}
@end
