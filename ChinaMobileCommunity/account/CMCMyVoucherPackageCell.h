//
//  CMCMyVoucherPackageCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CMCDiscoutDetailModel.h"
//#import "CMCVouchersDetailModel.h"
#import "CMCAccountVouchers.h"
@interface CMCMyVoucherPackageCell : UITableViewCell
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) CMCAccountVouchers *couponDetail;
//@property (nonatomic, strong) CMCVouchersDetailModel *vouchersModel;
@end
