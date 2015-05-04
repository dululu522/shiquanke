//
//  FocusImageView.h
//  shiquanke
//
//  Created by zt on 14-6-24.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FocusImageItem.h"

@interface FocusImageView : UIImageView

@property (nonatomic, strong) FocusImageItem* item;

-(id)initWithItem:(FocusImageItem*)im;

@end
