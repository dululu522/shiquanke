//
//  CMCHomePageMerchant.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-9.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCHomePageMerchant : NSObject
@property (nonatomic, strong) NSString *address,*capita,*carport,*cid,*close_time,*coord_x,*coord_y,*create_time,*elect,*image,*intro,*mid,*name,*open_time,*service,*star,*state,*tel,*trade_id,*update_time,*zid;
- (id) initWithCMCHomePageMerchantDic:(NSDictionary *)merchantDic;
@end
