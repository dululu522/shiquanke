//
//  CMCCityListViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableViewController.h"

@interface CMCCityListViewController : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,EGORefreshTableDelegate>
{
    UITabBarController *tabbarController;
    
}
@end
