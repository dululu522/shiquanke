//
//  MAddressViewController.h
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCAddressItem.h"
#import "CMCPublicClassViewController.h"


@protocol MAddressViewControllerDelegate;

//@interface AddressItem : NSObject
//
//@property (nonatomic, strong) NSString *address_id,*address_name,*user_id,*address_address,*address_center_id,*address_mobile_phone, *birthday,*gender,*id,*nickname,*personaltext,*real_name;
//+ (instancetype)fromDict:(NSDictionary*)dict;
//@end

@interface MAddressViewController : CMCPublicClassViewController<NetWorkRequesDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) id<MAddressViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *titleStr;


@end




@protocol MAddressViewControllerDelegate <NSObject>

- (void)didSelectedAddress:(CMCAddressItem*)item;

@end