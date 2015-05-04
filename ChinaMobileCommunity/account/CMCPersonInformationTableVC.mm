//
//  CMCPersonInformationTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//


#define currentMonth [currentMonthString integerValue]
#define HeadImgName @"head.png"

#import "CMCPersonInformationTableVC.h"
#import "CMCBirthdayVC.h"
#import "CMCSignViewController.h"
#import "MAddressViewController.h"
#import "CMCNickNameVC.h"
#import "CMCAcconutInfo.h"
#import "CMCPersonalInformation.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "GTMBase64.h"
#import "CMCChangePasswordVC.h"

#import "CMCPropertyAddressTableVC.h"
#import "CMCAboutUsTVC.h"
#import "CMCChangePasswordVC.h"
#import "CMCAppDelegate.h"

#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "TCHomePageViewController.h"
#import "CMCActivityViewController.h"
#import "CMCCityListViewController.h"



@interface CMCPersonInformationTableVC ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *yearArray;
    
    NSString *currentMonthString;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    BOOL firstTimeLoad;
    
    NSString *_birthdayStr; //
    NSString *_dStr;
    NSString *_genderStr;
    NSString *_mStr;
    NSString *_nicknameStr;
    NSString *_personaltextStr;
    NSString *_yStr;
    
    
    
}
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) NSArray *additionArr;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UIToolbar *toolbarCancelDone;
@property (nonatomic, strong) UIPickerView *customPicker;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, retain) UIImage *imagePicture;
@property (nonatomic, retain)  UIImagePickerController *imagePicker;



@property (nonatomic, strong) NSMutableArray *allArray;
@end

