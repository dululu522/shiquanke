//
//  CMCOrderWithoutPaymentDetailVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"

@interface CMCOrderWithoutPaymentDetailVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate,NetWorkRequesDelegate>
@property (nonatomic, strong) NSString *order_id;//订单号

@end
