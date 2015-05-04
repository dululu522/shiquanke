//
//  CMCDiscount.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCDiscount : NSObject
@property (nonatomic, copy) NSString *before_price,*description,*discount,*id,*image,*price,*title;
- (id)initWithDiscount:(NSDictionary *)dic;
@end
