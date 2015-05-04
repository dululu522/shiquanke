//
//  CMCPacket.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-13.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPacket.h"

@implementation CMCPacket
- (id)initWithPacketDic:(NSDictionary *)packet
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:packet];
    }
    return self;


}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;

}
@end
