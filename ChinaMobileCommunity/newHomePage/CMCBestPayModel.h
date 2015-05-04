//
//  CMCBestPayModel.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-23.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCBestPayModel : NSObject
{
    NSURLConnection *connection;
    
}

- (void)bestWithOrder_id:(NSString *)order_id money:(NSString *)money;
@end
