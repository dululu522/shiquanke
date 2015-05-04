//
//  CMCNoticeVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableViewController.h"


@interface CMCNoticeVC : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong) NSString *notice_id;//通知id
@property (nonatomic, strong) NSString *zid;//通知id

@end
