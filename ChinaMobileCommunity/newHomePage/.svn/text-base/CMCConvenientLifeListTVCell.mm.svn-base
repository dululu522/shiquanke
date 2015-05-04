//
//  CMCConvenientLifeListTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//
#define MARGIN_Inter 11
#import "CMCConvenientLifeListTVCell.h"
#import "BMapKit.h"

@implementation CMCConvenientLifeListTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)creatActivityLowest:(CMCActivityLowest *)food
{
    [_photoListImageView removeFromSuperview];
    [_shopNameListLabel removeFromSuperview];
    [_evaluationLabel removeFromSuperview];
    [_star removeFromSuperview];
    [_detailListLabel removeFromSuperview];
    _photoListImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 100, 75)];
    NSURL *url = [BaseUtil systemRandomlyGenerated:food.image type:@"10" number:@"4"];
    [_photoListImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:_photoListImageView];
    
    //超市名称
    _shopNameListLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoListImageView.frame.size.width + _photoListImageView.frame.origin.x + 9, 14, self.frame.size.width - 119, 13)];
    _shopNameListLabel.text =food.name;
    _shopNameListLabel.font = [UIFont systemFontOfSize:13];
    _shopNameListLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:_shopNameListLabel];
    //综合评价
    _star = [[StarView alloc] initWithFrame:CGRectMake(_shopNameListLabel.frame.origin.x+50-15, _shopNameListLabel.bottom+MARGIN_Inter, 80, 11)];
    _star.userInteractionEnabled = NO;
    _star.starNumber = [food.star intValue];
    [self.contentView addSubview:_star];
    
    _evaluationLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopNameListLabel.frame.origin.x, _shopNameListLabel.bottom+MARGIN_Inter,  50, 11)];
    _evaluationLabel.text = @"综合评价";
    _evaluationLabel.textColor = [UIColor colorWithHexString:@"414141"];
    _evaluationLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_evaluationLabel];
    
    //详细信息
    _detailListLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopNameListLabel.left, _evaluationLabel.bottom+MARGIN_Inter, self.frame.size.width - 119, 30)];
    _detailListLabel.font = [UIFont systemFontOfSize:10];
//    _detailListLabel.numberOfLines = 0;
    _detailListLabel.textColor = [UIColor colorWithHexString:@"5f5f5f"];
    _detailListLabel.text = [NSString stringWithFormat:@"地址:%@",food.address];
    [self.contentView addSubview:_detailListLabel];




}

- (void)creatCell:(CMCFood *)food
{

    
    [_photoListImageView removeFromSuperview];
    [_shopNameListLabel removeFromSuperview];
    [_evaluationLabel removeFromSuperview];
    [_star removeFromSuperview];
    [_detailListLabel removeFromSuperview];
    _photoListImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 100, 75)];
    NSURL *url = [BaseUtil systemRandomlyGenerated:food.image type:@"10" number:@"2"];
    [_photoListImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:_photoListImageView];
    
    //超市名称
    _shopNameListLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoListImageView.frame.size.width + _photoListImageView.frame.origin.x + 9, 14, self.frame.size.width - 119, 13)];
    _shopNameListLabel.text =food.name;
    _shopNameListLabel.font = [UIFont systemFontOfSize:13];
    _shopNameListLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:_shopNameListLabel];
    //综合评价
    _star = [[StarView alloc] initWithFrame:CGRectMake(_shopNameListLabel.frame.origin.x+50-15, _shopNameListLabel.bottom+MARGIN_Inter, 80, 11)];
    _star.userInteractionEnabled = NO;
    _star.starNumber = [food.star intValue];
    [self.contentView addSubview:_star];
    
    _evaluationLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopNameListLabel.frame.origin.x, _shopNameListLabel.bottom+MARGIN_Inter,  50, 11)];
    _evaluationLabel.text = @"综合评价";
    _evaluationLabel.textColor = [UIColor colorWithHexString:@"414141"];
    _evaluationLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_evaluationLabel];

    //详细信息
    _detailListLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopNameListLabel.left, _evaluationLabel.bottom+MARGIN_Inter, self.frame.size.width - 119, 30)];
    _detailListLabel.font = [UIFont systemFontOfSize:10];
