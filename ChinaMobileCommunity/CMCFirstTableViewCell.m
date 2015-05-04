//
//  CMCFirstTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFirstTableViewCell.h"

@implementation CMCFirstTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
    }
    return self;
}
- (void)createButton
{
    for (int i = 0; i < 2; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5 + i *( self.bounds.size.width / 2 - 10) + 5*i , 5, self.bounds.size.width / 2 - 8 , 66)];
        label1.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:label1];
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 60, 60)];
        imageView1.backgroundColor = [UIColor blueColor];
        [label1 addSubview:imageView1];
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.bounds.size.width +4 , 0, label1.bounds.size.width- imageView1.bounds.size.width, 30)];
        titleLabel.text = @"标题";
        titleLabel.font = [UIFont fontWithName:nil size:12.0];
        [label1 addSubview:titleLabel];
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.bounds.size.width +4, 33, label1.bounds.size.width- imageView1.bounds.size.width - 3, 30)];
        timeLabel.textAlignment = 2;
        timeLabel.text = @"时间";
        timeLabel.font = [UIFont fontWithName:nil size:12.0];
        [label1 addSubview:timeLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5 + i *( self.bounds.size.width / 2 - 10) + 5*i , 5, self.bounds.size.width / 2 - 10, 66)];
        [btn addTarget:self action:@selector(clickCellButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 +i;
        NSLog(@"%d",btn.tag);
        [self.contentView addSubview:btn];

    }

}
- (void)clickCellButton:(UIButton *)btn
{

    [self.delegate didClickButtonItems:btn.tag - 1000];



}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
