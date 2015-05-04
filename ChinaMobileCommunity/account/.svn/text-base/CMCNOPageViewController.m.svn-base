//
//  CMCNOPageViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCNOPageViewController.h"

@interface CMCNOPageViewController ()

@end

@implementation CMCNOPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creat_NOOrder];
}
- (void)creat_NOOrder
{
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(33, 31, 85, 100)];
    imageView.image = [UIImage imageNamed:@"no_order"];
    [backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + 33+12, 66+ 43, 200, 30)];
    label.text = @"您暂时还没有订单哦";
    [backView addSubview:label];
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
