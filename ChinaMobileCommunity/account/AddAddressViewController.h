//
//  AddAddressViewController.h
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCAddressItem.h"


@protocol AddAddressViewControllerDelegate;

@interface AddAddressViewController : CMCPublicClassViewController<NetWorkRequesDelegate,UITextFieldDelegate>

@property (nonatomic, assign) id<AddAddressViewControllerDelegate>delegate;
@property (nonatomic, assign) BOOL isModify;
@property (nonatomic, assign) CMCAddressItem* aitem;
@end


@protocol AddAddressViewControllerDelegate <NSObject>

- (void)didAddAddress:(CMCAddressItem*)item;
- (void)didModifyAddress:(CMCAddressItem*)item;
@end