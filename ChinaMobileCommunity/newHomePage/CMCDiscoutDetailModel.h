//
//  CMCCouponDetailModel.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
//优惠券详情model
@interface CMCDiscoutDetailModel : NSObject
@property (nonatomic, strong) NSString *address,*auto_refund,*cid,*close_time,*create_time,*days,*discount,*id,*image,*intro,*logo,*mid,*money_buy,*money_use,*name,*notice,*nums,*phone,*refund,*state,*total,*type,*update_time,*zid,*use_nums;
- (id)initWithCouponDetailModel:(NSDictionary *)CouponDetail;
@end