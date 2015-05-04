//
//  CMCShopDetailTopTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailTopTVCell.h"
#import "BMapKit.h"


@implementation CMCShopDetailTopTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTabelViewCellfood:(CMCFoodDetail *)food
{
    

    NSURL *url = [BaseUtil systemRandomlyGenerated:food.merchant_image type:@"10" number:@"1"];
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 84, 84)];
    _photoImageView.layer.cornerRadius = 42;
    _photoImageView.clipsToBounds = YES;
    [self.contentView addSubview:_photoImageView];
    [_photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    //餐厅的名字
   _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width +_photoImageView.frame.origin.x +5, 24, 120, 20)];
    _titleLabel.textColor = [UIColor colorWithHexString:@"5b5b5b"];
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.text = food.merchant_name;
    [self.contentView addSubview:_titleLabel];
    //人数
    _peopleNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.size.width + _titleLabel.frame.origin.x + 5, 24, 80, 20)];
    
    _peopleNumberLabel.text = [NSString stringWithFormat:@"￥%@/人",food.merchant_gdp];
    _peopleNumberLabel.textColor = [UIColor colorWithHexString:@"4a94d2"];
    _peopleNumberLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_peopleNumberLabel];
    //营业时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 9, 200, 15)];
    _timeLabel.font = [UIFont fontWithName:nil size:14.0];
    
    _timeLabel.text = [NSString stringWithFormat:@"营业时间:%@",food.merchant_opentime];
    _timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_timeLabel];
    //口味
    _tasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + 5, 45, 11)];
    
    _tasteLabel.text = [NSString stringWithFormat:@"口味:%@",food.taste];
    _tasteLabel.font = [UIFont fontWithName:nil size:14.0];
    _tasteLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];
    _tasteLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_tasteLabel];

    _tasteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_tasteLabel.frame.origin.x + _tasteLabel.frame.size.width, _tasteLabel.frame.origin.y, 10, 11)];
    if ([food.taste_status isEqualToString:@"1"]) {
        _tasteImageView.image = [UIImage imageNamed:@"top"];
    } else {
    
        _tasteImageView.image = [UIImage imageNamed:@"down"];

    }
    [self.contentView addSubview:_tasteImageView];
    //速度
    _speedLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_tasteImageView.frame.origin.x + _tasteImageView.frame.size.width +5, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + 5, 45, 11)];
    _speedLabel.font = [UIFont fontWithName:nil size:12.0];

    _speedLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];

//    _speedLabel.backgroundColor = [UIColor orangeColor];
    _speedLabel.text = [NSString stringWithFormat:@"速度:%@",food.speed];
    [self.contentView addSubview:_speedLabel];
    
    
    _speedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_speedLabel.frame.origin.x + _speedLabel.frame.size.width, _tasteLabel.frame.origin.y, 10, 11)];
//    _speedImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_speedImageView];
    
    if ([food.speed isEqualToString:@"1"]) {
        _speedImageView.image = [UIImage imageNamed:@"top"];
    } else {
        
        _speedImageView.image = [UIImage imageNamed:@"down"];
        
    }
    
    //服务
    _severLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_speedImageView.frame.origin.x +_speedImageView.frame.size.width +10, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + 5, 45, 11)];
   
    _severLabel.text = [NSString stringWithFormat:@"服务:%@", food.serve];
    _severLabel.font = [UIFont fontWithName:nil size:12.0];

    _severLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];


    [self.contentView addSubview:_severLabel];
    
    _severImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_severLabel.frame.origin.x + _severLabel.frame.size.width, _tasteLabel.frame.origin.y, 10, 11)];
//    _severImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_severImageView];
    if ([food.serve_status isEqualToString:@"1"]) {
        _severImageView.image = [UIImage imageNamed:@"top"];
    } else {
        
        _severImageView.image = [UIImage imageNamed:@"down"];
        
    }
    //地区
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+10, self.bounds.size.width - _titleLabel.frame.origin.x -5 - 30, 11)];
    _areaLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _areaLabel.text = food.merchant_addr;
    _areaLabel.font = [UIFont fontWithName:nil size:12.0];
    
//    _areaLabel.text = @"石景山区苹果园北路53号店";
//    _areaLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_areaLabel];
    
    _mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapButton.frame = CGRectMake(_areaLabel.frame.size.width + _areaLabel.frame.origin.x + 3, _areaLabel.frame.origin.y-13, 13, 26);
    [_mapButton setImage:[UIImage imageNamed:@"map_detail"] forState:UIControlStateNormal];
    [_mapButton setImageEdgeInsets:UIEdgeInsetsMake(13, 0, 0, 0)];
    //    _mapButton.backgroundColor = [UIColor greenColor];
    _mapButton.userInteractionEnabled = YES;
    [_mapButton addTarget:self action:@selector(didClickmapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_mapButton];
    self.latitude = [food.latitude floatValue];
    self.longitude = [food.longitude floatValue];
}
- (void)didClickmapButton:(UIButton *)button
{
    NSLog(@"woowooow");
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
    end.name = self.titleLabel.text;
    //指定调启导航的app名称
    para.appName = [NSString stringWithFormat:@"%@", @"testAppName"];
    //调启web导航
    [BMKNavigation openBaiduMapNavigation:para];
    
    
}

@end
