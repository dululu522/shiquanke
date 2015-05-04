//
//  CMCPacketCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPacketCell.h"

@interface CMCPacketCell ()
{
    UILabel *nameL;
    UIImageView *warningImgV;
    //物品图片
    UIImageView *imgV;
    //价格
    UILabel *priceL;
    //时间
    UILabel *timeL;
}


@end


@implementation CMCPacketCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //底部
        UIImageView *bttImgV = [[UIImageView alloc]init];
        bttImgV.frame = CGRectMake(10, 10, self.width - 20, 100);
        bttImgV.image = [UIImage imageNamed:@"可使用_1"];
//        bttImgV.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:bttImgV];
        
        //名字
        nameL = [self returnLWithFrame:CGRectMake(11, 9, 220, 15) font:15 textColor:[UIColor whiteColor] superView:bttImgV];
        nameL.text = @"苹果园一区";
        
        //是否使用过
        warningImgV = [[UIImageView alloc]init];
        warningImgV.frame = CGRectMake(bttImgV.width - 43, 0, 43, 43);
        warningImgV.image = [UIImage imageNamed:@"可使用"];
        [bttImgV addSubview:warningImgV];
        
        //物品图片
        imgV = [[UIImageView alloc]init];
        imgV.frame = CGRectMake(11, nameL.bottom + 17, 44, 44);
        imgV.backgroundColor = [UIColor redColor];
        imgV.layer.cornerRadius = 22;
        imgV.clipsToBounds = YES;
        [bttImgV addSubview:imgV];
        
        
        //价格
        priceL = [self returnLWithFrame:CGRectMake(imgV.right + 12, nameL.bottom + 30, 200, 15) font:15 textColor:[UIColor whiteColor] superView:bttImgV];
        priceL.text = @"¥11.40";
        
        //有效期
        
        UIImageView *timeImgV = [[UIImageView alloc]init];
        timeImgV.frame = CGRectMake(130, priceL.bottom + 10, 15, 15);
        timeImgV.image = [UIImage imageNamed:@"有效期_1"];
        [bttImgV addSubview:timeImgV];
        
        //时间
        timeL = [self returnLWithFrame:CGRectMake(timeImgV.right + 12, timeImgV.top, bttImgV.width - timeImgV.right - 12, 13) font:13 textColor:[UIColor blackColor] superView:bttImgV];
        timeL.text = [NSString stringWithFormat:@"有效期至：%@",@"2014-08-20"];
        
        
    }
    
    return self;
}

- (void)setPacket:(CMCPacket *)packet
{
    if (_packet != packet) {
        _packet = packet;
    }

        nameL.text = packet.zone_name;
        priceL.text = [NSString stringWithFormat:@"￥%@",packet.money];
    
    //0318
    NSTimeInterval time=[packet.expire_time doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *expire_time = [dateFormatter stringFromDate: detaildate];
    
    timeL.text = [NSString stringWithFormat:@"有效期至：%@",expire_time];
    NSURL *url = [BaseUtil systemRandomlyGenerated:packet.logo type:@"10" number:@"1"];
    [imgV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    switch ([packet.state intValue]) {
        case 0:
            warningImgV.image = [UIImage imageNamed:@"可使用"];
            break;
        case 1:
            warningImgV.image = [UIImage imageNamed:@"已使用"];

            break;
        case 2:
            warningImgV.image = [UIImage imageNamed:@"已过期"];

            break;
            
        default:
            break;
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
    [superView addSubview:label];
    return label;
    
}


- (void)awakeFromNib {
    // Initialization code
    NSLog(@"initialization");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
