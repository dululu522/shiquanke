//
//  CMCPlaceCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPlaceCell.h"
#import "UIViewExt.h"

@implementation CMCPlaceCell



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
    if (_row != 3) {
        
        UILabel *titleL = [[UILabel alloc]init];
        titleL.frame = CGRectMake(15, 8,40, self.height - 16);
        titleL.textColor = [UIColor colorWithHexString:@"3a3a3a"];
        titleL.font = [UIFont systemFontOfSize:11];

        
        UILabel *contentL = [[UILabel alloc]init];
        contentL.frame = CGRectMake(titleL.right,8,self.width - titleL.right - 10, self.height - 16);
        contentL.textColor = [UIColor colorWithHexString:@"3a3a3a"];
        contentL.font = [UIFont systemFontOfSize:11];
        contentL.numberOfLines = 0;
        
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(self.frame.size.width - 21, 13, 18, 18);
        
        if (_row == 1) {
            titleL.text = @"地址：";
            contentL.text = self.myModel.address;
//            imgView.image = [UIImage imageNamed:@"convenience_map"];
        }else{
            NSMutableString *phone = [NSMutableString string];
            for (NSString *str in self.myModel.tel) {
                [phone appendString:str];
                if (self.myModel.tel.count > 2) {
                    [phone appendString:@"/"];
                }
            }
            
            titleL.text = @"电话：";
            contentL.text = phone;
            imgView.image = [UIImage imageNamed:@"convenience_phone"];
        }
        [self.contentView addSubview:titleL];
        [self.contentView addSubview:contentL];
        [self.contentView addSubview:imgView];
    }
//    else{
//        UIImageView *warningImg = [[UIImageView alloc]init];
//        warningImg.frame = CGRectMake(15, 15, 15, 15);
//        warningImg.backgroundColor = [UIColor redColor];
//        warningImg.image = [UIImage imageNamed:@"quickshopping"];
//        
//        UILabel *titleL = [[UILabel alloc]init];
//        titleL.frame = CGRectMake(warningImg.right + 5, 15, 150, 15);
//        if ([self.category isEqualToString:@"餐饮美食"]) {
//            titleL.text = @"快速点菜";
//        }else if ([self.category isEqualToString:@"便利生活"]){
//            titleL.text = @"快速购物";
//        }else if ([self.category isEqualToString:@"生活管家"]){
//            titleL.text = @"快速服务";
//        }
//        titleL.textColor = [UIColor colorWithHexString:@"3a3a3a"];
//        titleL.font = [UIFont systemFontOfSize:11];
//        
//        [self.contentView addSubview:warningImg];
//        [self.contentView addSubview:titleL];
    
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//    }
    
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
