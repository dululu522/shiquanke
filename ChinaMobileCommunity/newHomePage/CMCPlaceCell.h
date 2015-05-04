//
//  CMCPlaceCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantDetailModel.h"
@interface CMCPlaceCell : UITableViewCell

@property (nonatomic,assign)int row;
@property (nonatomic,strong)MerchantDetailModel *myModel;
@property (nonatomic,strong)NSString *category;

@end
