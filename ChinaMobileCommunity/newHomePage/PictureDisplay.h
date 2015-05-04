//
//  PictureDisplay.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-2.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureDisplay : UIScrollView<UIScrollViewDelegate>


@property (retain, nonatomic) UIImageView *picImageView;
//@property (retain, nonatomic) UILabel *pageLabel;

- (id)initWithImage:(UIImage *) image withFrame:(CGRect)frame;

+ (id)pictureWith:(UIImage *) image withFrame:(CGRect)frame;

@end
