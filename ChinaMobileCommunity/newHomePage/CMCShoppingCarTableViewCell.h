//
//  CMCShoppingCarTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCShoppingCarTableViewCellDelegate <NSObject>

- (void)didClickItems:(int) items;

@end

@interface CMCShoppingCarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLable;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (assign, nonatomic) int selectCount;
@property (assign, nonatomic) id<CMCShoppingCarTableViewCellDelegate> delegate;


@end
