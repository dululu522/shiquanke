//
//  CMCInofCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCDiscoutDetailModel.h"
#import "CMCVouchersDetailModel.h"



typedef void(^phoneBlock)(NSString *phoneNumber);
@interface CMCInofCell : UITableViewCell


@property (nonatomic,strong)NSString *category;
@property (nonatomic, strong) CMCDiscoutDetailModel *couponDetail;
@property (nonatomic, strong) CMCVouchersDetailModel *vouchersModel;

- (void)setupPhoneBlock:(phoneBlock)myBlock;


@end
