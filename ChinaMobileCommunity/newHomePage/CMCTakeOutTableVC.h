//
//  CMCTakeOutTableVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCNewOrderTableViewCell.h"
@interface CMCTakeOutTableVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate,CMCNewOrderTableViewCellDelegate>
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *service_id;
@end
