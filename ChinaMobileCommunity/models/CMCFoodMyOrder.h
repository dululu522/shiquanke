//
//  CMCFoodMyOrder.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCFoodMyOrder : NSObject
@property (nonatomic, copy) NSString *goodsinfo,*id,*num,*order_num,*shop_name,*status,*store_id,*sum_price,*time,*is_eval; //is_eval 是否评价
- (id) initWithFoodMyOrder:(NSDictionary *)dic;
@end
