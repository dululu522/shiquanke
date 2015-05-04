//
//  CMCOrderTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UIImageView *downImageView;//商家的图片
@property (strong, nonatomic) IBOutlet UILabel *shoperLabel;//商家
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;//订单号
@property (strong, nonatomic) IBOutlet UILabel *payOrder;//已订购
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;//详细信息
@property (strong, nonatomic) IBOutlet UIButton *cancelButton; //取消预订按钮
@property (strong, nonatomic) IBOutlet UIButton *orderButton;//已预订按钮
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (strong, nonatomic) IBOutlet UILabel *numberLabel; //数量
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
