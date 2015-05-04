//
//  CMCOrderConfirmationVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-31.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

//订单确认
#import <UIKit/UIKit.h>

@interface CMCOrderConfirmationVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NetWorkRequesDelegate>
@property (nonatomic, strong) NSDictionary *tempDic;
@property (nonatomic, assign) int numberCount;
@property (nonatomic, strong) NSString *store_id;//商家id
@property (nonatomic, strong) NSArray *goodslistArr;
@property (nonatomic, strong) NSString *shopName;

@end
