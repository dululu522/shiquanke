//
//  CMCStoreServiceTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCStoreServiceTableViewCell : UITableViewCell
{
    UIButton *_minusBtn;
    UIButton *_labelBtn;
    UIButton *_addBtn;
    UIImageView *_phoneView;
    UILabel *_priceLabel;
    UILabel *_nameLabel;
    UIImageView *_imageView;
}
- (void)creatLeftPhoneImageCell:(NSInteger)num;
@end
