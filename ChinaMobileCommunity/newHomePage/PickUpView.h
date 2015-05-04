//
//  PickUpView.h
//  YoungCrops
//
//  Created by mac on 14-11-26.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PickUpBlock)(NSUInteger tag);

@interface PickUpView : UIView

@property (nonatomic,strong)UIImageView *discoutImgV;//折扣券
@property (nonatomic,strong)UIImageView *voucherImgV;//代金券
- (void)setMyBlock:(PickUpBlock)myBlock;



@end
