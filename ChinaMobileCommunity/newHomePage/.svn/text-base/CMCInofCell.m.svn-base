//
//  CMCInofCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCInofCell.h"

@interface CMCInofCell ()


@property (nonatomic,strong)phoneBlock block;

@end


@implementation CMCInofCell



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
    //标知
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(10,11, 16, 16);
    imgView.image = [UIImage imageNamed:@"icon_onsalezone_shop "];
    [self.contentView addSubview:imgView];
    
    //名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 5, 12, 200, 15) font:15 textColor:@"444444" superView:self.contentView];
    
    //    nameL.text = @"金百万烤鸭店";
    
    //    nameL.text = self.couponDetail.name;
    
    
    //电话
    UILabel *phoneL = [self createLWithFrame:CGRectMake(16, imgView.bottom + 11, 200, 12) font:12 textColor:@"666666" superView:self.contentView];
    //    phoneL.text = [NSString stringWithFormat:@"电话:%@",self.couponDetail.phone];
    
    //地址
    UILabel *placeL = [self createLWithFrame:CGRectMake(16, phoneL.bottom + 9, 200, 12) font:12 textColor:@"666666" superView:self.contentView];
    placeL.numberOfLines = 0;
    NSString *placeStr ;
    CGFloat width = 0.0;
    if ([self.category isEqualToString:@"折扣券详情"]) {
        nameL.text = self.couponDetail.name;
        placeL.text = [NSString stringWithFormat:@"地址:%@",self.couponDetail.address];
        phoneL.text = [NSString stringWithFormat:@"电话:%@",self.couponDetail.phone];
        placeStr = self.couponDetail.address;
        width = self.width - 32;
    }
    if ([self.category isEqualToString:@"代金券详情"]){
        
        nameL.text = self.vouchersModel.name;
        placeL.text = [NSString stringWithFormat:@"地址:%@",self.vouchersModel.address];
        phoneL.text = [NSString stringWithFormat:@"电话:%@",self.vouchersModel.phone];
        placeStr = self.vouchersModel.address;
        width = 250;
    }
    
    CGRect rect = [BaseUtil returnHeightWithContent:placeStr WithFont:12 width:width height:0];
    placeL.frame = CGRectMake(16, phoneL.bottom + 9, width, rect.size.height);
    
    if ([self.category isEqualToString:@"代金券详情"]) {
        UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom ];
        btt.frame = CGRectMake(self.width - 23 - 38, 23, 38, 38);
        [btt setImage:[UIImage imageNamed:@"myOrder_phone"] forState:UIControlStateNormal];
        [btt addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btt];
    }
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = k_color(@"ededed");
    [self.contentView addSubview:sepeV];
    if ([self.category isEqualToString:@"代金券详情"]) {
        
        //        nameL.text = self.vouchersModel.name;
        //        phoneL.text = [NSString stringWithFormat:@"电话:%@",self.vouchersModel.phone];
        
    }
    
}


- (void)phoneAction:(UIButton *)sender{
    if (_block) {
        //0138
        if ([self.category isEqualToString:@"折扣券详情"]) {
            _block(self.couponDetail.phone);
        }
        if ([self.category isEqualToString:@"代金券详情"]) {
            _block(self.vouchersModel.phone);//0318
        }
        
    }
}


- (void)setupPhoneBlock:(phoneBlock)myBlock{
    if (_block != myBlock) {
        _block = myBlock;
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
