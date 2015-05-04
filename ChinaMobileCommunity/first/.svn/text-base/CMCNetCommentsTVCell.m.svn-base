//
//  CMCNetCommentsTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCNetCommentsTVCell.h"

@implementation CMCNetCommentsTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTableViewCellfoodDetail:(CMCFoodDetailEvaluation *)foodDetail
{
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50 )];
    [self.contentView addSubview:leftImageView];
    leftImageView.backgroundColor = [UIColor grayColor];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + leftImageView.frame.origin.x + 5, 20, 50, 20)];
//    nameLabel.backgroundColor = [UIColor orangeColor];
    nameLabel.text = foodDetail.user_name;
    nameLabel.font = [UIFont fontWithName:nil size:14.0];
    nameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.contentView addSubview:nameLabel];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.frame.size.width + nameLabel.frame.origin.x + 5 + 24 * i, nameLabel.frame.origin.y, 19, 20)];
        [self.contentView addSubview:startImageView];
        if (i <= foodDetail.evaluate_star.intValue-1) {
            startImageView.image = [UIImage imageNamed:@"detail_selectStar"];

        } else {
        
            startImageView.image = [UIImage imageNamed:@"detail_star"];

        }

    }
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 50, nameLabel.frame.origin.y, 45, 20)];
//    timeLabel.backgroundColor = [UIColor blueColor];
    timeLabel.text = foodDetail.evaluate_time;
    timeLabel.font = [UIFont fontWithName:nil size:14.0];
    timeLabel.textColor = [UIColor colorWithHexString:@"bebebe"];
    [self.contentView addSubview:timeLabel];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + leftImageView.frame.origin.x, leftImageView.frame.size.height +leftImageView.frame.origin.y, self.bounds.size.width - 5- leftImageView.frame.size.width - leftImageView.frame.origin.x, 30)];
    contentLabel.text = foodDetail.evaluate_content;
    contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:contentLabel];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, contentLabel.frame.size.height + contentLabel.frame.origin.y, self.bounds.size.width - 20, 0.5)];
    topImageView.image = [UIImage imageNamed:@"line"];
    [self.contentView addSubview:topImageView];
    //上传的图片
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, topImageView.frame.size.height + topImageView.frame.origin.y + 1, 50, 40)];
//    photoImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:photoImageView];


    UIImageView *buttomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, photoImageView.frame.size.height + photoImageView.frame.origin.y+ 1, self.bounds.size.width - 20, 0.5)];
    buttomImageView.image = [UIImage imageNamed:@"line"];
    [self.contentView addSubview:buttomImageView];
    
    UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, buttomImageView.frame.size.height + buttomImageView.frame.origin.y , self.bounds.size.width - 10, 20)];
    replyLabel.text = @"掌柜子回复:";
    replyLabel.textColor = [UIColor colorWithHexString:@"96d01a"];
//    replyLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:replyLabel];
    
    UILabel *replyContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, replyLabel.frame.size.height + replyLabel.frame.origin.y, self.bounds.size.width - 15-5, 30)];
    replyContentLabel.text = foodDetail.reply_content;
    replyContentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:replyContentLabel];


}
- (void)creatLabel:(NSString *)labelText image:(NSString *)imageName
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, self.bounds.size.height)];
    label.text = [NSString stringWithFormat:@" %@",labelText];
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 25, 16, 8, 11)];
    
    imageView.image = [UIImage imageNamed:imageName];
    [self.contentView addSubview:imageView];
    


}

@end
