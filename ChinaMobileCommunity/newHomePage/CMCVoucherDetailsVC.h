//
//  CMCVoucherDetailsVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCPublicClassViewController.h"

@interface CMCVoucherDetailsVC : CMCPublicClassViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *coupon_id;

@end
