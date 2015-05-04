//
//  CMCActivityLowest.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivityLowest.h"

@implementation CMCActivityLowest
- (id)initWithActivityLowestDic:(NSDictionary *)dic
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
