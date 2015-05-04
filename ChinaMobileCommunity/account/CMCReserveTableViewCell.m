//
//  CMCReserveTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCReserveTableViewCell.h"

@implementation CMCReserveTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTableViewBooking:(CMCBooking *)book number:(int)number
{
    [self.shoperLabel removeFromSuperview];
    [shopNameLabel removeFromSuperview];
    [self.reservationTimerLabel removeFromSuperview];
    [self.downImageView removeFromSuperview];
    [self.bookPeopleLabel removeFromSuperview];
    [self.reservationNumberLabel removeFromSuperview];
    [self.bookRoomLabel removeFromSuperview];
    [timeLabel removeFromSuperview];
    [successLabel removeFromSuperview];

    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 14, 13)];
//    self.topImageView.backgroundColor = [UIColor orangeColor];
    self.topImageView.image = [UIImage imageNamed:@"shangjia"];
    [self.contentView addSubview:self.topImageView];
    //商家名
    self.shoperLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.topImageView.frame.size.width +self.topImageView.frame.origin.x + 9, 13, 30, 13)];
    self.shoperLabel.text = @"商家:";
    [self.contentView addSubview:self.shoperLabel];
    self.shoperLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.shoperLabel.font = [UIFont systemFontOfSize:13];
    //商家名字
   shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shoperLabel.frame.size.width+self.shoperLabel.frame.origin.x+2, 13, 100, 13)];
    [self.contentView addSubview:shopNameLabel];
//    shopNameLabel.text = book.username;
    shopNameLabel.textColor = [UIColor colorWithHexString:@"65b9fd"];
    shopNameLabel.font = [UIFont systemFontOfSize:13];
    
//日期
   self.reservationTimerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 82, 17, 77, 9)];
    self.reservationNumberLabel.text = book.addtime;
    self.reservationNumberLabel.textColor = [UIColor colorWithHexString:@"969696"];
    [self.contentView addSubview:self.reservationTimerLabel];
    self.reservationTimerLabel.font = [UIFont systemFontOfSize:9];

    //图片
    self.downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, self.topImageView.frame.size.height + self.topImageView.frame.origin.y + 12, 50, 50)];
    self.downImageView.image = [UIImage imageNamed:@"log"];
    [self.contentView addSubview:self.downImageView];
    //预订人
    self.bookPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.downImageView.frame.size.width + self.downImageView.frame.origin.x +8, self.downImageView.frame.origin.y, 72, 10)];
    self.bookPeopleLabel.text = [NSString stringWithFormat:@"预订人:%@",book.username];
    self.bookPeopleLabel.textColor = [UIColor colorWithHexString:@"393939"];
    self.bookPeopleLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.bookPeopleLabel];
    //预订人数
    self.reservationNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bookPeopleLabel.frame.size.width + self.bookPeopleLabel.frame.origin.x + 27, self.bookPeopleLabel.frame.origin.y, 75, 10)];
    self.reservationNumberLabel.text = [NSString stringWithFormat:@"预订人数:%@人",book.peoplenum];
    self.reservationNumberLabel.textColor = [UIColor colorWithHexString:@"393939"];

    self.reservationNumberLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.reservationNumberLabel];
    //预订房间
    self.bookRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bookPeopleLabel.frame.origin.x, self.bookPeopleLabel.frame.size.height + self.bookPeopleLabel.frame.origin.y + 8, 75, 10)];
    self.bookRoomLabel.font = [UIFont systemFontOfSize:10];
    self.bookRoomLabel.textColor = [UIColor colorWithHexString:@"393939"];

    if (book.peoplenum) {
        if ([book.type isEqualToString:@"1"]) {
            self.bookRoomLabel.text = [NSString stringWithFormat:@"预订散桌:%@桌",book.desknum];

        }
        if ([book.type isEqualToString:@"0"]) {
            self.bookRoomLabel.text = [NSString stringWithFormat:@"预订包间:%@桌",book.desknum];

        }

    }
    [self.contentView addSubview:self.bookRoomLabel];
    //预订时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bookPeopleLabel.frame.origin.x, self.bookRoomLabel.frame.size.height + self.bookRoomLabel.frame.origin.y+8, 141, 10)];
    [self.contentView addSubview:timeLabel];
    
    timeLabel.text = [NSString stringWithFormat:@"预订时间:%@",[BaseUtil becomeNormalWithString:book.reservetime]];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor colorWithHexString:@"393939"];

    //预订中
    successLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bookPeopleLabel.frame.origin.x, timeLabel.frame.size.height + timeLabel.frame.origin.y+8, 72, 10)];
    [self.contentView addSubview:successLabel];
    successLabel.textColor = [UIColor colorWithHexString:@"393939"];

    if ([book.store_status isEqualToString:@"0"]) {
        successLabel.text = @"已预订";
    }
    if ([book.store_status isEqualToString:@"1"]) {
        successLabel.text = @"预订中...";
    }
    successLabel.font = [UIFont systemFontOfSize:10];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(self.contentView.frame.size.width - 70, 70, 60, 20);
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [cancelButton setTitle:@"取消预订" forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel_btn"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(didClickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 2000+number;
    cancelButton.userInteractionEnabled = YES;
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"65b9fd"] forState:UIControlStateNormal];
    [self.contentView addSubview:cancelButton];
 }
- (void)didClickCancelBtn:(UIButton *)btn
{
    
//    [self.delegate didClickItems];
    NSLog(@"取消预订 %d",btn.tag);
    [self.delegate didClickItems:btn.tag - 2000];

}
@end
