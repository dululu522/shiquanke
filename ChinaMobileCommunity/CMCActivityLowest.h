//
//  CMCActivityLowest.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCActivityLowest : NSObject
@property (nonatomic, strong) NSString *address,*image,*name,*star,*mid;
- (id)initWithActivityLowestDic:(NSDictionary *)dic;
@end
