//
//  CMCNickNameVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-30.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMCNickNameVC : CMCPublicClassViewController<UITextFieldDelegate,NetWorkRequesDelegate>
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *activity_id;

@end
