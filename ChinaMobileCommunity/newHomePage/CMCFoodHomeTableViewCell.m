//
//  CMCFoodHomeTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFoodHomeTableViewCell.h"

@implementation CMCFoodHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatcellfood:(CMCFood *)food
{
    [self.titleLabel removeFromSuperview];
    [self.distanceLabel removeFromSuperview];
    [self.tasteLabel removeFromSuperview];
    [self.tasteImageView removeFromSuperview];
    [self.speedLabel removeFromSuperview];
    [self.speedImageView removeFromSuperview];
    [self.severImageView removeFromSuperview];
    [self.severLabel removeFromSuperview];
    [self.priceLabel removeFromSuperview];
    [_dianCanlabel removeFromSuperview];
    [_schedulelabel removeFromSuperview];
    [_checklabel removeFromSuperview];
    [_takeoutlabel removeFromSuperview];
    [_couponlabel removeFromSuperview];
    [_timelabel removeFromSuperview];
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 107, 73)];
    [self.contentView addSubview:_photoImageView];

    // 214*146图片
  NSURL *url = [BaseUtil systemRandomlyGenerated:food.merchant_image type:@"10" number:@"1"];
    [_photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    //营业时间
    
   _timelabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.origin.x, _photoImageView.frame.size.height + _photoImageView.frame.origin.y - 20, _photoImageView.frame.size.width, 20)];
    _timelabel.text = [NSString stringWithFormat:@"营业时间:%@",food.merchant_opentime];
    _timelabel.textColor = [UIColor whiteColor];
    _timelabel.font = [UIFont systemFontOfSize:9.5];
    _timelabel.backgroundColor = [UIColor blackColor];
    _timelabel.textAlignment = NSTextAlignmentCenter;
    _timelabel.alpha = 0.48;
    [self.contentView addSubview:_timelabel];
    
    //餐厅的名字
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width +_photoImageView.frame.origin.x +5, 13, 120, 14)];
    _titleLabel.text = food.merchant_name;
    _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_titleLabel];
    //距离
    UIImageView *distanceimageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 50, 10, 5, 10)];
//    distanceimageView.image = [UIImage imageNamed:@"点击_11"];
    [self.contentView addSubview:distanceimageView];
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, 13, 40, 9)];
    float n = [BaseUtil distanceBetweenOrderBy:[CMCUserManager shareManager].latitude :[food.latitude  doubleValue]:[CMCUserManager shareManager].longitude :[food.longitude doubleValue]];
    _distanceLabel.text = [NSString stringWithFormat:@"%.fm",n];    _distanceLabel.font = [UIFont fontWithName:nil size:12.0];
    _distanceLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
//    _distanceLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_distanceLabel];
    //口味
    _tasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, 45, 11)];
    _tasteLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _tasteLabel.text = [NSString stringWithFormat:@"口味:%@",food.taste];
    _tasteLabel.font = [UIFont systemFontOfSize:11];
    
    
//    _tasteLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_tasteLabel];
    _tasteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_tasteLabel.frame.origin.x + _tasteLabel.frame.size.width, _tasteLabel.frame.origin.y, 10, 11)];
//    _tasteImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_tasteImageView];
    //速度
    _speedLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_tasteImageView.frame.origin.x + _tasteImageView.frame.size.width +5,  _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, 45, 11)];
    _speedLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _speedLabel.text = [NSString stringWithFormat:@"速度:%@",food.speed];
    _speedLabel.font = [UIFont systemFontOfSize:11];

//    _speedLabel.backgroundColor = [UIColor orangeColor];
    //    _speedLabel.text = @"速度";
    [self.contentView addSubview:_speedLabel];
    _speedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_speedLabel.frame.origin.x + _speedLabel.frame.size.width, _tasteLabel.frame.origin.y, 10, 11)];
//    _speedImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_speedImageView];
    
    //服务
    _severLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_speedImageView.frame.origin.x +_speedImageView.frame.size.width +5,  _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, 45, 11)];
    _severLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _severLabel.font = [UIFont systemFontOfSize:11];
    _severLabel.text = [NSString stringWithFormat:@"服务:%@",food.serve];
