//
//  CMCOrderMakeSureVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "CMCAddressItem.h"

@interface CMCOrderMakeSureVC : CMCPublicClassViewController

@property (nonatomic,strong)NSDictionary *orderDic;//点菜菜品
@property (nonatomic,strong)NSString *merchant_name;//店铺名字
@property (nonatomic,strong)NSString *price;//总计价格
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *merchant_id;
@property (nonatomic, strong) CMCAddressItem *fromAddressItem;
@property (nonatomic,strong)NSString *service_id;

@end
