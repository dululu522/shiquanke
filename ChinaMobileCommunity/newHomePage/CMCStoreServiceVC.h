//
//  CMCStoreServiceVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCStoreServiceVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *merchant_id;
@property (nonatomic, strong) NSString *merchant_name;
@end
