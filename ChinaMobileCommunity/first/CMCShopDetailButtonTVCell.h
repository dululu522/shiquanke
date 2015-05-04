//
//  CMCShopDetailButtonTVCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCShopDetailButtonTVCellDelegate <NSObject>

- (void)clickItems:(NSInteger)items;

@end

@interface CMCShopDetailButtonTVCell : UITableViewCell
@property (nonatomic, strong) id <CMCShopDetailButtonTVCellDelegate> delegate;
@property (nonatomic, strong) NSArray *clickImageArr;


//- (void)creatButton;
- (void)creatButtonImageStr:(NSArray *)imageArr labelStr:(NSArray *)labelArr

;
- (void)creatButtonImageStr:(NSArray *)imageArr labelStr:(NSArray *)labelArr unAbleNumberArr:(NSArray *)unAbleNumberArr;
- (void)creatButtonImageStr:(NSArray *)imageArr labelStr:(NSArray *)labelArr unAbleNumberArr:(NSArray *)unAbleNumberArr unAbleImageArr:(NSArray *)unArray;


@end

