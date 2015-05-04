//
//  MD5.h
//  ThirdPartyClient
//
//  Created by Wolf on 13-9-26.
//
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

+ (NSString *)signString:(NSString *)string;

+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;

@end
