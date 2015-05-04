//
//  WashColthesCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WashColthesCellDelegate<NSObject>

- (void)didClickItemsWithNumber:(NSString *)number andFoodModel:(NSArray *)diancan;

@end


@interface WashColthesCell : UITableViewCell
{
    UIButton *_leftButton;
    UILabel *_middleLabel;
    UIButton *_rightButton;
}

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) id<WashColthesCellDelegate> delegate;
@property (nonatomic,strong)NSArray *diancan;

@property (nonatomic,strong)NSString *category;



@end

