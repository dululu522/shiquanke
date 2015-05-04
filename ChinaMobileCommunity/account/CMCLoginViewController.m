//
//  TCAccountViewController.m
//  TelecomCommunity
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCLoginViewController.h"
#import "UIColor+ChangeColor.h"
#import "CMCRegisterViewController.h"
#import "CMCForgetViewController.h"
#import "TCHomePageViewController.h"
#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "CMCActivityViewController.h"
#import "CMCCityListViewController.h"


@interface CMCLoginViewController ()<UITextFieldDelegate>
{
    NetWorkRequest *_request;
    
}
@property (nonatomic, strong) UITextField *telTextField;
@property (nonatomic, strong) UITextField *passTextField;
@end

@implementation CMCLoginViewController
//@synthesize tabbarController;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _locService.delegate = self;
//    [self baiduMap];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backImageView.image = [UIImage imageNamed:@"AccountBackground"];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];

    UIView *baseView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:baseView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 40, 100, 100)];
    //    imageView.backgroundColor= [UIColor orangeColor];
    imageView.image = [UIImage imageNamed:@"login_photo"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50;
    [self.view addSubview:imageView];
    //用户名
    //用户图片
    UIImageView *loginUserNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 40, 40)];
    loginUserNameImageView.image = [UIImage imageNamed:@"account_loginUserName"];
    loginUserNameImageView.contentMode = UIViewContentModeCenter;
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, imageView.frame.size.height + imageView.frame.origin.y + 20, baseView.bounds.size.width - 20, 40)];
    self.telTextField.backgroundColor = [UIColor whiteColor];
    self.telTextField.returnKeyType = UIReturnKeyNext;
    self.telTextField.returnKeyType = UIReturnKeyNext;
    self.telTextField.leftView = loginUserNameImageView;
    self.telTextField.leftViewMode = UITextFieldViewModeAlways;
    self.telTextField.delegate = self;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] != nil) {
        self.telTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    }
    
    [baseView addSubview:self.telTextField];
    
    
    //密码
    UIImageView *passImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    passImageView.contentMode = UIViewContentModeCenter;
    passImageView.image = [UIImage imageNamed:@"account_pass"];
    self.passTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.telTextField.frame.size.height + self.telTextField.frame.origin.y + 10, baseView.bounds.size.width - 20, 40)];
    self.passTextField.delegate = self;
    self.passTextField.secureTextEntry = YES;
    self.passTextField.leftView = passImageView;
    self.passTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passTextField.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:self.passTextField];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"] != nil) {
        self.passTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    
    
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10,self.passTextField.frame.size.height + self.passTextField.frame.origin.y + 10, 100, 25)];
    //    registerButton.contentMode = UIViewContentModeLeft;
    [registerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    //    registerButton.backgroundColor = [UIColor greenColor];
    [registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:nil size:12.0];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(clickregisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:registerButton];
    
    UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(baseView.bounds.size.width - 110,self.passTextField.frame.size.height + self.passTextField.frame.origin.y + 10, 100, 25)];
    forgetButton.contentMode = UIViewContentModeRight;
    [forgetButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    //    registerButton.backgroundColor = [UIColor greenColor];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont fontWithName:nil size:12.0];
    
    [forgetButton addTarget:self action:@selector(clickforgetButton:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:forgetButton];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(30, registerButton.frame.size.height +registerButton.frame.origin.y + 35, self.view.bounds.size.width - 60, 40)];
    loginButton.backgroundColor = kAPI_AllMainColor;
    //    loginButton.titleLabel.layer.cornerRadius = 5;
    loginButton.layer.cornerRadius = 5;
    [loginButton setTitle:@"用户登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:loginButton];
    [self creatBackButton];

    
}



- (void)creatBackButton
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 100, 44);
    [backBtn setImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 0, 80)];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
- (void)didClickBackBtn:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTabbar
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"selectAddress"];

    tabbarController = [[UITabBarController alloc] init];
