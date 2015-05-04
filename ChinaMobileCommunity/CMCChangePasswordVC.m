//
//  CMCChangePasswordVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCChangePasswordVC.h"

@interface CMCChangePasswordVC ()
{
    UITextField *_telTextField;
    UITextField *_codeTextFied;
    UITextField *_oldTf;
    UITextField *_newTF;
    UITextField *_againTF;
    NetWorkRequest *_request;

}

@end

@implementation CMCChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 10, 18)];
    
    phoneImage.image = [UIImage imageNamed:@"changePassword"];
    
    //电话
    UIImageView *telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 57, self.view.bounds.size.width - 20, 5)];
    //    telImageView.backgroundColor = [UIColor whiteColor];
    telImageView.image = [UIImage imageNamed:@"输入"];
    [self.view addSubview:telImageView];
//    //验证码
//    UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, telImageView.frame.size.height + telImageView.frame.origin.y + 43, 179, 5)];
//    //    telImageView.backgroundColor = [UIColor whiteColor];
//    codeImageView.image = [UIImage imageNamed:@"输入"];
//    [self.view addSubview:codeImageView];
    UIImageView *oldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, telImageView.frame.size.height + telImageView.frame.origin.y + 50, self.view.frame.size.width - 20, 5)];
    //    telImageView.backgroundColor = [UIColor whiteColor];
    oldImageView.image = [UIImage imageNamed:@"输入"];
    [self.view addSubview:oldImageView];
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, oldImageView.frame.size.height + oldImageView.frame.origin.y + 44, self.view.frame.size.width - 20, 5)];
    //    telImageView.backgroundColor = [UIColor whiteColor];
    newImageView.image = [UIImage imageNamed:@"输入"];
    [self.view addSubview:newImageView];
    UIImageView *againImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, newImageView.frame.size.height + newImageView.frame.origin.y + 44, self.view.frame.size.width - 20, 5)];
    //    telImageView.backgroundColor = [UIColor whiteColor];
    againImageView.image = [UIImage imageNamed:@"输入"];
    againImageView.userInteractionEnabled = YES;
    [self.view addSubview:againImageView];
    //电话输入
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width - 10, 25)];
    _telTextField.leftView = phoneImage;
    _telTextField.leftViewMode = UITextFieldViewModeAlways;
    
        _telTextField.placeholder = @" 输入手机号";
    _telTextField.delegate = self;
//        telTextField.backgroundColor = [UIColor orangeColor];
        _telTextField.textColor = [UIColor colorWithHexString:@"b3b3b3"];
        [self.view addSubview:_telTextField];

    //旧密码
        _oldTf = [[UITextField alloc] initWithFrame:CGRectMake(10, oldImageView.frame.size.height+oldImageView.frame.origin.y - 30, self.view.frame.size.width - 20, 20)];
    _oldTf.placeholder = @"旧密码";
    
    _oldTf.delegate = self;
    
        [self.view addSubview:_oldTf];
    //新密码
    _newTF = [[UITextField alloc] initWithFrame:CGRectMake(10, newImageView.frame.size.height+newImageView.frame.origin.y - 30, self.view.frame.size.width - 20, 20)];
    _newTF.delegate = self;
    _newTF.placeholder = @"新密码";
    [self.view addSubview:_newTF];
    
    //确认新密码
    //新密码
    _againTF = [[UITextField alloc] initWithFrame:CGRectMake(10, againImageView.frame.size.height+againImageView.frame.origin.y - 30, self.view.frame.size.width - 20, 20)];
    _againTF.delegate = self;
    
    _againTF.placeholder = @"再次输入新密码";
    [self.view addSubview:_againTF];
    

    
        UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(againImageView.frame.origin.x, againImageView.frame.size.height + againImageView.frame.origin.y + 45, againImageView.frame.size.width, 40)];
        [okButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(didClickOkButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okButton];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_telTextField resignFirstResponder];
    [_codeTextFied resignFirstResponder];
    [_newTF resignFirstResponder];
    [_oldTf resignFirstResponder];
    [_againTF resignFirstResponder];



    return YES;

}
- (void)didClickOkButton:(UIButton *)button
{

    if (![_newTF.text isEqualToString:_againTF.text]) {
        [BaseUtil toast:@"您的密码输入不一致"];
        return;
    }
    if (_telTextField.text.length&&_oldTf.text.length&&_newTF.text.length) {
        if ([CMCUserManager shareManager].token) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"password":[BaseUtil md5:_oldTf.text],@"newpass":[BaseUtil md5:_newTF.text],@"timestamp":kAPI_timestamp,@"app_ver":APPVersion};
            
            NSString *sig = [BaseUtil getSigWithArray:dic];
            NSString *requestStr = kAPI_getChangepass(kAPI_timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], [BaseUtil md5:_oldTf.text], [BaseUtil md5:_newTF.text]);
//            [_request loadDataWithURLString:requestStr];
            [BaseUtil get:requestStr success:^(id respondObject) {
                NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    [BaseUtil toast:@"修改密码成功"];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSError *error) {
                
            }];
        } else {
            
            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            
            
        }
        

    } else {
        [BaseUtil toast:@"修改信息不完整"];
    
    }

    
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
