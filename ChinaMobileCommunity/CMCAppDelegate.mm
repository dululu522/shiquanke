//
//  CMCAppDelegate.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAppDelegate.h"


#import "BMKMapManager.h"

#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "TCHomePageViewController.h"
#import "CMCLoginViewController.h"


#import "CMCActivityViewController.h"

#import "UMSocial.h"
//#import "MobClick.h"
#import "UMSocialYixinHandler.h"
#import "UMSocialFacebookHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialTwitterHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialInstagramHandler.h"
#import "UMSocialWhatsappHandler.h"
#import "UMSocialLineHandler.h"
#import "UMSocialTumblrHandler.h"
#import "CMCUserGuideViewController.h"
#import "CMCCityListViewController.h"
#import <AlipaySDK/AlipaySDK.h>



BMKMapManager* _mapManager;

@interface CMCAppDelegate ()
{
    BOOL isLocation;
}



@end

@implementation CMCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //检测更新
    [self onCheckVersion];
    
    //推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil]];
        //注册通知服务
        [[UIApplication sharedApplication]registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound|UIUserNotificationTypeAlert)];
    }
    // Override point for customization after application launch.
    
    //导航条设置
    [self nagivationSet];
    
    
    //是否进入引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        CMCUserGuideViewController *userGuideViewController = [[CMCUserGuideViewController alloc] init];
        self.window.rootViewController = userGuideViewController;
        
    } else {

        self.cnameArr = [[NSMutableArray alloc] init];
        self.idArr = [[NSMutableArray alloc] init];
        self.polyArr = [[NSMutableArray alloc] init];
        self.locationArr = [[NSMutableArray alloc] init];
        tabbarController = [[UITabBarController alloc] init];
        
        tabbarController.tabBar.selectedImageTintColor = kAPI_AllMainColor;
        _mapManager = [[BMKMapManager alloc]init];
//    IFQ4cChmQPUNtZreQePLKckc
        BOOL ret = [_mapManager start:@"hq0GOOieg4swoIys6dSpphUt" generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
            
        } else {
            [self baiduMap];
            
        }
    
    }
    
    //友盟分享
    [self umShareSet];
    
    return YES;
}

//百度地图
- (void)baiduMap
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView = [[BMKMapView alloc] init];
    _mapView.delegate = self;
    [self.window addSubview:_mapView];
    
    
}



#pragma mark - 百度地图定位代理方法 －
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    isLocation = YES;//开始定位
    [CMCUserManager shareManager].latitude = userLocation.location.coordinate.latitude;
    [CMCUserManager shareManager].longitude = userLocation.location.coordinate.longitude;
    [CMCUserManager shareManager].latLongStr = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] forKey:@"longitude"];
    
    

    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];
    //有坐标,有缓存的phone和password,用户登录;
    //有坐标,无缓存的phone和password,游客登录;
    
    //如果有账号和密码就用户登录，否则游客登录
    NSLog(@"passs == %@",k_password);
    if (k_password && k_phone) {
        NSLog(@"密码");
        [self callLoginInterface];
        
    }else {
        
       [self loadFirstGuestlogin:k_city_id];

    }

    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    geoCodeSearch.delegate = self;
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    
    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
    [geoCodeSearch reverseGeoCode:reverseGeoCodeOption];

}

- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    isLocation = NO;
    
    if (k_phone && k_password) {
        
        [self callLoginInterface];
        
    }else{
        
        [self loadFirstGuestlogin:k_city_id];
        
    }
    
    
    
    
}

#pragma mark - BMKGeoCodeSearchDelegate - 

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

    [CMCUserManager shareManager].currentAddress = result.address;
    [CMCUserManager shareManager].address = result.address;
    

    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
}




