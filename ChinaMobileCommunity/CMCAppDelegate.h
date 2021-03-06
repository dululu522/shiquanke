//
//  CMCAppDelegate.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface CMCAppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,NetWorkRequesDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate>
{

    UITabBarController *tabbarController;
    BMKMapManager* _mapManager;
    BMKMapView* _mapView;
    BMKLocationService* _locService;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *cnameArr;
@property (strong, nonatomic) NSMutableArray *locationArr;
@property (strong, nonatomic) NSMutableArray *idArr;
@property (strong,nonatomic) NSMutableArray *polyArr;


@end
