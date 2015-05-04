//
//  ReslutView.m
//  Comment
//
//  Created by 武鹏 on 14-11-10.
//  Copyright (c) 2014年 武鹏. All rights reserved.
//

#import "ReslutView.h"

@interface ReslutView ()




@end





@implementation ReslutView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(55, 0, 200, 15)];
        view.backgroundColor = [UIColor colorWithHexString:@"d7d7d7"];
        [self addSubview:view];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 15)];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.titleLabel];
        
        self.reslutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
        self.reslutView.backgroundColor = [UIColor colorWithHexString:@"c4c4c4"];
        [view addSubview:self.reslutView];
        
    }
    
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
