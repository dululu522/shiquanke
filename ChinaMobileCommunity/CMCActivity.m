//
//  CMCActivity.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivity.h"

@implementation CMCActivity
- (id)initWithActivityDic:(NSDictionary *)dic
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
