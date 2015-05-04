//
//  CMCMyBookingDetailsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyBookingDetailsVC.h"
#import "CMCMyView.h"

@interface CMCMyBookingDetailsVC ()

@end

@implementation CMCMyBookingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"预订详情";
    UIImage *image = [UIImage imageNamed:@"shangjia"];
    UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, image.size.width, image.size.height)];
    shopImageView.image = image;
    [self.view addSubview:shopImageView];
    //商家
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(shopImageView.frame.size.width + shopImageView.frame.origin.x, 16, 40, 13)];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"商家:";
    label.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:label];
    //商家名字
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.size.width+label.frame.origin.x, 16, 112, 13)];
    shopNameLabel.text = @"格林帝豪";
    shopNameLabel.textColor = kAPI_AllMainColor;
    shopNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:shopNameLabel];
    //日期
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 20, 83, 10)];
    dateLabel.text = @"日期:2014-09-30";
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dateLabel];
    

    CMCMyView *bookingpeopleView = [[CMCMyView alloc] initWithFrame:CGRectMake(0, shopNameLabel.frame.size.height + shopNameLabel.frame.origin.y+ 10 , self.view.frame.size.width, 24)];
//    bookingpeopleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bookingpeopleView];
    
    [bookingpeopleView creatLeftLabel:@"预订人:赵先生"  rightLabel:@"电话:13263446196" frame:bookingpeopleView.bounds];
    //预订人下面的线
    UIImageView *bookingpeopImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, bookingpeopleView.frame.size.height+bookingpeopleView.frame.origin.y+ 10 ,self.view.frame.size.width - 40, 1)];
    bookingpeopImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:bookingpeopImageView];
    
    CMCMyView *bookRoomView = [[CMCMyView alloc] initWithFrame:CGRectMake(0, bookingpeopImageView.frame.size.height +bookingpeopImageView.frame.origin.y+10, self.view.frame.size.width, 24)];
    [bookRoomView creatLeftLabel:@"预订房间:赵先生" rightLabel:@"预订人数:1人" frame:bookRoomView.bounds];
    [self.view addSubview:bookRoomView];
    
    //预订房间下面的线
    UIImageView *bookRoomImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, bookRoomView.frame.size.height+bookRoomView.frame.origin.y+ 10 ,self.view.frame.size.width - 40, 1)];
    bookRoomImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:bookRoomImageView];
    
    //预订时间
    UILabel *bookingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, bookRoomImageView.frame.size.height + bookRoomImageView.frame.origin.y +10, self.view.frame.size.width - 40, 35)];
    bookingTimeLabel.text = @"预订时间";
    bookingTimeLabel.font = [UIFont systemFontOfSize:12.0];
    bookingTimeLabel.textColor = [UIColor colorWithHexString:@"393939"];
    [self.view addSubview:bookingTimeLabel];
    //已消费  预订中
    UILabel *bookingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bookingTimeLabel.frame.size.height +bookingTimeLabel.frame.origin.y, self.view.frame.size.width, 46)];
    bookingLabel.text = @"已消费";
    bookingLabel.backgroundColor = kAPI_AllMainColor;
    bookingLabel.textColor = [UIColor whiteColor];
    bookingLabel.font = [UIFont systemFontOfSize:16.0];
    bookingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bookingLabel];
    
    //删除订单 取消预订
    //若是已消费 button上显示删除订单
    //若是预定中 button上显示取消预订
//    UIImage *orderImage = [UIImage imageNamed:@"myBookingDetail"];
    UIButton *orderDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderDetailButton.frame = CGRectMake(self.view.frame.size.width/2 - 80, bookingLabel.frame.size.height +bookingLabel.frame.origin.y + 100, 160, 40);
//    [orderDetailButton setImage:orderImage forState:UIControlStateNormal];
    [orderDetailButton setTitle:@"删除订单" forState:UIControlStateNormal];
    [orderDetailButton setTitleColor:kAPI_AllMainColor forState:UIControlStateNormal];
    orderDetailButton.layer.borderColor = [kAPI_AllMainColor CGColor];
    orderDetailButton.layer.borderWidth = 1.0;
    orderDetailButton.layer.cornerRadius = 5;
    [orderDetailButton addTarget:self action:@selector(didClickOrderDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderDetailButton];
    
    
}
- (void)didClickOrderDetailButton:(UIButton *)button
{



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
