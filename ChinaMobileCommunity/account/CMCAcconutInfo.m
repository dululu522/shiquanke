//
//  CMCAcconutInfo.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-30.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAcconutInfo.h"

@implementation CMCAcconutInfo
+ (instancetype)fromDict:(NSDictionary*)dict
{
    CMCAcconutInfo *accountInfo = [[CMCAcconutInfo alloc] init];
    accountInfo.birthday = [dict objectForKey:@"birthday"];
    accountInfo.d = [dict objectForKey:@"d"];

    accountInfo.gender = [dict objectForKey:@"gender"];
    accountInfo.id = [dict objectForKey:@"id"];
    accountInfo.m = [dict objectForKey:@"m"];
    accountInfo.nickname = [dict objectForKey:@"nickname"];
    accountInfo.personaltext = [dict objectForKey:@"personaltext"];
    accountInfo.real_name = [dict objectForKey:@"real_name"];
    accountInfo.y = [dict objectForKey:@"y"];

    return accountInfo;
}

@end
