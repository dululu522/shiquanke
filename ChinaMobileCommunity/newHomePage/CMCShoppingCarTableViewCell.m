//
//  CMCShoppingCarTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShoppingCarTableViewCell.h"

@implementation CMCShoppingCarTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//点击减一
- (IBAction)didClickMinusButton:(UIButton *)sender {
    NSLog(@"===%@",self.numberLabel.text);
    self.selectCount = [self.numberLabel.text intValue];
    --self.selectCount;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",self.selectCount];
    [self.delegate didClickItems:[self.numberLabel.text intValue]];
    
    
    
    
}
//点击加一
- (IBAction)didClickAddButton:(UIButton *)sender {
    NSLog(@"==== %@",self.numberLabel.text);
    self.selectCount = [self.numberLabel.text intValue];
    ++self.selectCount;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",self.selectCount];

    [self.delegate didClickItems:[self.numberLabel.text intValue]];

    
    
    
}

@end
