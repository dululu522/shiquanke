//
//  CMCEvaluationTableViewCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCEvaluationTableViewCell.h"

@implementation CMCEvaluationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)creatLabelText:(NSString *)str number:(NSInteger)number
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width - 20, 30)];
    label.text = str;
//    label.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:label];
    for (int i = 0; i < 5; i++) {
        UIButton *starButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 200 + 22*i , label.frame.size.height + label.frame.origin.y+ 10, 18, 17)];
        starButton.tag = 1000+i;
        [starButton addTarget: self action:@selector(didClickStarButton:) forControlEvents:UIControlEventTouchUpInside];
        [starButton setBackgroundImage:[UIImage imageNamed:@"e_star"] forState:UIControlStateNormal];
//        [starButton setBackgroundImage:[UIImage imageNamed:@"select_star"] forState:UIControlStateNormal];
        [self.contentView addSubview:starButton];
    }
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, label.frame.size.height + label.frame.origin.y+ 10, 30, 17)];
    scoreLabel.text = @"5分";
    [self.contentView addSubview:scoreLabel];





}
- (void)didClickStarButton:(UIButton *)button
{
    if(button.tag - 1000 == 4){
    
    
    
    
    }
    
    
//    static int a = 0;
//    a++;
//
//    if (a%2!=0) {
//            [button setBackgroundImage:[UIImage imageNamed:@"select_star"] forState:UIControlStateNormal];
//
//        
//        
//    } else {
//    
//    [button setBackgroundImage:[UIImage imageNamed:@"e_star"] forState:UIControlStateNormal];
//    
//    }
//    NSLog(@"==== %d",button.tag);
    
//    [button setBackgroundImage:[UIImage imageNamed:@"e_starSelect"] forState:UIControlStateNormal];

//    [self.delegate didClickItems:button.tag - 1000];
}
- (void)creatLabel
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width -20, 200)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
//    view.backgroundColor = [UIColor lightGrayColor];
    UILabel *allEvaluationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
    allEvaluationLabel.text = @"所有评论:";
    [view addSubview:allEvaluationLabel];
    
    
    //物业服务
    UILabel *realtyServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, allEvaluationLabel.frame.size.height+allEvaluationLabel.frame.origin.y, 80, 30)];
    realtyServiceLabel.text = @"物业服务";
    [view addSubview:realtyServiceLabel];
    
    UIImageView *realtyServiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(realtyServiceLabel.frame.size.width + realtyServiceLabel.frame.origin.x, allEvaluationLabel.frame.size.height+allEvaluationLabel.frame.origin.y+5, view.frame.size.width - 105, 20)];
    realtyServiceImageView.image = [UIImage imageNamed:@"evaluation_black"];
    [view addSubview:realtyServiceImageView];
//    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(realtyServiceLabel.frame.size.width + realtyServiceLabel.frame.origin.x, allEvaluationLabel.frame.size.height+allEvaluationLabel.frame.origin.y, view.frame.size.width - 105, 50)];
//    [progressView setProgressViewStyle:UIProgressViewStyleBar];
//    progressView.progressImage = [UIImage imageNamed:@"evaluation_black"];
//    progressView.backgroundColor = [UIColor colorWithHexString:@"d7d7d7"];
//    [view addSubview:progressView];
    
    
    UILabel *publicServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, realtyServiceLabel.frame.size.height+realtyServiceLabel.frame.origin.y, 80, 30)];
    publicServiceLabel.text = @"公共维修";
    [view addSubview:publicServiceLabel];
    
    UIImageView *publicServiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(publicServiceLabel.frame.size.width + publicServiceLabel.frame.origin.x, realtyServiceLabel.frame.size.height+realtyServiceLabel.frame.origin.y+5, view.frame.size.width - 105, 20)];
    publicServiceImageView.image = [UIImage imageNamed:@"evaluation_black"];
    [view addSubview:publicServiceImageView];
    
    
    
    
    UILabel *publicEnvironmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, publicServiceLabel.frame.size.height + publicServiceLabel.frame.origin.y, 80, 30)];
    publicEnvironmentLabel.text = @"公共环境";
    [view addSubview:publicEnvironmentLabel];
    UIImageView *publicEnvironmentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(publicEnvironmentLabel.frame.size.width + publicEnvironmentLabel.frame.origin.x, publicServiceLabel.frame.size.height+publicServiceLabel.frame.origin.y+5, view.frame.size.width - 105, 20)];
    publicEnvironmentImageView.image = [UIImage imageNamed:@"evaluation_black"];
    [view addSubview:publicEnvironmentImageView];
    
    
    
    
    UILabel *securityServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, publicEnvironmentLabel.frame.size.height + publicEnvironmentLabel.frame.origin.y, 80, 30)];
    securityServiceLabel.text = @"保安服务";
    [view addSubview:securityServiceLabel];
    UIImageView *securityServiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(securityServiceLabel.frame.size.width + securityServiceLabel.frame.origin.x, publicEnvironmentLabel.frame.size.height+publicEnvironmentLabel.frame.origin.y+5, view.frame.size.width - 105, 20)];
    securityServiceImageView.image = [UIImage imageNamed:@"evaluation_black"];
    [view addSubview:securityServiceImageView];
    
    
    UILabel *safetyFacilitiesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, securityServiceLabel.frame.size.height + securityServiceLabel.frame.origin.y, 80, 30)];
    safetyFacilitiesLabel.text = @"安全设施";
    [view addSubview:safetyFacilitiesLabel];
    UIImageView *safetyFacilitiesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(safetyFacilitiesLabel.frame.size.width + safetyFacilitiesLabel.frame.origin.x, securityServiceLabel.frame.size.height+securityServiceLabel.frame.origin.y+5, view.frame.size.width - 105, 20)];
    safetyFacilitiesImageView.image = [UIImage imageNamed:@"evaluation_black"];
    [view addSubview:safetyFacilitiesImageView];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
