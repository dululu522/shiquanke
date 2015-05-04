//
//  CMCAccountTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAccountTableViewCell.h"

@implementation CMCAccountTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCellImage:(NSString *)imageName title:(NSString *)title
{
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    [self.contentView addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:titleLabel];
    
    UIImageView *buttomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 39, self.frame.size.width - 20, 1)];
    buttomImageView.backgroundColor = k_color(@"ededed");
    [backView addSubview:buttomImageView];
    
//    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(19, titleLabel.bottom + 2, self.frame.size.width - 38, 1)];
//    linView.backgroundColor = [UIColor lightGrayColor];
//    linView.backgroundColor = [UIColor colorWithHexString:<#(NSString *)#>]
//    [self.contentView addSubview:linView];
    
    
    
    
}

//我的预定中的cell
- (void)creatCellImage2:(NSString *)imageName2 title2:(NSString *)title2
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 23, 23)];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image =[UIImage imageNamed:imageName2];
    [self.contentView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 11, 15, 200, 13)];
    titleLabel.text = title2;
    titleLabel.textColor = [UIColor colorWithHexString:@"676767"];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titleLabel];
    
    
    
}

@end
