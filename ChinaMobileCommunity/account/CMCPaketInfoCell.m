//
//  CMCPaketInfoCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPaketInfoCell.h"

@implementation CMCPaketInfoCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}

- (void)createSubViews{
    
    CGRect rect = [BaseUtil returnHeightWithContent:self.dataStr WithFont:13 width:self.width - 20 height:0];
    CGFloat height = rect.size.height;
    UILabel *infoL = [[UILabel alloc]init];
    infoL.frame = CGRectMake(10, 10, self.width - 20, height);
    infoL.font = [UIFont systemFontOfSize:13];
    infoL.textColor = [UIColor colorWithHexString:@"444444"];
    infoL.text = self.dataStr;
    infoL.numberOfLines = 0;
    [self.contentView addSubview:infoL];
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
