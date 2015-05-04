//
//  CMCConvenientLifeListVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "EGORefreshTableViewController.h"

@interface CMCConvenientLifeListVC : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *merchant_type;
@property (nonatomic, strong) NSString *merchant_name;

@end
