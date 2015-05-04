//
//  CMCVouchersDetailModel.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCVouchersDetailModel.h"

@implementation CMCVouchersDetailModel
- (id)initWithVouchersDetailModel:(NSDictionary *)dic
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
