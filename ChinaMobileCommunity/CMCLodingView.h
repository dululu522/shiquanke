//
//  CMCLodingView.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCLodingView : UIView
@property (nonatomic, strong)UIImageView *loadImageView;
- (void)creatLoading;
- (void)stopLoading;
@end
