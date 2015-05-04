//
//  CMCBooking.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-26.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCBooking : NSObject
@property (nonatomic, strong) NSString *addtime,*category_id,*comment,*desknum,*id,*peoplenum,*reservephone,*reservetime,*sex,*store_id,*store_status,*type,*user_id,*username;
- (id)initWithBookDic:(NSDictionary *)dic;

@end
