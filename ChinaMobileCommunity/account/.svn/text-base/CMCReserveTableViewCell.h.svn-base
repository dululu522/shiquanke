//
//  CMCReserveTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCBooking.h"


@protocol CMCReserveTableViewCellDelegate <NSObject>
//点击的是哪一个cell
- (void)didClickItems:(int)number;

@end

@interface CMCReserveTableViewCell : UITableViewCell
{
    UILabel *shopNameLabel;
    UILabel *timeLabel;
    UILabel *successLabel;
}
- (void)creatTableViewBooking:(CMCBooking *)book number:(int)number;

//@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
//@property (strong, nonatomic) IBOutlet UIImageView *downImageView;//商家的图片
//@property (strong, nonatomic) IBOutlet UILabel *shoperLabel;//商家
//@property (strong, nonatomic) IBOutlet UILabel *bookPeopleLabel;//预订人
//@property (strong, nonatomic) IBOutlet UILabel *reservationNumberLabel;//预订人数
//@property (strong, nonatomic) IBOutlet UILabel *bookRoomLabel;//预订房间
//@property (strong, nonatomic) IBOutlet UILabel *reservationTimerLabel;//预订时间
//
//
//
//@property (strong, nonatomic) IBOutlet UIButton *cancelButton; //取消预订按钮
//@property (strong, nonatomic) IBOutlet UIButton *orderButton;//已预订按钮
//
//
//@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic)  UIImageView *topImageView;
@property (strong, nonatomic)  UIImageView *downImageView;//商家的图片
@property (strong, nonatomic)  UILabel *shoperLabel;//商家
@property (strong, nonatomic)  UILabel *bookPeopleLabel;//预订人
@property (strong, nonatomic)  UILabel *reservationNumberLabel;//预订人数
@property (strong, nonatomic)  UILabel *bookRoomLabel;//预订房间
@property (strong, nonatomic)  UILabel *reservationTimerLabel;//预订时间
@property (strong, nonatomic)  UIButton *cancelButton; //取消预订按钮
@property (strong, nonatomic)  UIButton *orderButton;//已预订按钮
@property (nonatomic, assign) id<CMCReserveTableViewCellDelegate> delegate;


@property (strong, nonatomic)  UILabel *timeLabel;

@end
