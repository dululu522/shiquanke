//
//  CMCBuyMustKnowCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCBuyMustKnowCell.h"

@implementation CMCBuyMustKnowCell


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
    UILabel *contentL = [[UILabel alloc]init];
    contentL.frame = CGRectMake(16, 10, self.width - 32, 12);
    contentL.font = k_font(12);
    contentL.textColor = k_color(@"656565");
    contentL.numberOfLines = 0;
    NSString *content;
    if ([self.category isEqualToString:@"代金券详情"]) {
        content = self.vouchersModel.notice;
    }else{
        content = self.discountModel.notice;
    }
    
     CGRect heigh =   [BaseUtil returnHeightWithContent:content WithFont:12.0 width:self.frame.size.width - 32 height:0];
    
    contentL.frame = CGRectMake(16, 10, self.width - 32, heigh.size.height);
    contentL.text = content;
    [self.contentView addSubview:contentL];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
