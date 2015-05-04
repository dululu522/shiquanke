//
//  CMCVouchers.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCVouchers : NSObject
@property(nonatomic,copy) NSString *id,*title,*description,*discount,*image,*before_price,*price;
- (id) initWithVouchersDic:(NSDictionary *)dic;

@end
