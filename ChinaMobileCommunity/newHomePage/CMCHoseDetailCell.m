//
//  CMCHoseDetailCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-7.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCHoseDetailCell.h"

@implementation CMCHoseDetailCell

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
    //第一分区
    if (_indexPath.section == 0) {
        if (_indexPath.row == 0) {
            [self publicTime];
        }
        else if (_indexPath.row == 1){
            [self  info];
        }
//        else if (_indexPath.row == 2){
//            [self house];
//        }
    }
    
    //第二分区
    if (_indexPath.section == 1) {
        [self phone];
    }
    
    
}

//发布时间
- (void)publicTime{
    UILabel *nameL = [self returnLWithFrame:CGRectMake(10, 10, self.width - 20, 15) font:15 textColor:[UIColor colorWithHexString:@"444444"] superView:self.contentView];
    nameL.text = self.foodModel.name;
    
    
    UILabel *timeL = [self returnLWithFrame:CGRectMake(10, nameL.bottom + 10, self.width - 20, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
    timeL.text = [NSString stringWithFormat:@"发布时间：%@",@"2015-02-05"];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
}
- (void)info
{
    NSLog(@"%@",self.foodModel.intro);
//UITextView *rentL = [self returnLWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    rentL.text = self.foodModel.intro;
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20)];
    textView.userInteractionEnabled = NO;
    textView.text = self.foodModel.intro;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:textView];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
        
}

////具体信息
//- (void)info{
//    //租金
//    UILabel *rentL = [self returnLWithFrame:CGRectMake(10, 10, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    rentL.backgroundColor = [UIColor redColor];
//    rentL.text = @"租金：";
//    
//    UILabel *rentCL = [self returnLWithFrame:CGRectMake(rentL.right, rentL.top, 250, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
////    rentCL.text = @"4300元/月（押一付三）";
//    rentCL.text = [NSString stringWithFormat: @"%@元/月（押一付三）",self.foodModel.price];
//    
//    //规格
//    UILabel *standardL = [self returnLWithFrame:CGRectMake(10, rentL.bottom + 10, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    standardL.text = @"规格：";
//    
//    CGFloat heigt = [BaseUtil returnHeightWithContent:@"3室一厅一卫  精装修  70m2  普通住宅 朝南朝北    5/10层" WithFont:13 width:232 height:0];
//    UILabel *standardCL = [self returnLWithFrame:CGRectMake(standardL.right, standardL.top, 232, heigt) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    standardCL.numberOfLines = 0;
//    standardCL.text = @"3室一厅一卫  精装修  70m2  普通住宅 朝南朝北    5/10层";
//    
//    //地址
//    UILabel *placeL = [self returnLWithFrame:CGRectMake(10, standardCL.bottom + 10, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    placeL.text = @"地址：";
//    placeL.adjustsLetterSpacingToFitWidth = YES;
//    
//    UILabel *placeCL = [self returnLWithFrame:CGRectMake(placeL.right, placeL.top, 250, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    placeCL.text = @"石景山苹果园路痛经大厦702室";
//    
//    //分割线
//    UIView *sepeV = [[UIView alloc]init];
//    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
//    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//    [self.contentView addSubview:sepeV];
//    
//}


//房间配置
- (void)house{
//    UILabel *nameL = [self returnLWithFrame:CGRectMake(10, 15, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    nameL.text = @"房间配置：";
//    
//    CGFloat heigt = [BaseUtil returnHeightWithContent:@"床    沙发    热水器   洗衣机   电饭锅   电视   空调   煤气   宽带网   暖气  冰箱" WithFont:13 width:232 height:0];
//    UILabel *nameCL = [self returnLWithFrame:CGRectMake(nameL.right, nameL.top, 232, heigt) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
//    nameCL.numberOfLines = 0;
//    nameCL.text = @"床    沙发    热水器   洗衣机   电饭锅   电视   空调   煤气   宽带网   暖气  冰箱";
    
}


//联系电话
- (void)phone{
    UILabel *phoneL = [self returnLWithFrame:CGRectMake(10, 15, 261, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:self.contentView];
    phoneL.text = [NSString stringWithFormat:@"联系电话：%@",@"15639905596"];
    
    //打电话标识
    UIButton *phoneBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtt.frame = CGRectMake(phoneL.right, 10, 23, 23);
    [phoneBtt setImage:[UIImage imageNamed:@"myOrder_phone"] forState:UIControlStateNormal];
    [phoneBtt addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneBtt];
    
    
}

- (void)phoneAction:(UIButton *)sender{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否打电话？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:[NSString stringWithFormat:@"电话：%@",@"15639905596"], nil];
    [alertView show];
    
}

#pragma mark - alertViewDelegate - 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"15639905596"]]];
    }
    
    
}

#pragma mark - 公共方法 －
- (UILabel *)returnLWithFrame:(CGRect)frame
                         font:(CGFloat)font
                    textColor:(UIColor *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentNatural;
    label.adjustsLetterSpacingToFitWidth = YES;
    [superView addSubview:label];
    return label;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
