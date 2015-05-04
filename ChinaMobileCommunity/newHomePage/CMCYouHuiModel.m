//
//  CMCYouHuiModel.m
//  ChinaMobileCommunity
//
//  Created by 武鹏 on 14-11-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCYouHuiModel.h"

@implementation CMCYouHuiModel
@synthesize description;

- (id)initWithYouHuiData:(NSDictionary *)data{
//    if (self = [super init]) {
//        self.titleStr = [data objectForKey:@"title"];
//        self.ID = [data objectForKey:@"id"];
//        self.discount = [data objectForKey:@"discount"];
//        self.is_promise = [data objectForKey:@"is_promise"];
//        self.life = [data objectForKey:@"life"];
//        self.end_time = [data objectForKey:@"end_time"];
//        self.information = [data objectForKey:@"information"];
//        self.notice = [data objectForKey:@"notice"];
//        self.desPtion = [data objectForKey:@"description"];
//    }
//    return self;
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
    
    
}

//+ (id)initYouHuiData:(NSDictionary *)data{
//    return [[CMCYouHuiModel alloc]initWithYouHuiData:data];
//}
- (id)valueForUndefinedKey:(NSString *)key
{

    return nil;

}

@end
