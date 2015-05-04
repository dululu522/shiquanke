//
//  CMCShoppingGoodsVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "CMCShoppingGoodsCell.h"
#import "EGORefreshTableViewController.h"
@interface CMCShoppingGoodsVC : EGORefreshTableViewController<UITableViewDataSource,UITableViewDelegate,CMCShoppingGoodsCellDelegate,EGORefreshTableDelegate>

@property (nonatomic, strong) NSString *merchant_id;
@property (nonatomic, strong) NSString *merchant_name;
//@property (nonatomic, strong) NSString *mid;

@property (nonatomic,strong)NSString *service_id;

@end
