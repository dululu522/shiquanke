//
//  CMCOrderSucesssViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderSucesssViewController.h"
#import "CMCOrderTableVC.h"
#import "CMCConvenientLifeDetailVC.h"

@interface CMCOrderSucesssViewController ()

@end

@implementation CMCOrderSucesssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单成功";
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    //下单成功
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.view.bounds.size.width, 30)];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    orderLabel.backgroundColor = [UIColor whiteColor];
    [backView addSubview:orderLabel];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"详情请查看我的订单 !"];
    
    [str addAttribute:NSForegroundColorAttributeName value:kAPI_AllMainColor range:NSMakeRange(5,4)];
    
    orderLabel.text = [NSString stringWithFormat:@"下单成功!"];
    
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, orderLabel.bottom, self.view.bounds.size.width, 30)];
//    detailLabel.text = [NSString stringWithFormat:@"详情请查看我的订单!"];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.attributedText = str;
    [backView addSubview:detailLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width/2, orderLabel.bottom, 100, 30);
    
    [backView addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatBackButton];
    
//    UIImage *image = [UIImage imageNamed:@"icon_nonedata"];
    
//    UIImageView *orderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - image.size.width/2, detailLabel.bottom + 10, image.size.width, image.size.height)];
//    orderImageView.image = image;
//    [backView addSubview:orderImageView];
    
}


- (void)didClickBtn
{

    CMCOrderTableVC *orderVC = [[CMCOrderTableVC alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
    orderVC.hidesBottomBarWhenPushed = YES;


}


- (void)creatBackButton
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 100, 44);
    [backBtn setImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 0, 80)];
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

- (void)clickBtn:(UIButton *)sender{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[CMCConvenientLifeDetailVC class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
