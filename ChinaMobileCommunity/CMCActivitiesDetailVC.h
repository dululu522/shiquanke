//
//  CMCActivitiesDetailVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"
@interface CMCActivitiesDetailVC : CMCPublicClassViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate,NetWorkRequesDelegate>
@property (nonatomic, strong) NSString *id;

@end
