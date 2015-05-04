//
//  CMCAcconutInfo.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-30.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCAcconutInfo : NSObject
@property (nonatomic, strong) NSString *birthday,*d,*gender,*id,*m,*nickname,*personaltext,*real_name,*y;
+ (instancetype)fromDict:(NSDictionary*)dict;

@end
