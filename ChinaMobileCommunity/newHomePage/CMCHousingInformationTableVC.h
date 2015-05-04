//
//  CMCHousingInformationTableVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCHousingInformationTableVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *service_id;//0310

@end
