//
//  CMCMyVoucherPackageCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyVoucherPackageCell.h"

@implementation CMCMyVoucherPackageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self createSubViews];
    
}



- (void)createSubViews{
    //标知
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(10,11, 25, 16);
    [self.contentView addSubview:imgView];
    
    //名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 5, 12, 200, 15) font:15 textColor:@"444444" superView:self.contentView];
    
    //    nameL.text = @"金百万烤鸭店";
    
    //    nameL.text = self.couponDetail.name;
    
    
    //电话
    UILabel *phoneL = [self createLWithFrame:CGRectMake(16, imgView.bottom + 11, self.frame.size.width - 32, 12) font:12 textColor:@"666666" superView:self.contentView];
    //    phoneL.text = [NSString stringWithFormat:@"电话:%@",self.couponDetail.phone];
    
    //地址
    UILabel *placeL = [self createLWithFrame:CGRectMake(16, phoneL.bottom + 9, self.frame.size.width - 32, 12) font:12 textColor:@"666666" superView:self.contentView];
    //有效期
       UILabel *periodLabel = [self createLWithFrame:CGRectMake(16, placeL.bottom + 9, self.frame.size.width - 32, 12) font:12 textColor:@"666666" superView:self.contentView];

    if ([self.category isEqualToString:@"折扣券详情"]) {
        imgView.image = [UIImage imageNamed:@"my_couponDetail"];
    }
    NSLog(@"手机  %@",[self.couponDetail.detail objectForKey:@"name"]);
        nameL.text = [self.couponDetail.detail objectForKey:@"name"];
        NSString *create_time =  [BaseUtil becomeNormalWithString:self.couponDetail.create_time];
        NSString *close_time = [BaseUtil becomeNormalWithString:self.couponDetail.expire_time];
        periodLabel.text = [NSString stringWithFormat:@"有效期:%@至%@",create_time,close_time];
        
        placeL.text = [NSString stringWithFormat:@"地址:%@",[self.couponDetail.detail objectForKey:@"address"]];
        phoneL.text = [NSString stringWithFormat:@"电话:%@",[self.couponDetail.detail objectForKey:@"phone"]];
//    }
    if ([self.category isEqualToString:@"代金券详情"]){
        imgView.image = [UIImage imageNamed:@"my_vouchersDetail"];
        if ([[self.couponDetail.detail objectForKey:@"refund"] intValue] == 1 && [[self.couponDetail.detail objectForKey:@"auto_refund"] intValue] == 1) {
            for (int i = 0; i < 2; i++) {
                UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
                btt.frame = CGRectMake(18 + 106 * i, periodLabel.bottom + 9, 80, 11);
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
            btt.frame = CGRectMake(18, periodLabel.bottom + 9, 80, 11);
            btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
            btt.titleLabel.font = k_font(11);
            [btt setImage:[UIImage imageNamed:@"对号_13"] forState:UIControlStateNormal];
            
            if ([[self.couponDetail.detail objectForKey:@"auto_refund"] intValue] == 1) {
                [btt setTitle:@"过期自动退" forState:UIControlStateNormal];
                
            }
            if ([[self.couponDetail.detail objectForKey:@"refund"] intValue] == 1) {
                [btt setTitle:@"支持随时退" forState:UIControlStateNormal];
                
            }
            [btt setTitleColor:k_color(@"19d505") forState:UIControlStateNormal];
            [self.contentView addSubview:btt];
        }

        
    }
//    if ([self.category isEqualToString:@"代金券详情"]) {
//        UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom ];
//        btt.frame = CGRectMake(self.width - 23 - 38, 23, 38, 38);
//        btt.backgroundColor = [UIColor redColor];
//        [btt setImage:[UIImage imageNamed:@"log"] forState:UIControlStateNormal];
//        [btt addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:btt];
//    }

//    //分割线
//    UIView *sepeV = [[UIView alloc]init];
//    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
//    sepeV.backgroundColor = k_color(@"ededed");
//    [self.contentView addSubview:sepeV];
//    if ([self.category isEqualToString:@"代金券详情"]) {
//        
//        //        nameL.text = self.vouchersModel.name;
//        //        phoneL.text = [NSString stringWithFormat:@"电话:%@",self.vouchersModel.phone];
//        
//    }
    
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

//- (void)phoneAction:(UIButton *)sender{
//    if (_block) {
//        _block(@"18089040405");
//    }
//}
//
//
//- (void)setupPhoneBlock:(phoneBlock)myBlock{
//    if (_block != myBlock) {
//        _block = myBlock;
//    }
//    
//}

@end
