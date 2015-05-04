//
//  CMCAddressItem.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCAddressItem : NSObject
//@property (nonatomic, strong) NSString *address_id,*address_name,*user_id,*address_address,*address_center_id,*address_mobile_phone;
@property (nonatomic,copy) NSString *address,*id,*phone,*name;
+ (instancetype)fromDict:(NSDictionary*)dict;
@end
