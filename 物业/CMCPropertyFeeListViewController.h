//
//  CMCPropertyFeeListViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableViewController.h"

@interface CMCPropertyFeeListViewController : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
@property (nonatomic, strong) NSString *owner_id; //物业地址id
@property (nonatomic, strong) NSString *type; //订单类型
@end
