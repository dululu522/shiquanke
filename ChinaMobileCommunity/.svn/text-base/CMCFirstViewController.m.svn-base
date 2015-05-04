//
//  CMCFirstViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFirstViewController.h"
#import "CMCCycleScrollView.h"

#import "CMCADViewController.h"
#import "FocusImageView.h"
#import "MBProgressHUD+Add.h"

#import "CMCFirstTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

#import "CMCButtonViewController.h"

#import "CMCOrderSeriesVC.h"

#import "CMCDianCanVC.h"
#import "UIButton+WebCache.h"
//#import "CMCVoucherDetailTableVC.h"
#import "CMCShopDetailViewController.h"
#import "CMCFirstServiceEvaluationVC.h"
#import "CMCDianCanVC.h"

@interface CMCFirstViewController ()
@property (nonatomic, retain) NSString *cityTitle;
@property (nonatomic ,strong) CMCCycleScrollView* focusScorllView;

@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) NSMutableArray* focusImageArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) UIView* headerview;
@property (nonatomic, strong) UILabel *latitude;

@property (nonatomic, strong) NSMutableArray *cate_nameArr;

@property (nonatomic, strong) NSMutableArray *cate_idArr;
@property (nonatomic, strong) NSMutableArray *imageArr;




@end

@implementation CMCFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"HomePage"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"HomePage_select"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cate_nameArr = [[NSMutableArray alloc] init];
    self.cate_idArr = [[NSMutableArray alloc] init];
    self.imageArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.headerview.backgroundColor = [UIColor whiteColor];
    self.headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 330
                                                              )];
    self.headerview.backgroundColor = [UIColor clearColor];
    self.focusScorllView = [[CMCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 148) animationDuration:5];
    self.focusScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    [self.headerview addSubview:self.focusScorllView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.frame = CGRectMake(0, 155, 320, 25);//0, 0, 320, 25
    _pageControl.numberOfPages = 0;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    [self.headerview addSubview:_pageControl];
    self.tableview.tableHeaderView = self.headerview;
    self.headerview.backgroundColor = [UIColor colorWithHexString:@"b5b5b5"];
    


    
    UILabel* hotlabel = [[UILabel alloc]initWithFrame:CGRectMake(-1, 153+2*80 + 5, 322, 15)];
    hotlabel.backgroundColor = [UIColor whiteColor];
    hotlabel.text = @"  热门推荐";
    hotlabel.textAlignment = NSTextAlignmentLeft;
    hotlabel.font = [UIFont fontWithName:nil size:12.0];
//    hotlabel.font = [UIFont boldSystemFontOfSize:14];
    hotlabel.layer.borderWidth = .5f;
//    hotlabel.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:.2]CGColor];
    hotlabel.textColor = [UIColor redColor];
    [self.headerview addSubview:hotlabel];
    


    

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self.cate_nameArr removeAllObjects];
    [BaseUtil get:kAPI_getMerchantCategory success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        NSLog(@"%@",kAPI_getMerchantCategory);
        NSArray *infoArray = [jsonObject objectForKey:@"info"];
        for (NSDictionary *tempDic in infoArray) {
            NSString *cate_nameStr = [tempDic objectForKey:@"cate_name"];
            //        NSString *image = [tempDic objectForKey:@"image"];
            [self.cate_nameArr addObject:cate_nameStr];
            [self.cate_idArr addObject:[tempDic objectForKey:@"id"]];
            [self.imageArr addObject:[tempDic objectForKey:@"image"]];
            
        }
//        NSLog(@"lei  %@",self.cate_nameArr);
        [self.tableview reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    //地图定位
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置代理
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    //八个图片
    [self creatEightButton];
    
    

}
//创建8个按钮
- (void)creatEightButton
{

    NSLog(@"cate===  %d",self.cate_nameArr.count);

    for (int n = 0; n < self.cate_nameArr.count/4; n++) {
        for (int i = 0;i < 4 ; i++) {
//            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0 + i * 80, 153 + n * 79, 80, 80)];
//            tempView.backgroundColor = [UIColor colorWithHexString:@"b5b5b5"];
//            [self.headerview addSubview:tempView];
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [button setBackgroundImage:[UIImage imageNamed:button_imageArray[n * 4 + i]] forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor orangeColor];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:[self.cate_nameArr objectAtIndex:n * 4 + i] forState:UIControlStateNormal];
            NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kAPI_image,[self.imageArr objectAtIndex:n * 4 + i]]];
            NSLog(@"===== %@",url1);
            [button sd_setBackgroundImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"log"]];
//            [button setBackgroundImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"log"]];
            button.frame = CGRectMake(0 + i * 80, 153 + n * 80, 79.5, 79.5);
            [button addTarget:self action:@selector(buttonClickType:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:10];
            button.tag = n * 4 + i + 100;
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -34, 0)];
            [self.headerview addSubview:button];
        }
    }



}

//更新当前设备的最新位置
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations   %@",locations);
    
    for (CLLocation *location in locations) {
        CLLocationCoordinate2D coordinate2d = location.coordinate;
        NSLog(@"%f",coordinate2d.latitude);
        NSLog(@"%f",coordinate2d.longitude);
//        CLLocationDegrees latitude = coordinate2d.latitude;
//        CLLocationDegrees longitude = coordinate2d.longitude;
        
    }
//    [manager stopUpdatingLocation];
     // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    

    
    
}

- (void)changePage:(UIPageControl*)page
{
    
}
    //点击8个button跳转到 口味.速度.服务页面
- (void)buttonClickType:(UIButton *)button
{
    CMCShopDetailViewController *shopDetailVC = [[CMCShopDetailViewController alloc] init];
    shopDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    
//        CMCButtonViewController *buttonVC = [[CMCButtonViewController alloc] init];
//        buttonVC.type_id = [self.cate_idArr objectAtIndex:button.tag - 100];
//        [self.navigationController pushViewController:buttonVC animated:YES];
    //服务评价
//    CMCFirstServiceEvaluationVC *first = [[CMCFirstServiceEvaluationVC alloc] init];
//    [self.navigationController pushViewController:first animated:YES];
    
//    CMCDianCanVC *dianCanVC = [[CMCDianCanVC alloc] init];
//    dianCanVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:dianCanVC animated:YES];



}
- (void)refreshFocusView
{
    __weak typeof(self) wself = self;
    self.focusScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        wself.pageControl.currentPage = wself.focusScorllView.currentPageIndex;
        
        return wself.focusImageArray[pageIndex];
    };
    self.focusScorllView.totalPagesCount = ^NSInteger(void){
        return wself.focusImageArray.count;
    };
    self.focusScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",(int)pageIndex);
//        ADViewController* ad = [[ADViewController alloc]init];
        FocusImageView* view = wself.focusImageArray[pageIndex];
//        ad.title = view.item.title;
//        ad.link = view.item.link;
//        ad.hidesBottomBarWhenPushed = YES;
//        [wself.navigationController pushViewController:ad animated:YES];
    };
    self.pageControl.numberOfPages = self.focusImageArray.count;
}
- (void)didClickButtonItems:(NSInteger)number
{

    NSLog(@"%d",number);


}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reuse";
    CMCFirstTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CMCFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.delegate = self;
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
//    [cell fullDataFromItem:self.datasArray[indexPath.row]];
    [cell createButton];
    [self creatEightButton];
    cell.selectionStyle =     UITableViewCellSelectionStyleNone;

    
    return cell;
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
