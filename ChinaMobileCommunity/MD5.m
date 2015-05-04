//
//  MD5.m
//  ThirdPartyClient
//
//  Created by Wolf on 13-9-26.
//
//

#import <CommonCrypto/CommonDigest.h>
#import "MD5.h"

@implementation MD5

+ (NSString *)signString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];

    return result;
}

+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString {
    return [signString isEqualToString:[self signString:string]];
}

@end