//    _severLabel.backgroundColor = [UIColor grayColor];
    //    _severLabel.text = @"服务";
    [self.contentView addSubview:_severLabel];
    
    _severImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_severLabel.frame.origin.x + _severLabel.frame.size.width, _tasteLabel.frame.origin.y , 10, 11)];
//    _severImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_severImageView];
    //点餐 预订 买单 外卖 优惠
    if ([food.taste_status isEqualToString:@"1"]) {
        _tasteImageView.image = [UIImage imageNamed:@"top"];
    } else {
        _tasteImageView.image = [UIImage imageNamed:@"down"];
    }
    if ([food.speed_status isEqualToString:@"1"]) {
        _speedImageView.image = [UIImage imageNamed:@"top"];
    } else {
        _speedImageView.image = [UIImage imageNamed:@"down"];
    }
    if ([food.serve_status isEqualToString:@"1"]) {
        _severImageView.image = [UIImage imageNamed:@"top"];
    } else {
        _severImageView.image = [UIImage imageNamed:@"down"];
    }
    _dianCanlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x , _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+5, 30, 11)];
//    dianCanlabel.backgroundColor = [UIColor redColor];
    _dianCanlabel.text = @"点餐";
    [self.contentView addSubview:_dianCanlabel];
//    _dianCanlabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];

        if ([food.order_state isEqualToString:@"0"]) {
//            [arr addObject:@"点餐"];
            _dianCanlabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
        } else {
            _dianCanlabel.textColor = [UIColor colorWithHexString:@"555555"];

        
        }


    _schedulelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 35, _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+5, 30, 11)];
//    schedulelabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_schedulelabel];
    _schedulelabel.text = @"预订";
    if ([food.schedule_state isEqualToString:@"0"]) {
            _schedulelabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];

        //            [arr addObject:@"点餐"];
    } else {
            _schedulelabel.textColor = [UIColor colorWithHexString:@"555555"];

    
    }

    _checklabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 70, _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+5, 30, 11)];
    [self.contentView addSubview:_checklabel];
    if ([food.check_state isEqualToString:@"0"]) {
        //            [arr addObject:@"点餐"];
        _checklabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    }else {
    
      
            _checklabel.textColor = [UIColor colorWithHexString:@"555555"];

    }
    
    _takeoutlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 35*3, _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+5, 30, 11)];
//    takeoutlabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_takeoutlabel];
    if ([food.takeout_state isEqualToString:@"0"]) {
        _takeoutlabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    } else {
    
        _takeoutlabel.textColor = [UIColor colorWithHexString:@"555555"];

    }
    _couponlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 35*4, _tasteLabel.frame.size.height + _tasteLabel.frame.origin.y+5, 30, 11)];
//    couponlabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_couponlabel];
    if ([food.coupon_state isEqualToString:@"0"]) {
        //            [arr addObject:@"点餐"];
        _couponlabel.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    } else {
    
        _couponlabel.textColor = [UIColor colorWithHexString:@"555555"];

    }
    _checklabel.text = @"买单";
    _takeoutlabel.text = @"外卖";
    _couponlabel.text = @"优惠";
    _dianCanlabel.font = [UIFont fontWithName:nil size:11.0];
    _schedulelabel.font = [UIFont fontWithName:nil size:11.0];
    _checklabel.font = [UIFont fontWithName:nil size:11.0];
    _takeoutlabel.font = [UIFont fontWithName:nil size:11.0];
    _couponlabel.font = [UIFont fontWithName:nil size:11.0];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, _dianCanlabel.frame.size.height + _dianCanlabel.frame.origin.y+6, 200, 13)];
    //    _priceLabel.backgroundColor = [UIColor orangeColor];
    _priceLabel.text = [NSString stringWithFormat:@"人均:￥%@/人",food.merchant_gdp];
    _priceLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_priceLabel];


    
    


}


@end
