//
//  CMCRepairComplaintsView.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-22.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCRepairComplaintsViewDelegate <NSObject>

- (void)didClickCommunity;
- (void)didClickType;
- (void)didClickSubmitButton;
- (void)didClickButton:(NSInteger)button;
- (void)returnSucessful;

@end

@interface CMCRepairComplaintsView : UIView<UITextViewDelegate>
{
    UITextField *_mapLabelTextField;
    UILabel *_communityLabel;
    UITextView *_contentView;
    UILabel *_contentLabel;
    UILabel *_typeLabel;


}
@property (nonatomic, assign) id<CMCRepairComplaintsViewDelegate> delegate;
@property (nonatomic, strong) NSString *type; //投诉:0  报修:1
@property (nonatomic, strong) NSString *zid;
@property (nonatomic, strong)     UILabel *typeLabel;


//当前定位的地址 小区名称  类型
- (void)creatViewMap:(NSString *)mapAddress communityText:(NSString *)communityText typeText:(NSString *)typeText;
@end
