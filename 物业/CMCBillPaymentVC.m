//
//  CMCBillPaymentVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCBillPaymentVC.h"

@interface CMCBillPaymentVC ()

@end

@implementation CMCBillPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    UITextField *telTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 90, self.view.bounds.size.width - 100, 25)];
    telTextField.placeholder = @"请您输入户主手机号";
    telTextField.textColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:telTextField];
    
    UIImageView *telLogImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 95, 20, 20)];
    telLogImageView.image = [UIImage imageNamed:@"电话"];
    [self.view addSubview:telLogImageView];
    
    UIImageView *telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, self.view.bounds.size.width - 100, 5)];
//    telImageView.backgroundColor = [UIColor whiteColor];
    telImageView.image = [UIImage imageNamed:@"输入"];
    [self.view addSubview:telImageView];
    
    UITextField *codeTextFied = [[UITextField alloc] initWithFrame:CGRectMake(50,telImageView.frame.origin.y + telImageView.frame.size.height + 30 , self.view.bounds.size.width - 180, 25)];
//    codeTextFied.backgroundColor = [UIColor redColor];
    [self.view addSubview:codeTextFied];
    UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, codeTextFied.frame.origin.y + codeTextFied.frame.size.height +5, codeTextFied.frame.size.width, 5)];
    codeImageView.image = [UIImage imageNamed:@"输入"];
    [self.view addSubview:codeImageView];
    UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(codeTextFied.frame.size.width + codeTextFied.frame.origin.x +5, codeTextFied.frame.origin.y, 80, 35)];
    [codeButton setBackgroundImage:[UIImage imageNamed:@"代理费_03"] forState:UIControlStateNormal];
    codeButton.titleLabel.font = [UIFont fontWithName:nil size:14.0];
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(didClickCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeButton];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(telLogImageView.frame.origin.x, codeButton.frame.size.height + codeButton.frame.origin.y + 100, telImageView.frame.size.width, 40)];
    [okButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(didClickOkButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    
    
}
- (void)didClickOkButton:(UIButton *)button
{





}
- (void)didClickCodeButton:(UIButton *)button
{



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
