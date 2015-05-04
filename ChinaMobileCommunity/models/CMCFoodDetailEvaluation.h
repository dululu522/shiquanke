//
//  CMCFoodDetailEvaluation.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-20.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCFoodDetailEvaluation : NSObject
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *evaluate_time;
@property (nonatomic,copy) NSString *evaluate_content;
@property (nonatomic,copy) NSString *evaluate_star;
@property (nonatomic,copy) NSString *reply_content;
- (id) initWithEvaluation:(NSDictionary *)dic;

@end
