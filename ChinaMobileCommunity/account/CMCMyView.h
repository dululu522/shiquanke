//
//  CMCMyView.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCMyView : UIView
//创建左边的label 右边的label    ********预订详情
- (void)creatLeftLabel:(NSString *)leftText rightLabel:(NSString *)rightText frame:(CGRect)frame;
@end
