//
//  MerchantDetailModel.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "MerchantDetailModel.h"

@implementation MerchantDetailModel


- (id)initWithDic:(NSDictionary *)dataDic{
    self = [super init];
    if (self) {
        self.mid = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"mid"]];
        self.name = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]];
        self.star = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"star"]];
        self.image = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]];
        self.time = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"time"]];
        self.address = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"address"]];
        self.tel = [NSArray arrayWithArray:[dataDic objectForKey:@"tel"]];
        self.intro = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"intro"]];
        self.service = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"service"]];
        
    }
    return self;
}

+ (id)merchantDetailWithDic:(NSDictionary *)dic{
    MerchantDetailModel *model = [[MerchantDetailModel alloc]initWithDic:dic];
    return model;
}

@end
