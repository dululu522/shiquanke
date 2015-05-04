//
//  CMCActivityNewlyOpened.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-22.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCActivityNewlyOpened : NSObject
@property (nonatomic, strong) NSString *address,*image,*intro,*name,*mid;
- (id)initWithActivityNewlyOpened:(NSDictionary *)dic;
@end
