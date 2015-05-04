//
//  CMCDisAndVouCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDisAndVouCell.h"


@interface CMCDisAndVouCell()


@property (nonatomic,strong)downLoadBlock block;

@end

@implementation CMCDisAndVouCell




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
    [self createSubView];
}



- (void)createSubView{
    
    //图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(10, 12, 100, 75);
//    imgView.backgroundColor = [UIColor redColor];

    [self.contentView addSubview:imgView];
    
    //商家名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 10, imgView.top, 100, 13) font:13 textColor:@"393939" superView:self.contentView];
    
    
    //折扣券
    if (self.section == 0) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:self.couponsModel.logo type:@"20" number:@"3"];
        [imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
        nameL.text = self.couponsModel.name;

        //地址
        UILabel *placeL = [self createLWithFrame:CGRectMake(nameL.left, nameL.bottom + 11, 200, 12) font:12 textColor:@"555555" superView:self.contentView];
        placeL.text = [NSString stringWithFormat:@"地址:%@",self.couponsModel.address];
        
        //折扣
        UILabel *discountL = [self createLWithFrame:CGRectMake(placeL.left, placeL.bottom + 14, 100, 18) font:15 textColor:@"ff0300" superView:self.contentView];
        discountL.text = [NSString stringWithFormat:@"%@折",self.couponsModel.discount];
        discountL.adjustsFontSizeToFitWidth = YES;
        
        //下载折扣券
        UIButton *downLoadDis = [UIButton buttonWithType:UIButtonTypeCustom];
        downLoadDis.frame = CGRectMake(self.width - 11 - 77,imgView.bottom - 27, 77, 27);
        [downLoadDis setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [downLoadDis setTitle:@"下载折扣" forState:UIControlStateNormal];
        downLoadDis.titleLabel.font = [UIFont systemFontOfSize:12];
        [downLoadDis addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:downLoadDis];
        
        
    }
    
    //代金券
    if (self.section == 1) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:self.vouchersModel.logo type:@"20" number:@"3"];
        [imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
        nameL.text = self.vouchersModel.name;
        //折扣
        UILabel *discountL = [self createLWithFrame:CGRectMake(nameL.left, nameL.bottom + 14, 80, 18) font:15 textColor:@"ff0300" superView:self.contentView];
        discountL.text = [NSString stringWithFormat:@"¥%@",self.vouchersModel.money_buy];
        discountL.adjustsFontSizeToFitWidth = YES;
        
        UILabel *oldPL = [self createLWithFrame:CGRectMake(discountL.right, discountL.top + 10, 40, 10) font:10 textColor:@"acacac" superView:self.contentView];
        oldPL.text = [NSString stringWithFormat:@"¥%@",self.vouchersModel.money_use];;
        
        
        UIView *viewH = [[UIView alloc]init];
        viewH.frame = CGRectMake(-5, 5, oldPL.width, 0.5);
        viewH.backgroundColor = [UIColor colorWithHexString:@"acacac"];
        [oldPL addSubview:viewH];
        [self.contentView addSubview:oldPL];
        
        //地址
        UILabel *placeL = [self createLWithFrame:CGRectMake(discountL.left, discountL.bottom + 14, 200, 12) font:12 textColor:@"555555" superView:self.contentView];
        placeL.text = [NSString stringWithFormat:@"地址:%@",self.vouchersModel.address];
        
        
    }
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(0,imgView.bottom + 9, self.width, 4.5);
    sepeV.backgroundColor = k_color(@"f5f4f4");
    [self.contentView addSubview:sepeV];
    
    
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

- (void)downloadButtonAction:(UIButton *)sender{
    
//    if (_block) {
//        _block();
//    }
        //        [BaseUtil toast:@"优惠券已下载，可在我的券包里查看"];
        if ([CMCUserManager shareManager].token) {
            NSString *timestamp = kAPI_timestamp;
            NSDictionary *dic =@{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"coupon_id":self.couponsModel.id,@"timestamp":timestamp};
            NSLog(@"dic %@",dic);
            NSString *sig= [BaseUtil getSigWithArray:dic];
            NSString *requestStr = KAPI_DownCoupon([CMCUserManager shareManager].token, timestamp, [BaseUtil md5:sig], self.couponsModel.id);
            [BaseUtil get:requestStr success:^(id respondObject) {
                NSLog(@"下载折扣: %@",respondObject);
                NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    [BaseUtil toast:@"下载成功"];
                }
            } failure:^(NSError *error) {
                
            }];
        } else {
            
            
            
        }
        

}


- (void)setupDownLoadBlock:(downLoadBlock)myBlokc{
    if (_block != myBlokc){
        _block = myBlokc;
    }
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
