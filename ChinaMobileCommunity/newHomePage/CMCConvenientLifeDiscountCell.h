//
//  CMCConvenientLifeDiscountCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCCouponsModel.h"


typedef void(^downLoadBlock)();
@interface CMCConvenientLifeDiscountCell : UITableViewCell

@property (nonatomic,assign)NSInteger section;
@property (nonatomic, strong) CMCCouponsModel *couponsModel;
@property (nonatomic, strong) CMCCouponsModel *vouchersCouponsModel;
@property (nonatomic, strong) NSString *coupon_id;//打折券id


- (void)setupDownLoadBlock:(downLoadBlock)myBlokc;

@end
