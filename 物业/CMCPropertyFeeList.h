//
//  CMCPropertyFeeList.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCPropertyFeeList : NSObject
@property (nonatomic, copy) NSString *address,*cid,*comment,*create_time,*id,*money,*month,*name,*nums,*over_time,*owner_id,*payment_type,*phone,*start_time,*state,*type,*uid,*update_time,*zid;
- (id)initWithPropertyFeeList:(NSDictionary *)dic;
@end
