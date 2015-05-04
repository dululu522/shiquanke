//
//  CMCInfoCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCMyOrder.h"
#import "OrderDetailModel.h"

@interface CMCInfoCell : UITableViewCell

@property (nonatomic,strong)CMCMyOrder *dataModel;
@property (nonatomic,strong)OrderDetailModel *myModel;

@end
