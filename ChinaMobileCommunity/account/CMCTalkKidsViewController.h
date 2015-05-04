//
//  CMCTalkKidsViewController.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"

@interface CMCTalkKidsViewController : CMCPublicClassViewController<UITextViewDelegate,NetWorkRequesDelegate>
@property (nonatomic, strong) NSString *idStr;//活动id
@end
