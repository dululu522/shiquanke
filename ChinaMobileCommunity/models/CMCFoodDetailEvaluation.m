//
//  CMCFoodDetailEvaluation.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-20.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFoodDetailEvaluation.h"

@implementation CMCFoodDetailEvaluation
- (id) initWithEvaluation:(NSDictionary *)dic
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
