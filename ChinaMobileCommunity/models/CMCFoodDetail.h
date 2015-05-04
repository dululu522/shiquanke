//
//  CMCFoodDetail.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-20.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCFoodDetail : NSObject
@property (nonatomic,copy) NSString *merchant_service;

@property (nonatomic,copy) NSString *merchant_id;
@property (nonatomic,copy) NSString *merchant_name;
@property (nonatomic,copy) NSString *merchant_addr;
@property (nonatomic,copy) NSString *merchant_image;
@property (nonatomic,copy) NSString *merchant_content;
@property (nonatomic,copy) NSString *merchant_action;
@property (nonatomic,copy) NSString *merchant_gdp;
@property (nonatomic,copy) NSString *merchant_persontrip;
@property (nonatomic,copy) NSString *merchant_opentime;

@property (nonatomic,copy) NSString *mobile_phone,*phone;
@property (nonatomic,copy) NSString *user_id;


@property (nonatomic,copy) NSString *taste;
@property (nonatomic,copy) NSString *speed;
@property (nonatomic,copy) NSString *serve;
@property (nonatomic,copy) NSString *tss_status,*longitude,*latitude;
@property (nonatomic,copy) NSString *merchant_show;



@property (nonatomic,copy) NSString *order_state;

@property (nonatomic,copy) NSString *schedule_state;
@property (nonatomic,copy) NSString *check_state;
@property (nonatomic,copy) NSString *takeout_state;
@property (nonatomic,copy) NSString *coupon_state;
@property (nonatomic,copy) NSString *taste_status;
@property (nonatomic,copy) NSString *speed_status;
@property (nonatomic,copy) NSString *serve_status;
- (id)initWithDetailFood:(NSDictionary *)dic;

@end
