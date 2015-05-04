//
//  TCHomePageTableViewCell.m
//  TelecomCommunity
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "TCHomePageTableViewCell.h"

@implementation TCHomePageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatLabel:(NSArray *)labelTextArr imageStr:(NSArray *)imageUrlArr 
{
    NSInteger number = 0;
    if (labelTextArr.count %2 == 0) {
        number = labelTextArr.count /2;
    }else {
        number = labelTextArr.count/2+1;
    }
    if (number > 2) {
        number = 2;
    }
    
        for (NSInteger i = 0; i < number; i++) {
            for (NSInteger j = 0; j < 2; j++) {
                if (i*2+j > labelTextArr.count - 1) {
                    return;
                }
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 + 160*j, 0 + 72*i, 160 , 72)];
                [self.contentView addSubview:view];
                UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 9, 11, 64)];
                leftLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
                leftLabel.numberOfLines = 0;
                leftLabel.textColor = [UIColor colorWithHexString:@"515050"];
                leftLabel.text = [labelTextArr objectAtIndex:i*2+j];
                leftLabel.font = [UIFont systemFontOfSize:12.0];
                [view addSubview:leftLabel];
                NSURL *url = [BaseUtil systemRandomlyGenerated:[imageUrlArr objectAtIndex:i*2+j] type:@"11" number:@"3"];
        
        
                UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+leftLabel.frame.origin.x+3, 9, 122, 64)];
                [rightImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
                rightImageView.userInteractionEnabled = YES;
                [view addSubview:rightImageView];
                UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
                tapButton.frame = CGRectMake(0 + 160*j,0 + 72*i, 160 , 72);
                tapButton.tag = 6000+i*2 + j;
                tapButton.userInteractionEnabled = YES;
                [tapButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:tapButton];
                
            }
        }
    
}
- (void)creatLabel:(CMCHomePageMerchant *)merchant
{




}

- (void)didClickButton:(UIButton *)button
{
    [self.delegate didClickItems:button.tag - 6000];


}
- (void)tap:(UITapGestureRecognizer *)tap
{

    NSLog(@"%ld",(long)tap.view.superview.tag);




}
@end
