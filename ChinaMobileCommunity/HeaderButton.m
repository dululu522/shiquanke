//
//  HeaderButton.m
//  shiquanke
//
//  Created by zt on 14-7-9.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "HeaderButton.h"

@implementation HeaderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 42, 160, 2)];
        line.backgroundColor = [UIColor orangeColor];
        line.tag = 108;
        line.hidden = YES;
        [self addSubview:line];
        
        UIView* bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 160, 1)];
        bottom.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:.3];
        [self addSubview:bottom];

        if (frame.origin.x != 0) {
            UIView* left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
            left.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:.3];
            [self addSubview:left];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    UIView* v = [self viewWithTag:108];
    if (selected) {
        v.hidden = NO;
    }else{
        v.hidden = YES;
    }
}

@end