@implementation CMCPersonInformationTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"我的设置";
    }
    
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.detailArr = [[NSArray alloc] initWithObjects:@"昵称",@"性别",@"出生日期", nil];
    self.additionArr = [[NSArray alloc] initWithObjects:@"个性签名",@"修改密码",@"检测更新",nil];//0319
    self.allArray = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)loadData
{
    
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic= @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = KAPI_getuserinfo(timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            CMCPersonalInformation *personInformation = [[CMCPersonalInformation alloc] initWithPersonalInformation:dataDic];
            if ([CMCUserManager shareManager].dateStr != nil) {
                _birthdayStr = [CMCUserManager shareManager].dateStr;
            } else {
                
                _birthdayStr = personInformation.birthday;
                
            }
            if ([personInformation.gender isEqualToString:@"S"]) {
                _genderStr = @"保密";
            }
            if ([personInformation.gender isEqualToString:@"M"]) {
                _genderStr = @"男";
            }
            if ([personInformation.gender isEqualToString:@"F"]) {
                _genderStr = @"女";
            }
            //            _genderStr = personInformation.gender;
            
            _personaltextStr = personInformation.intro;
            [CMCUserManager shareManager].individualitySignature = personInformation.intro;
            _nicknameStr = personInformation.nickname;
            [CMCUserManager shareManager].nickname = personInformation.nickname;
            //
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView reloadData];
            
        } else {
            [BaseUtil toast:@"数据加载失败,请重新加载"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            return;
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.detailArr.count;
            break;
        case 2:
            return self.additionArr.count;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reUsed";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"头像";
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 10, 60, 60)];
        self.photoImageView.image = [UIImage imageNamed:@"log"];
        [cell.contentView addSubview:_photoImageView];
        [self loadPictureData];
        
        
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [self.detailArr objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            
            cell.detailTextLabel.text = _nicknameStr;
        }
        
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = _genderStr;
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text =  _birthdayStr;
        }
        
    }
    if (indexPath.section == 2) {
        
        cell.textLabel.text = [self.additionArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = _personaltextStr;
        }
        
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"退出登录";
    }
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"666666"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取", nil];
        alertView.tag = 1000;
        alertView.delegate = self;
        [alertView show];
        
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                
            case 0:
            {
                //昵称
                CMCNickNameVC *nameVC = [[CMCNickNameVC alloc] init];
                nameVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nameVC animated:YES];
                
                
            }
                break;
                
            case 1:
            {
                //性别
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女",@"保密", nil];
                alertView.tag = 1001;
                alertView.delegate = self;
                [alertView show];
                
            }
                break;
            case 2:
            {
                //生日
                CMCBirthdayVC *birthVC = [[CMCBirthdayVC alloc] init];
                birthVC.title = @"出生日期";
                birthVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:birthVC animated:YES];
            }
                break;
                
                
                
            default:
                break;
        }
        
        
        
        
    }
    
    if (indexPath.section == 2){
        if (indexPath.row == 0) {
            
            //个性签名
            CMCSignViewController *signVC = [[CMCSignViewController alloc] init];
            signVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:signVC animated:YES];
        }
        if (indexPath.row == 1) {
            //修改密码
            CMCChangePasswordVC *changePassVC = [[CMCChangePasswordVC alloc] init];
            changePassVC.hidesBottomBarWhenPushed = YES;
            changePassVC.title = @"修改密码";
            [self.navigationController pushViewController:changePassVC animated:YES];
        }
        
        //0319
        if (indexPath.row == 2) {
            //检测更新
            [self onCheckVersion];
            
        }
        
        
        
    }
    
    if (indexPath.section == 3) {
        [CMCUserManager shareManager].token = nil;
        [CMCUserManager shareManager].file_url = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"city_id"];
        if ([CMCUserManager shareManager].phone) {
            self.tableView.userInteractionEnabled = NO;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"propertyAddress"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"trade"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"property"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"service"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phone"];
            [self baiduMap];
        } else {
            [BaseUtil toast:@"你还没有登录"];
        }
        
    }
    
    
}
- (void)baiduMap
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView = [[BMKMapView alloc] init];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
}
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //    NSLog(@"heading is %@",userLocation.heading);
}
//
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [CMCUserManager shareManager].latitude = userLocation.location.coordinate.latitude;
    [CMCUserManager shareManager].longitude = userLocation.location.coordinate.longitude;
    
    [CMCUserManager shareManager].latLongStr = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    
    
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];
    
    [self loadFirstGuestlogin:k_city_id];
}
//第一次访客登录
- (void)loadFirstGuestlogin:(NSString *)city_id
{
    NSString *time = kAPI_timestamp;
    NSString *logStr = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].longitude];
    NSString *latStr = [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].latitude];
    NSDictionary *dic;
    if (city_id) {
        dic = @{@"coord_x":logStr,@"coord_y":latStr,@"timestamp":time,@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"city_id":city_id};
    } else {
        dic = @{@"coord_x":logStr,@"coord_y":latStr,@"timestamp":time,@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"city_id":@""};
        
    }
    
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr;
    if (city_id) {
        requestStr =  KAPI_guestlogin(logStr, latStr, time, [BaseUtil md5:sig],city_id);
    } else {
        requestStr =  KAPI_guestlogin(logStr, latStr, time, [BaseUtil md5:sig],@"");
        
    }
    //    NSString *requestStr =  KAPI_guestlogin(logStr, latStr, time, [BaseUtil md5:sig],city_id);
    [BaseUtil get:requestStr success:^(id respondObject) {
        //        NSLog(@"第一次访客登录requestStr %@",requestStr);
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
       // [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                [CMCUserManager shareManager].city = [dataDic objectForKey:@"city"];
                [CMCUserManager shareManager].file_url = [dataDic objectForKey:@"file_url"];
                [CMCUserManager shareManager].loc_entry = [dataDic objectForKey:@"loc_entry"];
                NSDictionary *paymentDic = [dataDic objectForKey:@"payment"];
                [CMCUserManager shareManager].alipay = [paymentDic objectForKey:@"alipay"];
                [CMCUserManager shareManager].bestpay = [paymentDic objectForKey:@"bestpay"];
                [CMCUserManager shareManager].city_id = [paymentDic objectForKey:@"city_id"];
                NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
                //将服务项目缓存到本地
                NSArray *serviceArr = [dataDic objectForKey:@"service"];
                [userDefault setObject:serviceArr forKey:@"service"];
                NSArray *tradeArr = [dataDic objectForKey:@"trade"];
                [[NSUserDefaults standardUserDefaults] setObject:tradeArr forKey:@"trade"];
                //判断是否有loc_entry和城市,如有,则照常登录;如无,则切换城市页
                if ([CMCUserManager shareManager].city && [CMCUserManager shareManager].loc_entry) {
                    [self secondVisitorLoginCoord_x:logStr coord_y:latStr];
                }else {
                    //切换城市页
                    [self switchJumpCity];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                }
                
            } else {
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        } else {
            [BaseUtil toast:@"数据返回错误,请重试"];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
- (void)switchJumpCity
{
    CMCCityListViewController *cityListVC = [[CMCCityListViewController alloc] init];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NOLoc_entry"];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    self.view.window.rootViewController = navigation;
    
    
}
//第二次访客登录
- (void)secondVisitorLoginCoord_x:(NSString *)coord_x coord_y:(NSString *)coord_y
{
    NSString *time = kAPI_timestamp;
    NSDictionary *getDic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"coord_x":coord_x,@"coord_y":coord_y,@"timestamp":time};
    NSString *sig = [BaseUtil getSigWithArray:getDic];
    NSString *requestStr = KAPI_userGuestlogin(coord_x, coord_y, time, [BaseUtil md5:sig]);
    [BaseUtil get:requestStr success:^(id respondObject) {
        //        NSLog(@"第二次访客登录requestStr :%@",requestStr);
        
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
                        //                        [CMCUserManager shareManager].zid = [tempDic objectForKey:@"zid"];
                    }
                }
                //社区
                if ([dataDic objectForKey:@"zone"]) {
                    NSDictionary *zoneDic= [dataDic objectForKey:@"zone"];
                    [CMCUserManager shareManager].z_name = [zoneDic objectForKey:@"name"];
                    //                    [CMCUserManager shareManager].zid = [zoneDic objectForKey:@"zid"];
                    [[NSUserDefaults standardUserDefaults] setObject:[zoneDic objectForKey:@"zid"] forKey:@"zid"];
                    
                } else {
                    
                    [self switchJumpCity];
                }
                
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [BaseUtil toast:@"登录成功"];
            [self creatTabbar];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
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
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *nv3  = [[UINavigationController alloc] initWithRootViewController:wuyeVC];

    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:accountVC];
    NSLog(@"kAPI_Property %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"property"]);
    if ([kAPI_Property isKindOfClass:[NSArray class]]) {
        if ([kAPI_Property count]) {
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv3,nv4, nil];
            
        }else {
            tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
        }
        
    } else {
        tabbarController.viewControllers = [NSArray arrayWithObjects:nv1,nv2,nv4, nil];
    }
    self.view.window.rootViewController = tabbarController;
    
    
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    [CMCUserManager shareManager].address = result.address;
    
    
    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)clearDemo
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%d",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
    
    
    
}
-(void)clearCacheSuccess
{
    [BaseUtil toast:@"清理成功"];
    NSLog(@"清理成功");
}

