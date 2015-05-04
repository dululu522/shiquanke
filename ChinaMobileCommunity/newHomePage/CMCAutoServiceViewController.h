//
//  CMCAutoServiceViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "EGORefreshTableViewController.h"
@interface CMCAutoServiceViewController : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>

@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *merchant_type;
@end
