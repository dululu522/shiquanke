//
//  CMCDateInfoCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDateInfoCell.h"

@implementation CMCDateInfoCell



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
    
    //名字
    UILabel *timeL = [self createLWithFrame:CGRectMake(16, 10, 200, 12) font:12 textColor:@"666666" superView:self.contentView];
    if ([self.category isEqualToString:@"折扣券详情"]) {
        if (self.couponDetail.update_time) {
            timeL.text = [NSString stringWithFormat:@"有效期: %@天",self.couponDetail.days];
        } else {
            
            timeL.text = @"有效期:";
        }
    }
    if ([self.category isEqualToString:@"代金券详情"]) {
        if (self.vouchersModel.update_time) {
            
            timeL.text = [NSString stringWithFormat:@"有效期: %@天",[BaseUtil becomeNormalWithString:self.vouchersModel.days]];
        } else {
            
            timeL.text = @"有效期:";
        }
    }
    //    timeL.text = @"有效期:40天";
    
    //电话
    UILabel *dateL = [self createLWithFrame:CGRectMake(16,timeL.bottom + 7, 200, 12) font:12 textColor:@"666666" superView:self.contentView];
    
    if ([self.category isEqualToString:@"折扣券详情"]) {
        if (self.couponDetail.close_time) {
            dateL.text = [NSString stringWithFormat:@"下载截止日期:%@",self.couponDetail.close_time];
            
        } else {
            dateL.text = [NSString stringWithFormat:@"下载截止日期:"];
            
        }
        
    }
    
    if ([self.category isEqualToString:@"代金券详情"]) {
        
        if (self.vouchersModel.close_time) {
            dateL.text = [NSString stringWithFormat:@"下载截止日期:%@",self.vouchersModel.close_time];
            
        } else {
            dateL.text = [NSString stringWithFormat:@"下载截止日期:"];
            
        }
        if ([self.vouchersModel.refund intValue] == 1 && [self.vouchersModel.auto_refund intValue] == 1) {
            for (int i = 0; i < 2; i++) {
                UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
                btt.frame = CGRectMake(18 + 106 * i, dateL.bottom + 9, 80, 11);
                btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
                btt.titleLabel.font = k_font(11);
                [btt setImage:[UIImage imageNamed:@"对号_13"] forState:UIControlStateNormal];
                if (i == 0) {
                    [btt setTitle:@"支持随时退" forState:UIControlStateNormal];
                }else{
                    [btt setTitle:@"支持过期退" forState:UIControlStateNormal];
                }
                [btt setTitleColor:k_color(@"19d505") forState:UIControlStateNormal];
                [self.contentView addSubview:btt];
            }
        }
        else {
        
        

                UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
                btt.frame = CGRectMake(18, dateL.bottom + 9, 80, 11);
                btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
                btt.titleLabel.font = k_font(11);
                [btt setImage:[UIImage imageNamed:@"对号_13"] forState:UIControlStateNormal];

            if ([self.vouchersModel.auto_refund intValue] == 1) {
                [btt setTitle:@"过期自动退" forState:UIControlStateNormal];

            }
            if ([self.vouchersModel.refund intValue] == 1) {
                [btt setTitle:@"支持随时退" forState:UIControlStateNormal];
                
            }
                [btt setTitleColor:k_color(@"19d505") forState:UIControlStateNormal];
                [self.contentView addSubview:btt];
        }

        
        
        
    }
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
}



@end