//    _detailListLabel.numberOfLines = 0;
    _detailListLabel.textColor = [UIColor colorWithHexString:@"5f5f5f"];
    _detailListLabel.text = food.intro;
    [self.contentView addSubview:_detailListLabel];
    

}
- (void)creatDetailCell:(CMCFoodDetail *)foodDetail
{
    NSURL *url = [BaseUtil systemRandomlyGenerated:foodDetail.merchant_image type:@"10" number:@"1"];
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 84, 84)];
    [photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    photoImageView.layer.cornerRadius = 42;
    photoImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:photoImageView];
    
    //超市名称
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, 14, self.frame.size.width - 94, 25)];
    //    shopNameLabel.backgroundColor = [UIColor grayColor];
    _shopNameLabel.text = foodDetail.merchant_name;
    _shopNameLabel.font = [UIFont systemFontOfSize:14];
    _shopNameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:_shopNameLabel];
    
    
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, _shopNameLabel.frame.size.height + _shopNameLabel.frame.origin.y, self.frame.size.width - 94, 24)];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.text = [NSString stringWithFormat:@"营业时间:%@",foodDetail.merchant_opentime];
    timeLabel.textColor = [UIColor colorWithHexString:@"606060"];
    //    timeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:timeLabel];
    //电话
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, timeLabel.frame.size.height + timeLabel.frame.origin.y, self.frame.size.width - 94, 24)];
    _phoneLabel.text = foodDetail.mobile_phone;
    _phoneLabel.font = [UIFont systemFontOfSize:12];
    _phoneLabel.textColor = [UIColor colorWithHexString:@"606060"];
    
    [self.contentView addSubview:_phoneLabel];
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, timeLabel.frame.size.height + timeLabel.frame.origin.y, 15, 24)];
    phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    phoneImageView.image = [UIImage imageNamed:@"电话"];
    [self.contentView addSubview:phoneImageView];
    phoneImageView.userInteractionEnabled = YES;
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(_phoneLabel.frame.origin.x, _phoneLabel.frame.origin.y, self.frame.size.width - _phoneLabel.frame.origin.x, _phoneLabel.frame.size.height);
    [phoneButton addTarget:self action:@selector(didClickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneButton];
    
    //地图
    UILabel *mapLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5 , _phoneLabel.frame.size.height + _phoneLabel.frame.origin.y, self.frame.size.width - 117, 24)];
    mapLabel.textColor = [UIColor colorWithHexString:@"606060"];
    mapLabel.font = [UIFont systemFontOfSize:12];
    mapLabel.text = foodDetail.merchant_addr;
    //    mapLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:mapLabel];
    
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, _phoneLabel.frame.size.height + _phoneLabel.frame.origin.y, 15, 24)];
    mapImageView.image = [UIImage imageNamed:@"map"];
    mapImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:mapImageView];
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame = CGRectMake(mapLabel.frame.origin.x, mapLabel.frame.origin.y, self.frame.size.width -mapLabel.frame.origin.x , mapLabel.frame.size.height);
    [mapButton addTarget:self action:@selector(didClickmapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:mapButton];
    self.latitude = [foodDetail.latitude floatValue];
    self.longitude = [foodDetail.longitude floatValue];
    
    
}
- (void)didClickPhoneButton:(UIButton *)button
{
    
//    [BaseUtil callPhoneStr:_phoneLabel.text];
//    [BaseUtil callAndBack:_phoneLabel.text];
    [BaseUtil callAndBackWeb:_phoneLabel.text];
    
    
}
- (void)didClickmapButton:(UIButton *)button
{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_WEB;
    
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = [CMCUserManager shareManager].latitude;
    coor1.longitude = [CMCUserManager shareManager].longitude;
    start.pt = coor1;
    //指定起点名称
    start.name = [CMCUserManager shareManager].location;
    //指定起点
    para.startPoint = start;
    
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = self.latitude;
    coor2.longitude = self.longitude;
    end.pt = coor2;
    para.endPoint = end;
    //指定终点名称
    end.name = _shopNameLabel.text;
    //指定调启导航的app名称
    para.appName = [NSString stringWithFormat:@"%@", @"testAppName"];
    //    para.appName = [NSString stringWithFormat:@"%@", @"十全客"];
    
    //调启web导航
    [BMKNavigation openBaiduMapNavigation:para];
    
    
}

@end
