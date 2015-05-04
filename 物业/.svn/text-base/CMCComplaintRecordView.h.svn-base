//
//  CMCComplaintRecordView.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCComplaint.h"


@interface CMCComplaintRecordView : UIView
{
    UITextField *_mapLabelTextField;
    UILabel *_communityLabel;
    UITextView *_contentView;
    UILabel *_contentLabel;
    UILabel *_typeLabel;
    
    
}

@property (nonatomic, strong) NSString *type; //投诉:0  报修:1
@property (nonatomic, strong) NSString *zid;

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) CMCComplaint *complaint;

//当前定位的地址 小区名称  类型
- (void)creatViewMap:(NSString *)mapAddress communityText:(NSString *)communityText typeText:(NSString *)typeText;
@end
