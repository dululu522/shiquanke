//
//  CMCWuYeView.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCWuYeViewDelegate <NSObject>

- (void)didClickItems;

@end

@interface CMCWuYeView : UIView<NetWorkRequesDelegate>
{
    int count;
    UIImageView *_payImageView;
    NetWorkRequest *_request;
    UILabel *_unitAmountlabel;
}

@property (nonatomic, strong) UITextField *paymentNamelabelField;
@property (nonatomic, strong) UILabel *paymentAddresslabel;
@property (nonatomic, strong) UILabel *paymentTimelabel;
@property (nonatomic, strong) UILabel *paymentTonlabel;
@property (nonatomic, strong) UILabel *paymentAmountlabel;
@property (nonatomic, strong) UIImageView *selectButton;
//@property (nonatomic, copy)    NSString *priceText;
//@property (nonatomic, strong) NSString *center_id;//物业id
//@property (nonatomic, strong) NSString *id;//数据id
//@property (nonatomic, strong) NSString *type;//类型
//@property (nonatomic, strong) NSString *number; //单位
////@property (nonatomic, strong) NSString *unitTitle;//单位称谓(吨数)
//@property (nonatomic, strong) NSString *address_id;//地址id
@property (nonatomic, assign) id<CMCWuYeViewDelegate> delegate;


- (void)creatViewPriceText:(NSString *)price address:(NSString *)address real_name:(NSString *)realName time:(NSString *)time unitTitle:(NSString *)unitTitle unitNumber:(NSString *)unumber uint:(NSString *)uint;


@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *category; //物业费,水费,电费........
- (void)creatWuyeView:(NSDictionary *)dic;
@end
