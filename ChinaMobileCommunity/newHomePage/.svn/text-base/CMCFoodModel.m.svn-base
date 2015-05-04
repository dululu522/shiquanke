//
//  CMCFoodModel.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-12.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCFoodModel.h"

@implementation CMCFoodModel


- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.id = [dic objectForKey:@"id"];
        self.image = [dic objectForKey:@"image"];
        self.name = [dic objectForKey:@"name"];
        self.price = [dic objectForKey:@"price"];
        self.intro = [dic objectForKey:@"intro"];
    }
    
    return self;
}

+ (id)foodWithDic:(NSDictionary *)dic{
    CMCFoodModel *model = [[CMCFoodModel alloc]initWithDic:dic];
    return model;
}

@end