#pragma mark - 程序方法 －
//不能横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{

  return UIInterfaceOrientationMaskPortrait;

}
- (void)applicationWillResignActive:(UIApplication *)application
{

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    [UMSocialSnsService  applicationDidBecomeActive];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSLog(@"翼支付返回信息：%@", [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
//                                                    message:[[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//                                                   delegate:nil
//                                          cancelButtonTitle:NSLocalizedString(@"ok", nil)
//                                          otherButtonTitles:nil, nil];
//    [alert show];
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
        //必须添加，否则回调方法不走
        [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"resultDic === %@",resultDic);
            NSString *resultStatusStr = [resultDic objectForKey:@"memo"];
            [BaseUtil alertWithTitle:@"提示" msg:resultStatusStr];
            
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]) {
        NSLog(@"host");
        [[AlipaySDK defaultService]processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"resultDic ==== %@",resultDic);
        }];
        
    }
//    [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    return [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}


#pragma mark - 推送 － 

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    NSLog(@"useInfo ==== %@",userInfo);

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
     NSLog(@"deviceToken ==== %@",deviceToken);
    NSString *tokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    NSMutableString * tmpStr = [NSMutableString stringWithString:tokenStr];
    [tmpStr deleteCharactersInRange:NSMakeRange(0, 1)];
    [tmpStr deleteCharactersInRange:NSMakeRange(tmpStr.length - 1, 1)];
    [tmpStr replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, tmpStr.length)];
    
    [[NSUserDefaults standardUserDefaults] setValue:tmpStr forKey:@"deviceToken"];
    NSLog(@"Token======%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    //    NSLog(@"error : %@",error);
    
}


#pragma mark - 跳转到社区选择界面 － 

//跳转到社区选择页面
- (void)switchJumpCity
{
    CMCCityListViewController *cityListVC = [[CMCCityListViewController alloc] init];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    self.window.rootViewController = navigation;
//    CMCLoginViewController
    
}


#pragma mark - 用户登录- 

