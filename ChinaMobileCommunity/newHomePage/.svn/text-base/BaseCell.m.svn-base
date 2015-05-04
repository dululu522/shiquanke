//
//  BaseCell.m
//  CMCYouHuiVC
//
//  Created by 武鹏 on 14-11-11.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()

@end


@implementation BaseCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        

        _myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(22, 10, 95, 65)];
        
        [self addSubview:_myImageView];
        

        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(129, 10, 100, 15)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"6676767"];
        [self addSubview:_titleLabel];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];

        _button.frame = CGRectMake(229, 49, 74, 25);
        
        [self addSubview:_button];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(129, 30, 175, 22)];
        _detailLabel.textColor = [UIColor lightGrayColor];

        [self addSubview:_detailLabel];
        
        
        
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
