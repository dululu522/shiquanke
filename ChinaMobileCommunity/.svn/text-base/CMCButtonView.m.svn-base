//
//  CMCButtonView.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCButtonView.h"
#import "UIColor+ChangeColor.h"

@implementation CMCButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatButtonNumber:(NSInteger)totalNumber count:(NSInteger)count imageArr:(NSArray *)imageArr textArr:(NSArray *)textArr ScrollView:(UIView *)scrollView
{
    float WIDTH = 0;
    if (count >= 4) {
        WIDTH = 80;
    } else {
        WIDTH = scrollView.frame.size.width / count;
    }
    NSLog(@"================%f",WIDTH);
    for (int i = 0; i < totalNumber/count; i++) {
        for (int j = 0; j < count; j++) {
            UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0+WIDTH*j, 0 + WIDTH*i, WIDTH, WIDTH)];
            buttonView.tag = 1000 + i*5+j;
            [scrollView addSubview:buttonView];
            UIImage *image = [UIImage imageNamed:[imageArr objectAtIndex:i*count+j]];
            float x = (WIDTH - image.size.width)/2;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 15, image.size.width, image.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i*count+j]];
            [buttonView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+image.size.height +10, WIDTH, 20)];
            label.text = [textArr objectAtIndex:i*count+j];
            [buttonView addSubview:label];
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = [UIColor colorWithHexString:@"4e4e4e"];
            label.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [buttonView addGestureRecognizer:tap];
            
            
        }
        
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击哪一个  %ld",(long)tap.view.tag);

    [self.delegate tapNumber:tap.view.tag - 1000];
    


}
- (void)creatButtonNumber:(NSInteger)totalNumber count:(NSInteger)count imageArr:(NSArray *)imageArr textArr:(NSArray *)textArr ScrollView:(UIView *)scrollView tag:(NSInteger)tag
{
    self.currentTag = tag;
    float WIDTH = 0;
    if (count >= 4) {
        WIDTH = 80;
    } else {
        WIDTH = scrollView.frame.size.width / count;
    }
    NSLog(@"================%f",WIDTH);
    for (int i = 0; i < totalNumber/count; i++) {
        for (int j = 0; j < count; j++) {
            UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0+WIDTH*j, 0 + WIDTH*i, WIDTH, WIDTH)];
            buttonView.tag = 100*tag + i*5+j;
            [scrollView addSubview:buttonView];
            UIImage *image = [UIImage imageNamed:[imageArr objectAtIndex:i*count+j]];
            float x = (WIDTH - image.size.width)/2;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 15, image.size.width, image.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i*count+j]];
            [buttonView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+image.size.height +10, WIDTH, 20)];
            label.text = [textArr objectAtIndex:i*count+j];
            [buttonView addSubview:label];
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = [UIColor colorWithHexString:@"4e4e4e"];
            label.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwoAction:)];
            [buttonView addGestureRecognizer:tap];
            
            
        }
        
    }
}
- (void)tapTwoAction:(UITapGestureRecognizer *)tap
{


    NSLog(@"点击哪一个  %ld",(long)tap.view.tag);
//    [self.delegate tapNumber:tap.view.tag];

}
@end