//    tabbarController = (UITabBarController *)self.view.window.rootViewController;
    
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
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:wuyeVC];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:accountVC];
    if ([kAPI_Property isKindOfClass:[NSArray class]]) {
        if ([kAPI_Property count]) {
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv3,nv4, nil];

        } else {
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
        }

    } else {
        tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
    }
    
    self.view.window.rootViewController = tabbarController;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.telTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移n个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,80,width,height);
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.frame.size.height+textField.frame.origin.y > self.view.bounds.size.height/2 - 30) {
        NSTimeInterval animationDuration= 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        //上移n个单位，按实际情况设置
        CGRect rect=CGRectMake(0.0f,-80,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
    }
    
    return YES;
    
    
}
- (void)clickLoginButton:(UIButton *)button
{
    if (![BaseUtil validateMobile:self.telTextField.text]) {
        [BaseUtil toast:@"请输入正确的手机号"];
        return;
        
    }
    if (self.passTextField.text.length == 0) {
        [BaseUtil toast:@"请输入密码"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        if (k_zid) {//这一点
            [self callLoginInterface];
            
        } else {
            [self switchJumpCity];
        
        }
    
    [self.telTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    
}


- (void)callLoginInterface
{
    NSString *log;
    NSString *lat;
    if ([CMCUserManager shareManager].longitude) {
        log = k_coordx;
        lat = k_coordy;
        
    }else{
        log = @"0.0";
        lat = @"0.0";
    }
    NSString *timestamp = kAPI_timestamp;
        NSDictionary *loginDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"phone":self.telTextField.text,@"password":[BaseUtil md5:self.passTextField.text],@"sys":@"1",@"device":kAPI_Device,@"coord_x":log,@"coord_y":lat,@"timestamp":timestamp};
    NSLog(@"%@",loginDic);
        NSString *sig = [BaseUtil getSigWithArray:loginDic];
    NSLog(@"%@",sig);
        NSString *requestStr = KAPI_Login(log, lat, self.telTextField.text, [BaseUtil md5:self.passTextField.text], timestamp, [BaseUtil md5:sig], @"1", kAPI_Device);
    NSLog(@"requestStr ===========%@",requestStr);
        [BaseUtil get:requestStr success:^(id respondObject) {
            NSLog(@"第一次登陆 respondObject ======%@",respondObject);

            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSDictionary *dataDic = [respondObject objectForKey:@"data"];
//                    [CMCUserManager shareManager].city = [dataDic objectForKey:@"city"];
//                    [CMCUserManager shareManager].city_id = [dataDic objectForKey:@"city_id"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[dataDic objectForKey:@"city_id"] forKey:@"city_id"];
                    [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
//                    [CMCUserManager shareManager].loc_entry = [dataDic objectForKey:@"loc_entry"];
                    NSDictionary *paymentDic =[dataDic objectForKey:@"payment"];
                    [CMCUserManager shareManager].alipay = [paymentDic objectForKey:@"alipay"];
                    [CMCUserManager shareManager].bestpay = [paymentDic objectForKey:@"bestpay"];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:self.passTextField.text forKey:@"password"];
                    [userDefault setObject:self.telTextField.text forKey:@"phone"];
                    [CMCUserManager shareManager].phone = self.telTextField.text;
                    [CMCUserManager shareManager].password = self.passTextField.text;
                    if ([[dataDic objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
                        //将订单状态缓存到本地
                        NSDictionary *orderDic = [dataDic objectForKey:@"order"];
                        [[NSUserDefaults standardUserDefaults] setObject:orderDic forKey:@"order"];
                    }
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
                        [userDefault setObject:tradeArr forKey:@"trade"];
                    }
//                    [CMCUserManager shareManager].uid = [dataDic objectForKey:@"uid"];
                    [CMCUserManager shareManager].token = [dataDic objectForKey:@"token"];
                    if ([dataDic objectForKey:@"user"]) {
                        NSDictionary *userDic = [dataDic objectForKey:@"user"];
//                        [CMCUserManager shareManager].phone = [userDic objectForKey:@"phone"];
                        [[NSUserDefaults standardUserDefaults] setObject:[userDic objectForKey:@"phone"] forKey:@"phone"];
                        [CMCUserManager shareManager].uid = [userDic objectForKey:@"uid"];
                    }
                    //判断loc_entry是否存在,不存在跳转到城市页面
                    NSLog(@"-----locentry %@",[CMCUserManager shareManager].loc_entry);
                    if ([CMCUserManager shareManager].loc_entry) {
                        
                        [self loadSecondData];
                        
                    } else {
                    
                        [self switchJumpCity];
                    }
                } else {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                    [BaseUtil toast:@"登录失败,请重试"];
                }
            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"服务端数据错误,请重试"];
            }
        } failure:^(NSError *error) {
            
        }];
}
//切换到城市页面
- (void)switchJumpCity
{
    CMCCityListViewController *cityListVC = [[CMCCityListViewController alloc] init];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    self.view.window.rootViewController = navigation;
    
}
- (void)loadSecondData
{
    NSString *timestamp = kAPI_timestamp;
    NSLog(@"%@  %@ %@ %@",k_zid,k_coordx,k_coordy,[CMCUserManager shareManager].token);
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"coord_x":k_coordx,@"coord_y":k_coordy,@"timestamp":timestamp};
    NSLog(@"第二次登录dic %@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = KAPI_userLogin([CMCUserManager shareManager].token, k_zid, k_coordx, k_coordy,timestamp,[BaseUtil md5:sig]);
    NSLog(@"k_zid ========%@",k_zid);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"第二次登录 %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            NSDictionary *zoneDic = [dataDic objectForKey:@"zone"];
            [[NSUserDefaults standardUserDefaults] setObject:[zoneDic objectForKey:@"zid"] forKey:@"zid"];
//            [CMCUserManager shareManager].zid = [zoneDic objectForKey:@"zid"];
            [CMCUserManager shareManager].city_id = [zoneDic objectForKey:@"city_id"];
            [CMCUserManager shareManager].cid = [zoneDic objectForKey:@"cid"];
            [CMCUserManager shareManager].address = [zoneDic objectForKey:@"address"];
            [CMCUserManager shareManager].z_name = [zoneDic objectForKey:@"name"];
            [self creatTabbar];
//            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self switchJumpCity];
        }
        
    } failure:^(NSError *error) {
        
    }];



}
//注册
- (void)clickregisterButton:(UIButton *)button
{
    
    CMCRegisterViewController *registerVC = [[CMCRegisterViewController alloc] init];
    registerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (void)clickforgetButton:(UIButton *)button
{
    CMCForgetViewController *forgetVC = [[CMCForgetViewController alloc] init];
    forgetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
    
    
    
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