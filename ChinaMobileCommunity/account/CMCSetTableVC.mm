//
//  CMCSetTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCSetTableVC.h"
#import "CMCPropertyAddressTableVC.h"
#import "CMCAboutUsTVC.h"
#import "CMCChangePasswordVC.h"
#import "CMCAppDelegate.h"

#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "TCHomePageViewController.h"
#import "CMCActivityViewController.h"
#import "CMCCityListViewController.h"

@interface CMCSetTableVC ()
{
    NetWorkRequest *_request;
    NetWorkRequest *_shareRequst;
}
@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;

@end

@implementation CMCSetTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    _shareRequst = [[NetWorkRequest alloc] init];
    _shareRequst.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.firstArray  = [[NSMutableArray alloc] initWithObjects:@"物业地址",@"修改密码", nil];
    self.secondArray = [[NSMutableArray alloc] initWithObjects:@"清除缓存", nil];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (section == 0) {
        return self.firstArray.count;
    }
    if (section == 1) {
        return self.secondArray.count;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.firstArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [self.secondArray objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 2) {
        //        if (indexPath.row == 0) {
        //        cell.textLabel.text = @"分享下载";
        //        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于我们";
            
        }
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"退出登陆";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            //物业地址
            CMCPropertyAddressTableVC *propertyAddressVC = [[CMCPropertyAddressTableVC alloc] init];
            propertyAddressVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyAddressVC animated:YES];
        }
        if (indexPath.row) {
            CMCChangePasswordVC *changePassVC = [[CMCChangePasswordVC alloc] init];
            changePassVC.hidesBottomBarWhenPushed = YES;
            changePassVC.title = @"修改密码";
            [self.navigationController pushViewController:changePassVC animated:YES];
        }
        
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self clearDemo];
            
        }
    }
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            CMCAboutUsTVC *aboutUsVC = [[CMCAboutUsTVC alloc] init];
            aboutUsVC.hidesBottomBarWhenPushed = YES;
            aboutUsVC.title = @"关于我们";
            [self.navigationController pushViewController:aboutUsVC animated:YES];
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
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"property"];

            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"trade"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"property"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"service"];
           [self baiduMap];
            
        } else {
            
            [BaseUtil toast:@"你还没有登录"];
        }
        
    }
}
- (void)secondSubmittedData:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"location"] isKindOfClass:[NSArray class]]) {
        NSArray *locationArr = [dic objectForKey:@"location"];
        float number= 0;
        float distace = 0;
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
        [self creatTabbar];
    }else {
        [BaseUtil toast:@"暂时无相关的小区"];
    }
    
    
    
}

- (void)creatTabbar
{
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
    NSLog(@"kAPI_Property %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"property"]);
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
        
        NSLog(@"第一次访客登录 respondObject ======%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
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
