//
//  CMCShoppingGoodsCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFoodModel.h"

@protocol CMCShoppingGoodsCellDelegate <NSObject>

- (void)didClickItemsWithNumber:(NSString *)number andFoodModel:(NSArray *)diancan;

@end

@interface CMCShoppingGoodsCell : UITableViewCell
{
    UIButton *_leftButton;
    UILabel *_middleLabel;
    UIButton *_rightButton;
}


@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) id<CMCShoppingGoodsCellDelegate> delegate;
@property (nonatomic,strong)NSArray *diancan;
@property (nonatomic,strong)NSString *category;
@property (nonatomic, assign) NSInteger row;

- (void)creatCellWithDianCan:(NSArray *)dianCan;

@end
