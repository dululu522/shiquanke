//
//  CMCAddressItem.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAddressItem.h"

@implementation CMCAddressItem
+ (instancetype)fromDict:(NSDictionary*)dict
{
    if (dict == nil) {
        return nil;
    }
    CMCAddressItem *addressItem = [[CMCAddressItem alloc] init];
    addressItem.address = [dict objectForKey:@"address"];
    addressItem.id = [dict objectForKey:@"id"];
    addressItem.phone = [dict objectForKey:@"phone"];
    addressItem.name = [dict objectForKey:@"name"];
    
    return addressItem;
}

@end
