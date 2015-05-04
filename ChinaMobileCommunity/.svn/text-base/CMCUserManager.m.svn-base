//
//  CMCUserManager.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCUserManager.h"
#import "SFHFKeychainUtils.h"

@implementation CMCUserInfo
+ (instancetype)fromDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    CMCUserInfo *user = [[CMCUserInfo alloc] init];
    user.id = [dict objectForKey:@"id"];  //用户登录id
    user.username = [dict objectForKey:@"username"]; //用户名
    return user;
}
@end

static CMCUserManager *userManager= nil;
@implementation CMCUserManager
+ (instancetype)shareManager
{

    if (!userManager) {
        userManager = [[CMCUserManager alloc] init];
    }
    return userManager;
}
+ (void)storeAccountInKeychain:(NSString*)Account
{
    if (Account) {
        [SFHFKeychainUtils storeUsername:@"My_email" andPassword:Account
                          forServiceName:@"ServiceName_shiquanke" updateExisting:YES error:nil];
    }
}
+ (void)storePasswordInKeychain:(NSString*)psd
{
    if (psd) {
        [SFHFKeychainUtils storeUsername:@"My_psd" andPassword:psd
                          forServiceName:@"ServiceName_shiquanke" updateExisting:YES error:nil];
    }
}
+ (NSString*)getAccountFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:@"My_email" andServiceName:@"ServiceName_shiquanke" error:nil];
    return key;
}
+ (NSString*)getPasswordFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:@"My_psd" andServiceName:@"ServiceName_shiquanke" error:nil];
    return key;
}
+ (void)clearAccountInfo
{
    [SFHFKeychainUtils deleteItemForUsername:@"My_email" andServiceName:@"ServiceName_shiquanke" error:nil];
    [SFHFKeychainUtils deleteItemForUsername:@"My_psd" andServiceName:@"ServiceName_shiquanke" error:nil];
}


+ (BOOL)isLogined
{
    if ([[CMCUserManager shareManager] userInfo])
        return YES;
    else
        return NO;
}
//根据字符串得到所占的高度
+ (CGRect)_getSizeWithString:(NSString *)string withWidth:(NSInteger)width withHeight:(NSInteger)height{
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(width, height);
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}
@end