//用户登录
- (void)callLoginInterface
{
    NSLog(@"%@ %@",k_coordx,k_coordy);
    NSLog(@"%@ ",k_city_id);
    NSString *city_id;
    if (isLocation) {//如果有定位信息
        city_id = @"";
    }else {
        if (k_city_id) {
            city_id =k_city_id;
        }else{
            city_id =@"";
        }
    }
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *loginDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"phone":k_phone,@"password":[BaseUtil md5:k_password],@"sys":@"1",@"device":kAPI_Device,@"coord_x":k_coordx,@"coord_y":k_coordy,@"timestamp":timestamp,@"city_id":city_id};
    NSLog(@"LOGINDic == %@",loginDic);
    
    NSString *sig = [BaseUtil getSigWithArray:loginDic];
    NSString *requestStr = KAPI_NewUserLogin(k_coordx, k_coordy, k_phone, [BaseUtil md5:k_password], timestamp, [BaseUtil md5:sig], @"1", kAPI_Device, city_id);
    
    NSLog(@"requestStr %@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@" zhangyanqiu ======%@",respondObject);
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                [CMCUserManager shareManager].city = [dataDic objectForKey:@"city"];
                [CMCUserManager shareManager].city_id = [dataDic objectForKey:@"city_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[dataDic objectForKey:@"city_id"] forKey:@"city_id"];
                [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
                if ([[dataDic objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[dataDic objectForKey:@"order"] forKey:@"order"];
                }
                [CMCUserManager shareManager].loc_entry = [dataDic objectForKey:@"loc_entry"];
                [[NSUserDefaults standardUserDefaults] setValue:[dataDic objectForKey:@"loc_entry"] forKey:@"loc_entry"];
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
                }
                
                [CMCUserManager shareManager].token = [dataDic objectForKey:@"token"];
                if ([dataDic objectForKey:@"user"]) {
                    NSDictionary *userDic = [dataDic objectForKey:@"user"];
                    [CMCUserManager shareManager].phone = [userDic objectForKey:@"phone"];
                    [CMCUserManager shareManager].uid = [userDic objectForKey:@"uid"];
                }
                if ([CMCUserManager shareManager].loc_entry) {
//                    if (k_zid) {
                    //如果有loc_entry就进行第二次登录
                        [self loadSecondData];
                        
//                    } else {
//                        
//                        [self switchJumpCity];
//                        
//                    }
                    
                } else {
                    
                    // 如果没有loc_entry的话，就检查是否有缓存的坐标
//                    if (!Coordx && !Coordy) {
//                        
//                        
//                    }
                    
                    [self switchJumpCity];
                }
            } else {
                
                [BaseUtil toast:@"登录失败,请重试"];
            }
        } else if([[infoDic objectForKey:@"result"] intValue] == 2006){
            
//            [BaseUtil toast:@"密码错误,请重新登录"];
//            
//            //登录页面
//            CMCLoginViewController *cityListVC = [[CMCLoginViewController alloc] init];
//            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
//            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
//            self.window.rootViewController = navigation;
//            //            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
//            //            [self.window]
//            
//        }else if([[infoDic objectForKey:@"result"] intValue] == 7){
//            
//            //            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
//            //            loginVC.hidesBottomBarWhenPushed = YES;
//            CMCLoginViewController *cityListVC = [[CMCLoginViewController alloc] init];
//            //            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
//            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
//            self.window.rootViewController = navigation;
            
        }else{
            
            [BaseUtil toast:@"服务端数据错误,请重试"];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadSecondData
{
    NSString *timestamp = kAPI_timestamp;
    
    if ([CMCUserManager shareManager].loc_entry) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":@"",@"coord_x":k_coordx,@"coord_y":k_coordy,@"timestamp":timestamp};
        
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = KAPI_userLogin([CMCUserManager shareManager].token,@"", k_coordx, k_coordy,timestamp,[BaseUtil md5:sig]);
        NSLog(@"第二次URL ＝＝＝ %@",requestUrl);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            
        NSLog(@"第二次登录 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                if ([dataDic objectForKey:@"zone"]) {
                    NSDictionary *zoneDic = [dataDic objectForKey:@"zone"];
                    [[NSUserDefaults standardUserDefaults] setObject:[zoneDic objectForKey:@"zid"] forKey:@"zid"];
                    [CMCUserManager shareManager].city_id = [zoneDic objectForKey:@"city_id"];
                    [CMCUserManager shareManager].cid = [zoneDic objectForKey:@"cid"];
                    [CMCUserManager shareManager].address = [zoneDic objectForKey:@"address"];
                    [CMCUserManager shareManager].z_name = [zoneDic objectForKey:@"name"];
                    [self creatTabbar];
                } else {
                    
                    [self switchJumpCity];
                    
                }
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }else {
        
        [self switchJumpCity];
        
    }
    
    
    
}



#pragma mark - 访客登录 － 


//第一次访客登录
- (void)loadFirstGuestlogin:(NSString *)city_id
{
    NSString *time = kAPI_timestamp;
    NSString *logStr = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].longitude];
    NSString *latStr = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].latitude];
    NSDictionary *dic;
    //如果定位成功
    if (isLocation) {
        
        city_id = @"";
        
    }else{
        if (city_id) {
        
        }else{
            city_id = @"";
        }
        
        
    }
    
    dic = @{@"coord_x":logStr,@"coord_y":latStr,@"timestamp":time,@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"city_id":city_id};
    NSLog(@"dic === %@",dic);
    
    NSLog(@"city_id  === %@",k_city_id);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr =  KAPI_guestlogin(logStr, latStr, time, [BaseUtil md5:sig],city_id);
    NSLog(@"第一次访客登录requestStr %@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"第一次访客登录 respondObject ======%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [MBProgressHUD showHUDAddedTo:self.window animated:YES];
            
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                [CMCUserManager shareManager].city = [dataDic objectForKey:@"city"];
                [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
                [CMCUserManager shareManager].loc_entry = [dataDic objectForKey:@"loc_entry"];
                NSDictionary *paymentDic = [dataDic objectForKey:@"payment"];
                [CMCUserManager shareManager].alipay = [paymentDic objectForKey:@"alipay"];
                [CMCUserManager shareManager].bestpay = [paymentDic objectForKey:@"bestpay"];
                [CMCUserManager shareManager].city_id = [paymentDic objectForKey:@"city_id"];
                [[NSUserDefaults standardUserDefaults]setValue:[paymentDic objectForKey:@"city_id"] forKey:@"city_id"];
                NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
                //将服务项目缓存到本地
                NSArray *serviceArr = [dataDic objectForKey:@"service"];
                [userDefault setObject:serviceArr forKey:@"service"];
                NSArray *tradeArr = [dataDic objectForKey:@"trade"];
                [[NSUserDefaults standardUserDefaults] setObject:tradeArr forKey:@"trade"];
                //判断是否有loc_entry和城市,如有,则照常登录;如无,则切换城市页
                if ([CMCUserManager shareManager].loc_entry) {
                    [[NSUserDefaults standardUserDefaults] setValue:[dataDic objectForKey:@"loc_entry"] forKey:@"loc_entry"];
                    [self secondVisitorLoginCoord_x:logStr coord_y:latStr];
                }else {
                    //切换城市页
                    [self switchJumpCity];
                    [MBProgressHUD hideHUDForView:self.window animated:YES];
                    
                }
                
            } else {
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideHUDForView:self.window animated:YES];
            }
        } else {
            [BaseUtil toast:@"数据返回错误,请重试"];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


//第二次访客登录
- (void)secondVisitorLoginCoord_x:(NSString *)coord_x coord_y:(NSString *)coord_y
{
    NSString *time = kAPI_timestamp;
    NSDictionary *getDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"coord_x":coord_x,@"coord_y":coord_y,@"timestamp":time};
    NSString *sig = [BaseUtil getSigWithArray:getDic];
    NSString *requestStr = KAPI_userGuestlogin(coord_x, coord_y, time, [BaseUtil md5:sig]);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"第二次访客登录 :%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                if ([dataDic objectForKey:@"merchant"]) {
                    NSArray *merchantArr = [dataDic objectForKey:@"merchant"];
                    if (merchantArr.count) {
                        NSDictionary *tempDic = [merchantArr objectAtIndex:0];
                        [CMCUserManager shareManager].cid = [tempDic objectForKey:@"cid"];
                        [CMCUserManager shareManager].mid = [tempDic objectForKey:@"mid"];
                    }
                } else {
                    
                    [self switchJumpCity];
                    return ;
                }
                //社区
                if ([dataDic objectForKey:@"zone"]) {
                    NSDictionary *zoneDic= [dataDic objectForKey:@"zone"];
                    [CMCUserManager shareManager].z_name = [zoneDic objectForKey:@"name"];
                    [[NSUserDefaults standardUserDefaults] setObject:[zoneDic objectForKey:@"zid"] forKey:@"zid"];
                    
                }else {
                    
                    
                    [self switchJumpCity];
                    return;
                    
                }
                [self creatTabbar];
                
            } else {
                
                [self switchJumpCity];
                return ;
                
            }
            [MBProgressHUD hideHUDForView:self.window animated:YES];
            
            
        } else {
            [self switchJumpCity];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


#pragma mark - 友盟分享- 

- (void)umShareSet{
    //友盟appkey
    [UMSocialData setAppKey:@"54b79007fd98c58b73000ebd"];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    //    //设置易信Appkey和分享url地址
    [UMSocialYixinHandler setYixinAppKey:@"yx35664bdff4db42c2b7be1e29390c1a06" url:@"http://www.umeng.com/social"];
    //使用友盟统计
    //    [MobClick startWithAppkey:@"54b79007fd98c58b73000ebd"];
    
    ////    设置facebook应用ID，和分享纯文字用到的url地址
    [UMSocialFacebookHandler setFacebookAppID:@"91136964205" shareFacebookWithURL:@"http://www.umeng.com/social"];
    //
    ////    下面打开Instagram的开关
    [UMSocialInstagramHandler openInstagramWithScale:NO paddingColor:[UIColor blackColor]];
    //
    [UMSocialTwitterHandler openTwitter];
    
    //打开whatsapp
    [UMSocialWhatsappHandler openWhatsapp:UMSocialWhatsappMessageTypeImage];
    
    //打开Tumblr
    [UMSocialTumblrHandler openTumblr];
    
    //打开line
    [UMSocialLineHandler openLineShare:UMSocialLineMessageTypeImage];
    
    //qq
    [UMSocialQQHandler setQQWithAppId:@"1104064877" appKey:@"iyX2hovT0Wod9z9p" url:@"http://www.umeng.com/social"];
    
    
}


#pragma mark -创建视图 － 

//创建视图
- (void)creatTabbar
{
    //首页
    TCHomePageViewController *firstVC = [[TCHomePageViewController alloc] init];
    //物业
    CMCWuYeVC *wuyeVC = [[CMCWuYeVC alloc] init];
    //活动
    CMCActivityViewController *activityVC = [[CMCActivityViewController alloc] init];
    
    
    //我的
    CMCAccountViewController *accountVC
    = [[CMCAccountViewController alloc] init];
    
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:firstVC];
    UINavigationController *nv3  = [[UINavigationController alloc] initWithRootViewController:wuyeVC];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:accountVC];
    if ([kAPI_Property  isKindOfClass:[NSArray class]]) {
        if ([kAPI_Property count]) {
            NSLog(@"tabBar =**");
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv3,nv4, nil];
            
        } else {
            NSLog(@"tabBar ====");
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
            
        }
    } else {
        NSLog(@"tab====");
        tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
    }
    self.window.rootViewController = tabbarController;
    
}

