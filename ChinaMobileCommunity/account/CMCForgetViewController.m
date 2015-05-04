//
//  CMCForgetViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCForgetViewController.h"

@interface CMCForgetViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField* telText;
@property (nonatomic, strong) UITextField* codeText;
@property (nonatomic, strong) UITextField* psdText;
@property (nonatomic, strong) UITextField* psdText2;

@property (nonatomic, copy) NSString* codeString;

@end

@implementation CMCForgetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{


    if (textField == self.codeText) {
        [self.codeText resignFirstResponder];
        [self.psdText becomeFirstResponder];
    }
    if (textField == self.psdText) {
        [self.psdText resignFirstResponder];
        [self.psdText2 becomeFirstResponder];
    }
    if (textField == self.psdText2) {
        [self.psdText2 resignFirstResponder];
        [self comfirm:nil];
    }
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找回密码";

    UIView* bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 67, self.view.bounds.size.width, self.view.bounds.size.height)];
    bgview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgview];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    self.telText = [[UITextField alloc]initWithFrame:CGRectMake(20, 16, 280, 35)];
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, 280, 35)];
    self.psdText = [[UITextField alloc]initWithFrame:CGRectMake(20, 106, 280, 35)];
    self.psdText2 = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, 280, 35)];
    

    
    self.telText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.psdText.keyboardType = UIKeyboardTypeASCIICapable;
    self.psdText2.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.codeText.returnKeyType = UIReturnKeyNext;
    self.psdText.returnKeyType = UIReturnKeyNext;
    self.psdText2.returnKeyType = UIReturnKeyNext;
    
    self.codeText.delegate = self;
    self.psdText.delegate = self;
    self.psdText2.delegate = self;
    
    self.telText.placeholder = @"请输入您的手机号";
    self.codeText.placeholder = @"请输入验证码";
    self.psdText.placeholder = @"请输入新密码";
    self.psdText2.placeholder = @"请再次输入新密码";
    
    self.telText.borderStyle = UITextBorderStyleRoundedRect;
    self.psdText.borderStyle = UITextBorderStyleRoundedRect;
    self.psdText2.borderStyle = UITextBorderStyleRoundedRect;
    self.codeText.borderStyle = UITextBorderStyleRoundedRect;
    self.psdText.secureTextEntry = YES;
    self.psdText2.secureTextEntry = YES;
    [bgview addSubview:self.telText];
    [bgview addSubview:self.codeText];
    [bgview addSubview:self.psdText];
    [bgview addSubview:self.psdText2];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 2, 105, 31);
    [button addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    self.telText.rightViewMode = UITextFieldViewModeAlways;
    self.telText.rightView = button;
    
    
    UIButton* zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuce.frame = CGRectMake(20, 216, 280, 40);
    zhuce.backgroundColor = kAPI_AllMainColor;
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuce setTitle:@"提交" forState:UIControlStateNormal];
    [zhuce addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
    zhuce.showsTouchWhenHighlighted = YES;
    [bgview addSubview:zhuce];
    zhuce.layer.masksToBounds = YES;
    zhuce.layer.cornerRadius = 6.f;

}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.telText resignFirstResponder];
    [self.codeText resignFirstResponder];
    [self.psdText resignFirstResponder];
    [self.psdText2 resignFirstResponder];

}
//提交
- (void)comfirm:(UIButton*)btn
{
//    NSLog(@"提交");
    
    if (![BaseUtil validateMobile:self.telText.text]) {
        [BaseUtil toast:@"请正确输入手机号"];
        return;
    }

    if (self.psdText.text.length == 0) {
        [BaseUtil toast:@"请正确输入新密码"];
        return;
    }
    if (self.psdText2.text.length == 0 ) {
        [BaseUtil toast:@"请正确输入确认新密码"];
        return;
    }
    if (![self.psdText.text isEqualToString:self.psdText2.text]) {
        [BaseUtil toast:@"两次输入的新密码不一致"];
        return;
    }
    [self.telText resignFirstResponder];
    [self.codeText resignFirstResponder];
    [self.psdText resignFirstResponder];
    [self.psdText2 resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"phone":self.telText.text,@"code":self.codeText.text,@"newpass":[BaseUtil md5:self.psdText.text],@"timestamp":timestamp,@"app_ver":APPVersion};
    NSString *sig= [BaseUtil getSigWithArray:dic];
    NSString *requestStr = KAPI_resetpassbycode(timestamp, self.telText.text, self.codeText.text, [BaseUtil md5:self.psdText.text],[BaseUtil md5:sig]);
[BaseUtil get:requestStr success:^(id respondObject) {
    NSDictionary *infoDic = [respondObject objectForKey:@"info"];
    
    //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
    [BaseUtil errorMesssage:respondObject];
    
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        [BaseUtil toast:@"提交成功"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
} failure:^(NSError *error) {
    
}];
    
}
//获取验证码
- (void)getCode:(UIButton*)button
{
    if (self.telText.text.length != 11) {
        [BaseUtil toast:@"请输入正确的手机号"];
        return;
    }
    if ([BaseUtil validateMobile:self.telText.text]) {
        button.enabled = NO;
        button.backgroundColor = [UIColor colorWithHexString:@"b6b6b6"];
        __block int timeout = 120;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    button.enabled = YES;
                    button.backgroundColor = kAPI_AllMainColor;
                    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                });
                
            }else{
                int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒后获取",minutes, seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [button setTitle:strTime forState:UIControlStateNormal];
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
        [self.telText resignFirstResponder];
        [self.codeText resignFirstResponder];
        [self.psdText resignFirstResponder];
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic= @{@"channel":KAPI_NewChannel,@"phone":self.telText.text,@"timestamp":timestamp,@"app_ver":APPVersion};
        
         NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestStr = KAPI_smsresetpass(timestamp, self.telText.text,[BaseUtil md5:sig]);
//        [_request loadDataWithURLString:requestStr];
        [BaseUtil get:requestStr success:^(id respondObject) {
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                [BaseUtil toast:@"获取验证码成功"];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        if (self.telText.text.length == 0) {
            [BaseUtil toast:@"请输入手机号"];
        }else{
            [BaseUtil toast:@"手机号格式错误"];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
