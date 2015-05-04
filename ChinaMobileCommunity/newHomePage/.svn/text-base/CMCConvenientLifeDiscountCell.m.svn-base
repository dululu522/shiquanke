//
//  CMCConvenientLifeDiscountCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCConvenientLifeDiscountCell.h"

@interface CMCConvenientLifeDiscountCell ()


@property (nonatomic,strong)downLoadBlock block;

@end



@implementation CMCConvenientLifeDiscountCell


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
    self.coupon_id = self.couponsModel.id;
    //图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(22, 10, 84, 65);
    //    imgView.backgroundColor = [UIColor redColor];
    NSURL *imageUrl = [BaseUtil systemRandomlyGenerated:self.couponsModel.logo type:@"20" number:@"1"];
    [imgView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"log"]];
    [self.contentView addSubview:imgView];
    
    //商家名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 11, imgView.top, 100, 13) font:13 textColor:@"3a3a3a" superView:self.contentView];
    nameL.text = self.couponsModel.name;
    
    //折扣
    UILabel *discountL = [self createLWithFrame:CGRectMake(nameL.left, nameL.bottom + 14, 100, 18) font:15 textColor:@"f6ad12" superView:self.contentView];
    discountL.adjustsFontSizeToFitWidth = YES;
    
    
    //地址
    UILabel *placeL = [self createLWithFrame:CGRectMake(discountL.left, discountL.bottom + 7, 200, 12) font:12 textColor:@"acacac" superView:self.contentView];
    if (self.couponsModel.address) {
        placeL.text = self.couponsModel.address;
        
    }
    
    
    //折扣券
    if (self.section == 0) {
        discountL.text = [NSString stringWithFormat:@"%@折",self.couponsModel.discount];
        
        //折
        UIImageView *waringImg = [[UIImageView alloc]init];
        waringImg.frame = CGRectMake(10, imgView.top, 18, 18);
        waringImg.image = [UIImage imageNamed:@"discountCoupons@2X"];
        [self.contentView addSubview:waringImg];
        
        //下载折扣券
        UIButton *downLoadDis = [UIButton buttonWithType:UIButtonTypeCustom];
        downLoadDis.frame = CGRectMake(nameL.right, nameL.top, 90, 33);
        [downLoadDis setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [downLoadDis setTitle:@"下载折扣" forState:UIControlStateNormal];
        downLoadDis.titleLabel.font = [UIFont systemFontOfSize:12];
        [downLoadDis addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:downLoadDis];
        
        
    }
    
    //代金券
    if (self.section == 1) {
        discountL.text = [NSString stringWithFormat:@"现价:%@",self.couponsModel.money_buy];
        
        //        discountL.text = @"现价：¥105";
        UILabel *oldPL = [self createLWithFrame:CGRectMake(discountL.right, discountL.top + 10, 100, 10) font:10 textColor:@"acacac" superView:self.contentView];
        
        oldPL.text = [NSString stringWithFormat:@"¥%@",self.couponsModel.money_use];
        
        //        oldPL.text = @"¥220";
        
        [BaseUtil setCenterLineView:oldPL];
        //        UIView *viewH = [[UIView alloc]init];
        //        viewH.frame = CGRectMake(-5, 5, oldPL.width, 0.5);
        //        viewH.backgroundColor = [UIColor colorWithHexString:@"acacac"];
        //        [oldPL addSubview:viewH];
        //        [self.contentView addSubview:oldPL];
        
        
    }
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
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

    if ([CMCUserManager shareManager].token) {
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic =@{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"coupon_id":self.coupon_id,@"timestamp":timestamp};
        NSString *sig= [BaseUtil getSigWithArray:dic];
        NSString *requestStr = KAPI_DownCoupon([CMCUserManager shareManager].token, timestamp, [BaseUtil md5:sig], self.coupon_id);
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
    
    //    if (_block) {
    //        _block();
    //    }
    
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
