//
//  CMCDisAndVouCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCCouponsModel.h"

typedef void(^downLoadBlock)();
@interface CMCDisAndVouCell : UITableViewCell

@property (nonatomic,assign)NSInteger section;
@property (nonatomic, strong) CMCCouponsModel *couponsModel;//折扣券
@property (nonatomic, strong) CMCCouponsModel *vouchersModel;//代金券

- (void)setupDownLoadBlock:(downLoadBlock)myBlokc;


@end
