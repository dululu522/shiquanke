//
//  TCRegisterViewController.m
//  TelecomCommunity
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCRegisterViewController.h"
#import "NetWorkRequest.h"
#import "CMCXieYiViewController.h"
#import "TCHomePageViewController.h"
#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "CMCActivityViewController.h"
#import "CMCCityListViewController.h"

@interface CMCRegisterViewController ()<UITextFieldDelegate>
{
    NetWorkRequest *_request;
    NetWorkRequest *_regsmscodeRequest;
    
}
@property (nonatomic, strong) UITextField *telTextField;
@property (nonatomic, strong) UITextField *vCodeTextField; //验证码
@property (nonatomic, strong) UITextField *psdTextField; //密码
@property (nonatomic, strong) UITextField *confirmTextField; //确认密码
@property (nonatomic, copy) NSString *vCodeStr;
@property (nonatomic, strong) UIView *backView;
@end

@implementation CMCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backImageView.image = [UIImage imageNamed:@"AccountBackground"];
    [self.view addSubview:backImageView];
    _backView = [[UIView alloc] initWithFrame:self.view.frame];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTap)];
    [_backView addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview:_backView];
    UIImageView *telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 82, 28)];
    telImageView.image = [UIImage imageNamed:@"account_registerTel"];
    UIImageView *psdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 82, 28)];
    psdImageView.image = [UIImage imageNamed:@"account_registerPas"];
    UIImageView *confirmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 82, 28)];
    confirmImageView.image = [UIImage imageNamed:@"account_registerConfirm"];
    UIImageView *vCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 82, 28)];
    vCodeImageView.image = [UIImage imageNamed:@"account_registerVCode"];
    //手机号
    self.telTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 26, 280, 40)];
    self.telTextField.keyboardType  = UIKeyboardTypeNumberPad;
    self.telTextField.leftView = telImageView;
    self.telTextField.leftViewMode = UITextFieldViewModeAlways;
    //密码
    self.psdTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 76, 280, 40)];
    self.psdTextField.leftView = psdImageView;
    self.psdTextField.secureTextEntry = YES;
    self.psdTextField.leftViewMode = UITextFieldViewModeAlways;
    //确认密码
    self.confirmTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 126, 280, 40)];
    self.confirmTextField.leftView = confirmImageView;
    self.confirmTextField.leftViewMode = UITextFieldViewModeAlways;
    self.confirmTextField.secureTextEntry = YES;
    self.confirmTextField.backgroundColor = [UIColor whiteColor];
    self.confirmTextField.delegate = self;
    [_backView addSubview:self.confirmTextField];
    
    
    //验证码
    self.vCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 176, 167, 40)];
    self.telTextField.keyboardType  = UIKeyboardTypeNumberPad;

    self.vCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.vCodeTextField.leftView = vCodeImageView;
    
    
    //获取验证码
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.backgroundColor = kAPI_AllMainColor;
    button.frame = CGRectMake(self.vCodeTextField.frame.size.width + self.vCodeTextField.frame.origin.x+5, 176, 108, 40);
    [button addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    self.telTextField.rightViewMode = UITextFieldViewModeAlways;
    [_backView addSubview:button];
    //协议
    UIImageView *xieyiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.vCodeTextField.frame.size.height + self.vCodeTextField.frame.origin.y+15, 11,11)];
    xieyiImageView.image = [UIImage imageNamed:@"对号_13"];
    [_backView addSubview:xieyiImageView];
    UILabel *xieyiLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, self.vCodeTextField.frame.size.height+self.vCodeTextField.frame.origin.y, 95, 40)];
    xieyiLabel.font = [UIFont systemFontOfSize:12.0];
    xieyiLabel.text = @" 我已阅读并同意";
    [_backView addSubview:xieyiLabel];
    UIButton *xieyiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xieyiButton.frame = CGRectMake(xieyiLabel.frame.size.width+xieyiLabel.frame.origin.x, self.vCodeTextField.frame.size.height+self.vCodeTextField.frame.origin.y, 120, 40);
    [xieyiButton setTitleColor:kAPI_AllMainColor forState:UIControlStateNormal];
    [xieyiButton addTarget:self action:@selector(didClickXieyiBtn:) forControlEvents:UIControlEventTouchUpInside];
    xieyiButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [xieyiButton setTitle:@"<<十全客使用协议>>" forState:UIControlStateNormal];
    [_backView addSubview:xieyiButton];
    
    
    
    
    self.telTextField.backgroundColor = [UIColor whiteColor];
    self.telTextField.delegate = self;
    
    
    self.psdTextField.backgroundColor = [UIColor whiteColor];
    self.vCodeTextField.backgroundColor = [UIColor whiteColor];
    
    self.vCodeTextField.delegate = self;
    self.psdTextField.delegate = self;
    self.telTextField.delegate = self;
    [_backView addSubview:self.telTextField];
    [_backView addSubview:self.vCodeTextField];
    [_backView addSubview:self.psdTextField];
    
    [self creatZhuCeButton];
}
- (void)didClickTap
{

    [self.telTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    [self.vCodeTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];




}
//用户协议
- (void)didClickXieyiBtn:(UIButton *)button
{
    CMCXieYiViewController *xieyiVC = [[CMCXieYiViewController alloc] init];
    [self.navigationController pushViewController:xieyiVC animated:YES];
    
    
}
- (void)creatZhuCeButton
{
    UIButton* zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuce.frame = CGRectMake(30, 280, self.view.bounds.size.width - 60, 40);
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuce.backgroundColor = kAPI_AllMainColor;
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce addTarget:self action:@selector(willRegister:) forControlEvents:UIControlEventTouchUpInside];
    zhuce.userInteractionEnabled = YES;
    [_backView addSubview:zhuce];
    zhuce.layer.masksToBounds = YES;
    zhuce.layer.cornerRadius = 6.f;
    
    
}


