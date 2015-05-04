//
//  CMCCommunityNotification.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCommunityNotification.h"

@implementation CMCCommunityNotification
- (id) initWithCommunityNotificationDic:(NSDictionary *)dic
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
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{


}
@end
