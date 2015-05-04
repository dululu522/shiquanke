//
//  CMCPersonalInformation.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPersonalInformation.h"

@implementation CMCPersonalInformation
- (id) initWithPersonalInformation:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;

}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;

}
@end
