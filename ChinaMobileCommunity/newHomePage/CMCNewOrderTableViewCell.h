//
//  CMCNewOrderTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCDianCan.h"
#import "CMCFoodModel.h"

@protocol CMCNewOrderTableViewCellDelegate ;
@interface CMCNewOrderTableViewCell : UITableViewCell
{

    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UIImageView *_leftImageView;
    UILabel *_deslabel;

}
- (void)creatLeftImageCellleftX:(float)X rightY:(float)Y dianCan:(CMCFoodModel *)dianCan;
;


@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, assign) int count;
//@property (nonatomic, strong) CMCDianCan *dianCan;
@property (nonatomic, strong) CMCFoodModel *dianCan;
@property (nonatomic, assign) id<CMCNewOrderTableViewCellDelegate> delegate;



@end
@protocol CMCNewOrderTableViewCellDelegate <NSObject>


//- (void)selectedFood:(CMCNewOrderTableViewCell*)cell;
- (void) loadItems;


@end

