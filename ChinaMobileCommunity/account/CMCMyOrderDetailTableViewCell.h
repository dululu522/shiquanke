//
//  CMCMyOrderDetailTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCFoodMyOrder.h"

@protocol CMCMyOrderDetailTableViewCellDelegate <NSObject>

- (void)loadItems;

@end

@interface CMCMyOrderDetailTableViewCell : UITableViewCell
{

    UILabel *_shopNameLabel;
    UILabel *_statusLabel;
    UILabel *_typelabel;
    UILabel *_orderNumberLabel;
    UILabel *_shopPhoneLabel;
    UILabel *_addressLabel;
    
    UILabel *_totalLabel;
    UILabel *_copyLabel;
    UILabel *_priceLabel;
    UILabel *_onlinePayLabel;
    UILabel *_noteLabel;
}
//@property (nonatomic, assign) id<CMCMyOrderDetailTableViewCellDelegate> delegate;
//
@property (nonatomic,  strong) NSDictionary *myOrderDetailDic;
@property (nonatomic, assign) NSInteger allNumber;
@property (nonatomic, assign) NSInteger allPrice;




- (void)creatMyOrderDetailCellStatus:(NSString *)status type:(NSString *)type name:(NSString *)name time:(NSString *)time orderNumber:(NSString *)orderNumber;
- (void)creatMyOrderDetailCellStatus:(NSString *)status type:(NSString *)type name:(NSString *)name time:(NSString *)time;
// 创建订单详情 总价 线上支付 备注
- (void)creatMyOrderDetailCopyLabelText:(NSString *)copyText priceText:(NSString *)price onlinePay:(NSString *)onlinePay note:(NSString *)note;
//姓名 手机号
- (void)creatName:(NSString *)name phone:(NSString *)phone
;
- (void)creatName:(NSString *)name phone:(NSString *)phone address:(NSString *)address;
//总价
// 创建订单详情 总价 线上支付 备注
- (void)creatMyOrderDetailCopyLabelText;
- (void)creatMyOrderDetailCell;
@end
