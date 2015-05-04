//
//  CMCDianCan.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-20.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCNewClassfyDianCan : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
- (id) initWithDianCan:(NSDictionary *)dic;


@end
