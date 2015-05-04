//
//  AddressTableViewCell.h
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCAddressItem.h"

@class AddressTableViewCell;

@protocol AddressTableViewCellDelegate <NSObject>

- (void)didDeleteAddress:(AddressTableViewCell*)cell;
- (void)didEditAddress:(AddressTableViewCell*)cell;
- (void)didModifyAddress:(AddressTableViewCell *)cell;

@end


@interface AddressTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UILabel* addressLabel;
@property (nonatomic, strong) IBOutlet UIButton* editButton;

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *modifyButton;

@property (strong, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic, assign) CMCAddressItem* item;
@property (nonatomic, assign) id<AddressTableViewCellDelegate>delegate;
- (void)fullDataFromItem:(CMCAddressItem*)item;
- (void)hideRightButton;
@end