#pragma mark-
#pragma mark- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        switch (buttonIndex) {
            case 1:
            {
                NSLog(@"拍照");
                //拍照
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
                    imagePickerC.sourceType = sourceType;
                    imagePickerC.delegate = self;
                    imagePickerC.allowsEditing = YES;
                    [self presentViewController:imagePickerC animated:YES completion:nil];
                }
                else
                {
                    [BaseUtil toast:@"您的手机没有照相机"];
                }
            }
                break;
            case 2:
            {
                NSLog(@"本地照片");
                //打开本地相册
                UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
                imagePickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                imagePickerC.delegate = self;
                imagePickerC.allowsEditing = YES;
                [self presentViewController:imagePickerC animated:YES completion:nil];
                
            }
                break;
                
            default:
                break;
        }
    }
    if (alertView.tag == 1001) {
        switch (buttonIndex) {
            case 1:
            {
                self.titleStr = @"男";
                NSLog(@"aaaaaaa");
                NSString *requestUrl = [BaseUtil getRequestUrlByType:@"gender" AndValue:@"M"];
                NSLog(@"requestUrl ==%@",requestUrl);
                [BaseUtil get:requestUrl success:^(id respondObject) {
                    NSLog(@"性别: %@",respondObject);
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                        if ([respondObject objectForKey:@"data"]) {
                            [BaseUtil toast:@"修改成功"];
                            
                            [self loadData];
                            
                        } else {
                            [BaseUtil toast:@"修改失败,请重试"];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        }
                    } else {
                        [BaseUtil toast:@"服务器数据返回错误"];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    }
                    
                } failure:^(NSError *error) {
                    
                    
                }];
            }
                break;
            case 2:
            {
                self.titleStr = @"女";
                NSString *requestUrl = [BaseUtil getRequestUrlByType:@"gender" AndValue:@"F"];
                [BaseUtil get:requestUrl success:^(id respondObject) {
                    NSLog(@"性别: %@",respondObject);
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                        if ([respondObject objectForKey:@"data"]) {
                            [BaseUtil toast:@"修改成功"];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self loadData];
                            
                        } else {
                            [BaseUtil toast:@"修改失败,请重试"];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                        }
                    } else {
                        [BaseUtil toast:@"服务器数据返回错误"];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
                
            }
                break;
            case 3:
            {
                self.titleStr = @"保密";
                NSString *requestUrl = [BaseUtil getRequestUrlByType:@"gender" AndValue:@"S"];
                [BaseUtil get:requestUrl success:^(id respondObject) {
                    NSLog(@"性别: %@",respondObject);
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                        if ([respondObject objectForKey:@"data"]) {
                            [BaseUtil toast:@"修改成功"];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self loadData];
                            
                        } else {
                            [BaseUtil toast:@"修改失败,请重试"];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                        }
                    } else {
                        [BaseUtil toast:@"服务器数据返回错误"];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
                
                
                
            }
                break;
                
                
            default:
                break;
        }
        
    }
    
    if (alertView.tag==10000) {
        
        if (buttonIndex==1) {
            
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            
            [[UIApplication sharedApplication]openURL:url];
            
        }
        
    }else if(alertView.tag == 10001){
        
    }
    
    
}









