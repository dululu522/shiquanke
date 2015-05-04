//
//  CMCPreferentialDetailsVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"

@interface CMCPreferentialDetailsVC : CMCPublicClassViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *coupon_id;

@end
