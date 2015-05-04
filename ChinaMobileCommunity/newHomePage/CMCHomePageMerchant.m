//
//  CMCHomePageMerchant.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-9.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCHomePageMerchant.h"

@implementation CMCHomePageMerchant
- (id) initWithCMCHomePageMerchantDic:(NSDictionary *)merchantDic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:merchantDic];
    }

    return self;
}
//- (id)valueForUndefinedKey:(NSString *)key
//{
//    return nil;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
