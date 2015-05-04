//
//  CMCPictureVC.h
//  ChinaMobileCommunity
//
//  Created by 武鹏 on 14-11-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCYouHuiModel.h"
@interface CMCPictureVC : UIViewController

@property (nonatomic,strong)CMCYouHuiModel *youhuiModel;
@property (nonatomic,strong)NSMutableArray *goodsArr;
@property (nonatomic, strong) NSString *frontTitle;//是优惠劵 还是代金券
@property (nonatomic, strong) NSString *coupon_id;



@end
