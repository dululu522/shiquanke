//
//  CMCActivity.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCActivity : NSObject
//@property (nonatomic, strong) NSString *act_id,*cid,*create_time,*id,*mid,*nums,*over_time,*start_time,*type,*update_time,*zid;
@property (nonatomic, strong) NSString *address,*end_time,*name,*id;
@property (nonatomic, strong) NSArray *images;
- (id)initWithActivityDic:(NSDictionary *)dic;
@end
