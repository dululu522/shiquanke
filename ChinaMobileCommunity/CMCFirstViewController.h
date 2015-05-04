//
//  CMCFirstViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <CoreLocation/CoreLocation.h>
#import "CMCFirstTableViewCell.h"
@interface CMCFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,CMCFirstTableViewCellDelegate>

@end
