//
//  CMCPaketDetailCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

//0318
#import "CMCPaketDetailCell.h"

@implementation CMCPaketDetailCell

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
    //券号
    UILabel *nameL = [self returnLWithFrame:CGRectMake(15, 9, 250, 13) font:13 superView:self.contentView];
    

    //密码：
    UILabel *psL = [self returnLWithFrame:CGRectMake(15, nameL.bottom + 10, 250, 13) font:13 superView:self.contentView];

    //分割线
    UIView *sepV = [[UIView alloc]initWithFrame:CGRectMake(5, psL.bottom + 10, self.width - 10, 1)];
    sepV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepV];
    
    //有效期
    UILabel *timeL = [self returnLWithFrame:CGRectMake(15, sepV.bottom + 13, 250, 13) font:13 superView:self.contentView];

    if (self.userDic) {
            nameL.text = [NSString stringWithFormat:@"券号：%@",self.dataModel.code];
        
            psL.text = [NSString stringWithFormat:@"密码：%@",self.dataModel.pass];
        
        NSString *create_time = [self becomeNormalWithString:[self.infoDic objectForKey:@"create_time"]];
        NSString *expire_time = [self becomeNormalWithString:[self.infoDic objectForKey:@"close_time"]];
        timeL.text = [NSString stringWithFormat:@"有效期：%@至%@",create_time,expire_time];

    }
    

    
    if ([[self.userDic objectForKey:@"state"] intValue] == 1) {
        UIView *sepV1 = [[UIView alloc]initWithFrame:CGRectMake(5, timeL.bottom + 13, self.width - 10, 1)];
        sepV1.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [self.contentView addSubview:sepV1];
        
        //使用商家
        UILabel *shopL = [self returnLWithFrame:CGRectMake(15, sepV1.bottom + 8, 250, 13) font:13 superView:self.contentView];
        if (self.userDic) {
                    shopL.text = [NSString stringWithFormat:@"使用商家：%@",[self.userDic objectForKey:@"id"]];//0319
        }

        
        //使用时间
        UILabel *useTimeL = [self returnLWithFrame:CGRectMake(15, shopL.bottom + 10, 250, 13) font:13 superView:self.contentView];
        
        
        useTimeL.text = [NSString stringWithFormat:@"使用时间：%@",[BaseUtil becomeNormalWithString:[self.userDic objectForKey:@"create_time"]]];//0319
        
    }
    
}




#pragma mark - 公共方法 －
- (UILabel *)returnLWithFrame:(CGRect)frame
                         font:(CGFloat)font
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:@"444444"];
    [superView addSubview:label];
    return label;
    
}


- (NSString *)becomeNormalWithString:(NSString *)timeStr{
    NSTimeInterval time=[timeStr doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
