//
//  CMCPropertyFeeList.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPropertyFeeList.h"

@implementation CMCPropertyFeeList
- (id)initWithPropertyFeeList:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end
