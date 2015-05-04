//
//  TCShopStoreServiceTableViewCell.m
//  TelecomCommunity
//
//  Created by mac on 14-12-6.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "TCShopStoreServiceTableViewCell.h"

@implementation TCShopStoreServiceTableViewCell
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//    }
//    return self;
//}
//
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self createSubView];
//    
//}
//
//
//- (void)createSubView{
//    NSArray *imgNameArr = [NSArray arrayWithObjects:@"购物",@"买单",@"优惠", nil];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 14, 14, 12)];
//    imageView.image = [UIImage imageNamed:imgNameArr[_indexPath]];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 10, 0, 30 , 40)];
//    label.text = imgNameArr[_indexPath];
//    label.font = [UIFont systemFontOfSize:12.0];
//    label.textColor = [UIColor colorWithHexString:@"6b6b6b"];
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 40, 84, 1)];
//    view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//    
//    if (_indexPath != 2) {
//        //分割线
//        UIView *sepeV = [[UIView alloc]init];
//        sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
//        sepeV.backgroundColor = [UIColor colorWithHexString:@"c2c2c2"];
//        [self.contentView addSubview:sepeV];
//    }
//    
//    
//    [self.contentView addSubview:imageView];
//    [self.contentView addSubview:label];
//    [self.contentView addSubview:view];
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatImageView:(NSString *)imageString title:(NSString *)titleText
{
    NSLog(@"titleText ======%@",titleText);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 14, 14, 12)];
//    imageView.image = [UIImage imageNamed:imageString];
//    [self.contentView addSubview:imageView];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 10, 0, 30 , 40)];
//    [self addDataWithLable:label text:titleText];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,94, 40)];
//    label.backgroundColor = [UIColor redColor];
    label.text = titleText;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12.0];
    label.textColor = [UIColor colorWithHexString:@"6b6b6b"];
    [self.contentView addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 40, 84, 1)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];

}

- (void)addDataWithLable:(UILabel *)lable text:(NSString *)text{
    
        if ([text isEqualToString:@"1"]) {
            lable.text = @"点菜";
            
        }
        if ([text isEqualToString:@"2"]) {
            lable.text = @"外卖";
            
        }
        if ([text isEqualToString:@"3"]) {
            lable.text = @"买单";
            
        }
        if ([text isEqualToString:@"4"]) {
            lable.text = @"预定";
            
        }
        if ([text isEqualToString:@"5"]) {
            lable.text = @"优惠";
        }
        if ([text isEqualToString:@"6"]) {
          lable.text = @"购物";
            
        }
   
}



@end
