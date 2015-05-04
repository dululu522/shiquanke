//
//  CyCleScrollView.m
//  TestSear
//
//  Created by mac on 14-12-20.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "CMCMyScrollView.h"

@interface CMCMyScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *myScrollView;
@property (nonatomic,assign) NSTimeInterval animationDuration;
@property (nonatomic,assign)int currentPage;
@property (nonatomic,assign)float anmotion;
@property (nonatomic,strong)TapActionBlock block;
@property (nonatomic,strong)UIPageControl *pageControl;



@end


@implementation CMCMyScrollView


- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(runTimer:)
                                                             userInfo:nil
                                                              repeats:YES];
        self.anmotion = animationDuration;
//        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentPage = 0;
        
    }
    return self;
}


- (void)setupScrollView{
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
    
    self.myScrollView.contentSize = CGSizeMake(self.bounds.size.width * self.dataArr.count, 0);
    //  锁定滑动方向
    self.myScrollView.directionalLockEnabled = NO;
    //  弹跳效果
    self.myScrollView.bounces = NO;
    //  分页效果
    self.myScrollView.pagingEnabled = YES;
    //  滚动条
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.delegate = self;
    //  scrollView 上面添加imageView
    for (int i = 0; i < self.dataArr.count; i++)
    {
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.bounds.size.width, self.frame.size.height)];
        picImageView.tag = i;
       
        NSLog(@"%@",[self.dataArr objectAtIndex:i]);
//        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[self.dataArr objectAtIndex:i]]];
        [picImageView setImageWithURL:[self.dataArr objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"log"]];
//        picImageView.image = image;
//        picImageView.backgroundColor = [UIColor colorWithRed:arc4random()%2  green:arc4random()%2 blue:arc4random()%2 alpha:1];
        picImageView.userInteractionEnabled = YES;
        //这里做赋值操作(可用sdweb直接加载)
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [picImageView addGestureRecognizer:tap];
        
        [self.myScrollView addSubview:picImageView];
        
    }
    [self addSubview:self.myScrollView];
    
    
    //如果是一张图片就不加了
    if (self.dataArr.count != 1) {
        self.pageControl = [[UIPageControl alloc]init];
        _pageControl.frame = CGRectMake(0, 145, self.width, 10);
        _pageControl.numberOfPages = self.dataArr.count;
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }
    
    
}


#pragma mark - 计时器响应方法 － 

- (void)runTimer:(NSTimer *)timer{
    
    if (_currentPage == self.dataArr.count) {
        _currentPage = 0;
    }
    
     [self.myScrollView setContentOffset:CGPointMake(self.frame.size.width *_currentPage, 0) animated:YES];
    _pageControl.currentPage = _currentPage;
    
    _currentPage++;
}

- (void)tap:(UITapGestureRecognizer *)sender{
    UIImageView *imageView  = (UIImageView *)sender.view;
    
    
    if (_block) {
        _block(imageView.tag);
    }
    
    
}

- (void)setupTapActionBlock:(TapActionBlock)myBlock{
    if (_block != myBlock) {
        _block = myBlock;
    }
    
    
}

- (void)setDataArr:(NSArray *)dataArr{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    [self setupScrollView];
}


#pragma mark - scrollviewDelegate - 

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //  计算scrollView的contentOffset
    CGPoint offsetPoint = scrollView.contentOffset;
    _currentPage = offsetPoint.x / self.frame.size.width;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_animationTimer invalidate];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = self.anmotion)
                                                           target:self
                                                         selector:@selector(runTimer:)
                                                         userInfo:nil
                                                          repeats:YES];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
