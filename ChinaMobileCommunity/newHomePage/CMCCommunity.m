//
//  CMCCommunity.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCCommunity.h"

@implementation CMCCommunity
- (id)initWithCommunityDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;

}
@end
