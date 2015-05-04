//
//  CMCFoodDetail.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-20.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFoodDetail.h"

@implementation CMCFoodDetail
- (id)initWithDetailFood:(NSDictionary *)dic
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
