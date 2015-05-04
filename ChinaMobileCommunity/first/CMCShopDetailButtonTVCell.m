//
//  CMCShopDetailButtonTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailButtonTVCell.h"
#import "UIColor+ChangeColor.h"

@implementation CMCShopDetailButtonTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatButtonImageStr:(NSArray *)imageArr labelStr:(NSArray *)labelArr 
{
    
    for (int i = 0; i < 2; i ++) {
        for (int j = 0; j < 3; j++) {
            if (i*3+j == 5) {
                return;
            }
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10 +100*j, 0 +60*i, 100, 60)];
            [self.contentView addSubview:backView];
            UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
            buttonImageView.tag = 1000 + i*3+j;
            buttonImageView.userInteractionEnabled = YES;
            buttonImageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i*3+j]];
            [backView addSubview:buttonImageView];

            UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonImageView.frame.size.width + buttonImageView.frame.origin.x + 3, 15, 40, 30)];
            buttonLabel.textColor = [UIColor colorWithHexString:@"676767"];
            buttonLabel.text = [labelArr objectAtIndex:i *3+j];
            [backView addSubview:buttonLabel];
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = backView.bounds;
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000 + i*3+j;
                        [backView addSubview:button];
            
        }

    }
}
- (void)creatButtonImageStr:(NSArray *)imageArr labelStr:(NSArray *)labelArr unAbleNumberArr:(NSArray *)unAbleNumberArr unAbleImageArr:(NSArray *)unArray
{
    for (int i = 0; i < 2; i ++) {
        for (int j = 0; j < 3; j++) {
            if (i*3+j == 5) {
                return;
            }
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10 +100*j, 0 +60*i, 100, 60)];
            [self.contentView addSubview:backView];

            UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
            buttonImageView.tag = 1000 + i*3+j;
            buttonImageView.userInteractionEnabled = YES;
            [backView addSubview:buttonImageView];
            
            UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonImageView.frame.size.width + buttonImageView.frame.origin.x + 3, 15, 40, 30)];
            buttonLabel.textColor = [UIColor colorWithHexString:@"676767"];
            buttonLabel.text = [labelArr objectAtIndex:i *3+j];
            [backView addSubview:buttonLabel];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = backView.bounds;
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000 + i*3+j;
            [backView addSubview:button];
            if ([[unAbleNumberArr objectAtIndex:i*3+j] isEqualToString:@"0"]) {
                buttonImageView.image = [UIImage imageNamed:[unArray objectAtIndex:i*3+j]];
                button.userInteractionEnabled = NO;


            } else {
                [self notClickDianCan];
                [self notClickWaiMai];
                [self notClickMaiDan];
                [self notClickYouHui];
                [self notClickYuDing];
//                buttonImageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i*3+j]];

            
//                buttonImageView.image = [UIImage imageNamed:[unArray objectAtIndex:i*3+j]];
//                button.userInteractionEnabled = NO;
            }
            
        }
        
    }



}
 -(void)clickDianCan
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1000];
    imageView.image = [UIImage imageNamed:@"dianCan_select"];

}
- (void)notClickDianCan
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1000];
    imageView.image = [UIImage imageNamed:@"diancai"];

}
- (void)clickYuDing
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1001];
    imageView.image = [UIImage imageNamed:@"yuding_select"];
  

}
- (void)notClickYuDing
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1001];
    imageView.image = [UIImage imageNamed:@"yuding"];
//        imageView.image = [UIImage imageNamed:@"maidan_select"];

}
- (void)clickMaiDan
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1002];
    imageView.image = [UIImage imageNamed:@"maidan_select"];
    
}
- (void)notClickMaiDan
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1002];
    imageView.image = [UIImage imageNamed:@"maidan"];
}
- (void)clickWaiMai
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1003];
    imageView.image = [UIImage imageNamed:@"waimai_select"];
    
}
- (void)notClickWaiMai
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1003];
    imageView.image = [UIImage imageNamed:@"waimai"];
}
- (void)clickYouHui
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1004];
    imageView.image = [UIImage imageNamed:@"youhui_select"];
    
}
- (void)notClickYouHui
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1004];
    imageView.image = [UIImage imageNamed:@"youhui"];
}


- (void)didClickButton:(UIButton *)button

{
    NSLog(@"点击  ==== %d",self.clickImageArr.count);
    switch (button.tag) {
        case 1000:
        {
            [self clickDianCan];
            [self notClickMaiDan];
            [self notClickWaiMai];
            [self notClickYouHui];
            [self notClickYuDing];
        }
            break;
        case 1001:
        {
            [self notClickDianCan];
            [self notClickMaiDan];
            [self notClickWaiMai];
            [self notClickYouHui];
            [self clickYuDing];

        }
            
            break;
        case 1002:
        {
            [self notClickDianCan];
            [self clickMaiDan];
            [self notClickWaiMai];
            [self notClickYouHui];
            [self notClickYuDing];
;
        }
            
            break;
        case 1003:
        {
            [self notClickDianCan];
            [self notClickMaiDan];
            [self clickWaiMai];
            [self notClickYouHui];
            [self notClickYuDing];
        }
            
            break;
        case 1004:
        {
            [self notClickDianCan];
            [self notClickMaiDan];
            [self notClickWaiMai];
            [self clickYouHui];
            [self notClickYuDing];
        }
            
            break;
            
        default:
            break;
    }
    
    [self.delegate clickItems:button.tag -1000];

}

@end

//#import "CMCShopDetailIntroductionTVCell.h"