#pragma mark - 导航条设置 －  
- (void)nagivationSet{
    
    //导航条设置
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"selectAddress"];
    //所有的导航条设置图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"backgroudColor"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"property"];
    
}



#pragma mark - 检测更新 － 

-(void)onCheckVersion

{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    //CFShow((__bridge CFTypeRef)(infoDic));
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    
    NSString *URL = @"http://itunes.apple.com/lookup?id=960929494";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:URL]];
    
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    if (results.length == 0) {
    } else {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *infoArray = [dic objectForKey:@"results"];
        
        if ([infoArray count]) {
            
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            
            
            if (![lastVersion isEqualToString:currentVersion]) {
                
                //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                
                alert.tag = 10000;
                
                [alert show];
                
            }
            
            else
                
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                alert.tag = 10001;
                
                [alert show];
                
            }
            
        }
        
        
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    if (alertView.tag==10000) {
        
        if (buttonIndex==1) {
            
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            
            [[UIApplication sharedApplication]openURL:url];
            
        }
        
    }else if(alertView.tag == 10001){
        
    }
    
}


#pragma mark - 没用的方法 － 
- (void)secondSubmittedData:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"location"] isKindOfClass:[NSArray class]]) {
        NSArray *locationArr = [dic objectForKey:@"location"];
        float number= 0;
        float distace = 0;
        if (locationArr.count) {
            NSDictionary *tempDic1 = [locationArr objectAtIndex:0];
            NSString *location = [tempDic1 objectForKey:@"location"];
            NSArray *arr = [location componentsSeparatedByString:@","];
            number = [BaseUtil distanceBetweenOrderBy:[[arr objectAtIndex:1] floatValue] :[[arr objectAtIndex:0] floatValue]];
            
            
            for (int i = 0; i < locationArr.count; i++) {
                NSDictionary *dic = [locationArr objectAtIndex:i];
                if ([dic objectForKey:@"location"]) {
                    NSString *location = [dic objectForKey:@"location"];
                    NSArray *arr = [location componentsSeparatedByString:@","];
                    distace = [BaseUtil distanceBetweenOrderBy:[[arr objectAtIndex:1] floatValue] :[[arr objectAtIndex:0] floatValue]];
                    
                }
                if ([dic objectForKey:@"x"]) {
                    distace = [BaseUtil distanceBetweenOrderBy:[[dic objectForKey:@"y"] floatValue] :[[dic objectForKey:@"x"] floatValue]];
                }
                if (distace < number) {
                    [CMCUserManager shareManager].login_id = [dic objectForKey:@"id"];
                    [CMCUserManager shareManager].location = [dic objectForKey:@"cname"];
                    [CMCUserManager shareManager].address = [dic objectForKey:@"address"];
                    number = distace;
                }
                
            }
            
        }
        [self creatTabbar];
        
    }else {
        [BaseUtil toast:@"暂时无相关的小区"];
    }
    
    
    
}







@end
