//
//  CMCAccountViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCDiscoutDetailModel.h"
#import "CMCVouchersDetailModel.h"


@interface CMCAccountViewController : UIViewController<NetWorkRequesDelegate>
@property (nonatomic, strong) CMCDiscoutDetailModel *couponDetail;
@property (nonatomic, strong) CMCVouchersDetailModel *vouchersModel;
@end
