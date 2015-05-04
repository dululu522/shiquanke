//
//  CMCIntroductionTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-20.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCIntroductionTableViewCell.h"

@implementation CMCIntroductionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatIntroductionCellImage:(NSString *)image labelText:(NSString *)labelText
{
    UIImage *image1 = [UIImage imageNamed:image];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, image1.size.width, image1.size.height)];
    imageView.image = image1;
    [self.contentView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width +imageView.frame.origin.x +10, 0, self.contentView.frame.size.width - 50, self.contentView.frame.size.height)];
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:12.0];
    label.textColor = [UIColor colorWithHexString:@"696969"];
    [self.contentView addSubview:label];

}
- (void)creatIntroductionTitleText:(NSString *)titleText
{
    if (titleText) {
        NSInteger hight = 20;
//        NSInteger hight = [self heightForString:titleText fontSize:11 andWidth:self.contentView.frame.size.width - 50];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.contentView.frame.size.width - 50, hight)];
//        label.text = titleText;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:11.0];
        label.textColor = [UIColor colorWithHexString:@"696969"];
        [self.contentView addSubview:label];
    }
}
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

@end
