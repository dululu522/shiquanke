//
//  CMCCacheTool.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-12.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCCacheTool : NSObject
//获取物业信息里的数据 (地址,时间,id,name,phone,recycle_time,update_time,zid)
+ (NSString *)getPropertyInformationParameter:(NSString *)parameter;

@end
