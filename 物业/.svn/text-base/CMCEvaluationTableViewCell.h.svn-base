//
//  CMCEvaluationTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCEvaluationTableViewCellDelegate <NSObject>

- (void)didClickItems:(NSInteger)items;

@end

@interface CMCEvaluationTableViewCell : UITableViewCell
- (void)creatLabelText:(NSString *)str number:(NSInteger)number;
- (void)creatLabel;
@property (nonatomic, assign) id<CMCEvaluationTableViewCellDelegate> delegate;


@end
