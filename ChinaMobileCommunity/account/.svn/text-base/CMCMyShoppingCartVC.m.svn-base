//
//  CMCMyShoppingCartVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCMyShoppingCartVC.h"

@interface CMCMyShoppingCartVC ()

@end

@implementation CMCMyShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatBackButton
{
    
    //后退按钮
    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    [billButton setBackgroundImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [billButton addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
- (void)didClickBackBtn:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
