//
//  CMCTakeOutTVCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCDianCan.h"

@protocol CMCTakeOutTVCellDelegate <NSObject>

- (void)clickWaiCellItems;

@end

@interface CMCTakeOutTVCell : UITableViewCell
{

    UIImageView *_takeOutImageView;
    UILabel *_nameLabel;
    UILabel *_materialLabel;
    
}


@property (nonatomic, assign) int selectNumber;
@property (nonatomic, strong)  UILabel *midLabel;
@property (nonatomic, strong)  UILabel *priceLabel;


@property (nonatomic, assign) id<CMCTakeOutTVCellDelegate> delegate;
- (void)creatCellDianCan:(CMCDianCan *)dianCan;



@end
