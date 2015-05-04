//
//  CMCComplaintRecordView.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCComplaintRecordView.h"

@implementation CMCComplaintRecordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)creatViewMap:(NSString *)mapAddress communityText:(NSString *)communityText typeText:(NSString *)typeText
{
    UIView *mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    mapView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mapView];
    
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 10, 13)];
    mapImageView.image = [UIImage imageNamed:@"地_03"];
    [mapView addSubview:mapImageView];
    _mapLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(mapImageView.frame.size.width + mapImageView.frame.origin.x + 6, 5, 250, 30)];
    //    _mapLabelTextField.delegate = self;
    _mapLabelTextField.text = [CMCUserManager shareManager].currentAddress;
    _mapLabelTextField.userInteractionEnabled = NO;
    
    [mapView addSubview:_mapLabelTextField];
    //小区
    UIView *seconView = [[UIView alloc] initWithFrame:CGRectMake(0, mapView.frame.size.height + mapView.frame.origin.y + 15, self.bounds.size.width, 90)];
    seconView.backgroundColor = [UIColor whiteColor];
    [self addSubview:seconView];
    
    UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, self.bounds.size.width - 20, 1)];
    middleImageView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    
    [seconView addSubview:middleImageView];
    
    _communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 100, 45)];
    _communityLabel.font = [UIFont systemFontOfSize:14.0];
    _communityLabel.text = communityText;
    [seconView addSubview:_communityLabel];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 10, 15, 15)];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [seconView addSubview:searchImageView];
    
    UIButton *communityButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 45)];
    communityButton.userInteractionEnabled = YES;
    [communityButton addTarget:self action:@selector(didClickcommunityButton:) forControlEvents:UIControlEventTouchUpInside];
    [seconView addSubview:communityButton];
    
    //报修类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45 , self.bounds.size.width - 100, 45)];
    if (typeText.length) {
        _typeLabel.text = typeText;
        
    } else {
        
        _typeLabel.text = @"环境";
    }
    _typeLabel.font = [UIFont systemFontOfSize:14.0];
    
    [seconView addSubview:_typeLabel];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 45 + 17, 10, 15)];
    [seconView addSubview:arrowImageView];
    arrowImageView.image = [UIImage imageNamed:@"展开"];
    UIButton *typeButton = [[UIButton alloc] initWithFrame:_typeLabel.frame];
    [typeButton addTarget:self action:@selector(didClickTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [seconView addSubview:typeButton];
    
    
    //投诉内容
    
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, seconView.bottom + 15, self.bounds.size.width, 60)];
    NSLog(@"^^^^^^^^^^%@",_contentView);
    _contentView.delegate = self;
    _contentView.hidden = NO;
    //    _contentView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_contentView];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    _contentLabel.enabled = YES;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_contentLabel];
    
    if ([self.category isEqualToString:@"投诉记录"] | [self.category isEqualToString:@"报修记录"]) {
        if ([self.complaint.type integerValue] == 0) {
            NSLog(@"aaaaaaaaaaaaaaaaaaaa");
            _typeLabel.text = self.complaint.genre;
            
            _contentLabel.text = self.complaint.content;
            
        } else {
            
            _typeLabel.text = self.complaint.genre;
            _contentLabel.text = self.complaint.content;
            
        }
    }
//    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, _contentView.frame.size.height + _contentView.frame.origin.y + 30, 120, 40)];
//    
//    submitButton.userInteractionEnabled = YES;
//    [submitButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
//    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
//    [submitButton addTarget:self action:@selector(didClickSubmitButton2) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:submitButton];
    
}






@end