#pragma mark -
#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.telTextField resignFirstResponder];
    [self.vCodeTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移n个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,50,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.frame.size.height+textField.frame.origin.y > self.view.bounds.size.height/2) {
        NSTimeInterval animationDuration= 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        //上移n个单位，按实际情况设置
        CGRect rect=CGRectMake(0.0f,-50,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
    }
    
    return YES;
    
    
}
- (void)willRegister:(UIButton *)button
{
    if (self.telTextField.text.length < 11 || self.telTextField.text.length > 11) {
        [BaseUtil toast:@"请输入正确的手机号"];
    }
    
    NSString *timestamp = kAPI_timestamp;
    NSString *device = kAPI_Device;
    
    NSLog(@"%@",[CMCUserManager shareManager].latLongStr);
    
    NSString *coord_x = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].longitude];
    NSString *coord_y = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].latitude];
    //
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"phone":self.telTextField.text,@"password":[BaseUtil md5:self.psdTextField.text],@"code":self.vCodeTextField.text,@"timestamp":timestamp,@"coord_x":coord_x,@"coord_y":coord_y,@"device":device,@"sys":@"1",@"app_ver":APPVersion};
    NSLog(@"注册 DIC =========%@",dic);
    NSString *sig =  [BaseUtil getSigWithArray:dic];
    NSLog(@"sig ======%@",sig);
    NSString *requestStr = KAPI_Register(coord_x, coord_y, self.telTextField.text, [BaseUtil md5:self.psdTextField.text], timestamp, [BaseUtil md5:sig], device, self.vCodeTextField.text);
    NSLog(@"requestStr =========%@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSLog(@"注册 test  %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic =[respondObject objectForKey:@"data"];
                [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
                if ([dataDic objectForKey:@"user"]) {
                    NSDictionary *userDic = [dataDic objectForKey:@"user"];
                    [[NSUserDefaults standardUserDefaults] setObject:[userDic objectForKey:@"phone"] forKey:@"phone"];
                    [CMCUserManager shareManager].uid = [userDic objectForKey:@"uid"];
                }
                [[NSUserDefaults standardUserDefaults] setObject:self.psdTextField.text forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] setObject:self.telTextField.text forKey:@"phone"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"注册成功"];

                [self callLoginInterface];
            }else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                [BaseUtil toast:@"暂无数据"];
                
            }
        }  else {
        
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"注册失败,请重试"];

        
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //    NSString *postStr = KAPI_Register(coord_x, coord_y, self.telTextField.text, self.psdTextField.text, str,[BaseUtil md5:sig], device, self.vCodeTextField.text);
    
    //    [_request loadDataWithURLString:postStr];
    
}
- (void)callLoginInterface
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *loginDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"phone":k_phone,@"password":[BaseUtil md5:k_password],@"sys":@"1",@"device":kAPI_Device,@"coord_x":k_coordx,@"coord_y":k_coordy,@"timestamp":timestamp,@"city_id":@""};
    //    NSLog(@"用户登录 loginDic==========%@",loginDic);
    NSString *sig = [BaseUtil getSigWithArray:loginDic];
    NSString *requestStr = KAPI_NewUserLogin(k_coordx, k_coordy, k_phone, [BaseUtil md5:k_password], timestamp, [BaseUtil md5:sig], @"1", kAPI_Device, @"");
    NSLog(@"requestStr %@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@" zhangyanqiu ======%@",respondObject);
        
        [BaseUtil errorMesssage:respondObject];
        
//        if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"2006"]) {
//            [BaseUtil toast:@"密码错误"];
//            return ;
//        }//0316
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                [CMCUserManager shareManager].city = [dataDic objectForKey:@"city"];
                [CMCUserManager shareManager].city_id = [dataDic objectForKey:@"city_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[dataDic objectForKey:@"city_id"] forKey:@"city_id"];
                [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
                
                [CMCUserManager shareManager].loc_entry = [dataDic objectForKey:@"loc_entry"];
                NSDictionary *paymentDic =[dataDic objectForKey:@"payment"];
                [CMCUserManager shareManager].alipay = [paymentDic objectForKey:@"alipay"];
                [CMCUserManager shareManager].bestpay = [paymentDic objectForKey:@"bestpay"];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                if ([dataDic objectForKey:@"service"]) {
                    //将服务项目缓存到本地
                    NSArray *serviceArr = [dataDic objectForKey:@"service"];
                    [userDefault setObject:serviceArr forKey:@"service"];
                    
                }
                //将物业地址缓存到本地
                if ([dataDic objectForKey:@"property"]) {
                    NSArray *propertyArr = [dataDic objectForKey:@"property"];
                    [userDefault setObject:propertyArr forKey:@"property"];
                    
                }
                if ([dataDic objectForKey:@"trade"]) {
                    NSArray *tradeArr = [dataDic objectForKey:@"trade"];
                    //缓存十大行业的id和名称
                    [[NSUserDefaults standardUserDefaults] setObject:tradeArr forKey:@"trade"];
                    NSLog(@"^^^^^^^^^^^ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"trade"]);
                }
                
                [CMCUserManager shareManager].token = [dataDic objectForKey:@"token"];
                if ([dataDic objectForKey:@"user"]) {
                    NSDictionary *userDic = [dataDic objectForKey:@"user"];
                    [CMCUserManager shareManager].phone = [userDic objectForKey:@"phone"];
                    [CMCUserManager shareManager].uid = [userDic objectForKey:@"uid"];
                }
                if ([CMCUserManager shareManager].loc_entry) {
                    [self loadSecondData];
                    
                } else {
                    [self switchJumpCity];
                }
            } else {
                
                [BaseUtil toast:@"登录失败,请重试"];
            }
        } else {
            
            [BaseUtil toast:@"服务端数据错误,请重试"];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
}
- (void)loadSecondData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"coord_x":k_coordx,@"coord_y":k_coordy,@"timestamp":timestamp};
    NSLog(@"第二次登录dic %@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = KAPI_userLogin([CMCUserManager shareManager].token, k_zid, k_coordx, k_coordy,timestamp,[BaseUtil md5:sig]);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"第二次登录 %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            if ([dataDic objectForKey:@"zone"]) {
                NSDictionary *zoneDic = [dataDic objectForKey:@"zone"];
                [[NSUserDefaults standardUserDefaults] setObject:[zoneDic objectForKey:@"zid"] forKey:@"zid"];
                [CMCUserManager shareManager].city_id = [zoneDic objectForKey:@"city_id"];
                [CMCUserManager shareManager].cid = [zoneDic objectForKey:@"cid"];
                [CMCUserManager shareManager].address = [zoneDic objectForKey:@"address"];
                [CMCUserManager shareManager].z_name = [zoneDic objectForKey:@"name"];
            } else {
                [self switchJumpCity];
            }
            
            
            [self creatTabbar];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
- (void)switchJumpCity
{
    CMCCityListViewController *cityListVC = [[CMCCityListViewController alloc] init];
    cityListVC.hidesBottomBarWhenPushed = YES;
    //    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
    //    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    //    self.window.rootViewController = navigation;
    
    [self.navigationController pushViewController:cityListVC animated:YES];
}
- (void)creatTabbar
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"selectAddress"];
    tabbarController = [[UITabBarController alloc] init];
    
    tabbarController.tabBar.selectedImageTintColor = kAPI_AllMainColor;
    

    
    //首页
    TCHomePageViewController *firstVC = [[TCHomePageViewController alloc] init];
    //物业
    CMCWuYeVC *wuyeVC = [[CMCWuYeVC alloc] init];
    //活动
    CMCActivityViewController *activityVC = [[CMCActivityViewController alloc] init];
    
    
    //    //我的
    CMCAccountViewController *accountVC
    = [[CMCAccountViewController alloc] init];
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:firstVC];
    UINavigationController *nv3  = [[UINavigationController alloc] initWithRootViewController:wuyeVC];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:accountVC];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"property"] count]) {
        tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv3,nv4, nil];
        self.view.window.rootViewController = tabbarController;
    } else {
    
        tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
        self.view.window.rootViewController = tabbarController;

    }

    
    
}

- (void)getCode:(UIButton *)button
{
    if (self.telTextField.text.length != 11) {
        [BaseUtil toast:@"请输入正确的手机号"];
        return;
    }
    if ([BaseUtil validateMobile:self.telTextField.text]) {
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
        NSString *timestamp = kAPI_timestamp;
        
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"phone":self.telTextField.text,@"timestamp":timestamp,@"app_ver":APPVersion};
        
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestStr = KAPI_Regsmscode(kAPI_timestamp, [BaseUtil md5:sig], self.telTextField.text);
        //        [_regsmscodeRequest loadDataWithURLString:requestStr];
        [BaseUtil get:requestStr success:^(id respondObject) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSLog(@"获取验证码成功 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                [BaseUtil toast:@"获取验证码成功"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }else if([[infoDic objectForKey:@"result"] intValue] == 2002){
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                [BaseUtil toast:@"该账号已注册"];
                
            } else {
            
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"获取验证码失败"];

            }
        } failure:^(NSError *error) {
            [BaseUtil toast:@"获取验证码失败"];

            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            
        }];
    } else {
        [BaseUtil toast:@"手机号无效"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
        
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
