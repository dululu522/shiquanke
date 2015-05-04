//
//  CMCVouchers.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVouchers.h"

@implementation CMCVouchers
@synthesize description;
- (id) initWithVouchersDic:(NSDictionary *)dic
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