#pragma mark -
//#pragma mark - UIImagePickerControllerDelegate
#pragma mark - UIPickerControllerDelegate -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage])
    {
        //先把图片转成NSData
        UIImage* image =  [self scaleToSize:[info objectForKey:@"UIImagePickerControllerOriginalImage"] size:CGSizeMake(60, 60)];
        
        [self performSelector:@selector(uploadUserHeadPicture:) withObject:image afterDelay:0.01];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)uploadUserHeadPicture:(UIImage *)image
{
    NSArray *dirPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString * docsDir = [dirPaths objectAtIndex:0];  //得到documen目录下
    
    NSData *imageData = UIImagePNGRepresentation(image); //将图片转化为png
    
    filePath = [NSString stringWithFormat:@"%@/%@",docsDir,HeadImgName];//图片文件完整的路径
    
    [imageData writeToFile:filePath atomically:YES];//将图片写入到文件中去
    
    [self UploadThePicture];
    
}

- (void)UploadThePicture
{
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);//UIImageJPEGRepresentation返回图片较小，但是清晰度模糊
    NSString *imgStr = [Base64Encoder encodeData:data];
    NSData *data1 = [HeadImgName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *timestamp = kAPI_timestamp;
    NSString *imageName = [Base64Encoder encodeData:data1];
    
    
    NSDictionary *sigDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"image_name":imageName,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:sigDic];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"image_name":imageName,@"upimage":imgStr,@"timestamp":timestamp,@"sig":[BaseUtil md5:sig]};
    
    [BaseUtil post:KAPI_headpic postBody:dic success:^(id responseObj) {
        //加载图片
        [self loadPictureData];
    } ailure:^(NSError *error) {
        
    }];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
//加载图片的链接
- (void)loadPictureData
{
    //用户id的前两位
    if ([CMCUserManager shareManager].token) {
        NSString *user = [BaseUtil md5:[CMCUserManager shareManager].uid];
        NSString *urlStr = [NSString stringWithFormat:@"%@1/%@/%@_1.jpg",[CMCUserManager shareManager].file_url,[user substringWithRange:NSMakeRange(0, 2)],[user lowercaseString]];
        
        NSURL *url = [NSURL URLWithString:urlStr];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
        self.photoImageView.image = image;
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [BaseUtil toast:@"你还没有登录哦"];
    }
}



-(void)onCheckVersion

{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    NSLog(@"results ===========%@",results);
    
    if (results.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.tag = 10001;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [alert show];
        
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
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [alert show];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                alert.tag = 10001;
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [alert show];
                
            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            alert.tag = 10001;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [alert show];
        }
        
        
    }
    
    
    
}





/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
