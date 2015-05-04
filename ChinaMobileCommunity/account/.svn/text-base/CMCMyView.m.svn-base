//
//  CMCMyView.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyView.h"

@implementation CMCMyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)creatLeftLabel:(NSString *)leftText rightLabel:(NSString *)rightText frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [self addSubview:view];
    
    UILabel *bookingpeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 140, 24)];
    bookingpeopleLabel.text = leftText;
    bookingpeopleLabel.textColor = [UIColor colorWithHexString:@"393939"];
    bookingpeopleLabel.font = [UIFont systemFontOfSize:12.0];
    [view addSubview:bookingpeopleLabel];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 130, 0, 120, 24)];
    telLabel.textColor = [UIColor colorWithHexString:@"393939"];
    telLabel.font = [UIFont systemFontOfSize:12.0];
    telLabel.text = rightText;
    [view addSubview:telLabel];



}
@end
