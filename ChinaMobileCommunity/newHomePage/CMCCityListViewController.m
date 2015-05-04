//
//  CMCCityListViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCityListViewController.h"
#import "CMCCommunity.h"
#import "CMCCommunityTableViewCell.h"
#import "TCHomePageViewController.h"
#import "CMCAccountViewController.h"
#import "CMCWuYeVC.h"
#import "CMCActivityViewController.h"

@interface CMCCityListViewController ()
{
    
    UIView *_backView;
    UISearchBar *_searchBar;
    NSInteger _page;
    int row;
    int isSelect;
}

@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) UITableView *areaTabelView;
@property (nonatomic,strong)UITableView *resultTableView;

@property (nonatomic, strong) NSMutableDictionary *city_idDic;//通过城市名取出城市id
@property (nonatomic, strong) NSMutableArray *loc_entryArr;//获取loc_entry
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *communityArr;
@property (nonatomic, strong) NSString *chooseCity;
@property (nonatomic,strong)NSMutableArray *reslutArr;
@property (nonatomic, strong) NSString *city_idStr;
@property (nonatomic,strong) NSString *loc_entry;



@end

@implementation CMCCityListViewController


- (NSMutableArray *)reslutArr{
    if (_reslutArr == nil) {
        self.reslutArr = [NSMutableArray array];
    }
    return _reslutArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"切换社区";
    _page = 0;
    [self createHeaderView];
    [self showRefreshHeader:YES];
    self.city_idDic = [[NSMutableDictionary alloc] init];
    self.cityArr = [[NSMutableArray alloc] init];
    self.communityArr = [[NSMutableArray alloc] init];
    self.loc_entryArr = [[NSMutableArray alloc] init];
    isSelect = 1;
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    [self creatCityTableView];
    [self creatAreaTableView];
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
- (void)didClickBackBtn:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    //上拉刷新
    if (aRefreshPos == EGORefreshHeader) {
        _page = 0;
        
    }else if (aRefreshPos == EGORefreshFooter){
        //下拉加载
        _page++;
        
    }
    [self loadAreaData:self.city_idStr];
    
}
- (void)creatCityTableView
{
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,100 , self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.backgroundColor = kAPI_AllMainColor;
    [_backView addSubview:self.cityTableView];
    [BaseUtil setExtraCellLineHidden:self.cityTableView];
    [self loadCityData];
    
}


- (void)creatAreaTableView
{
    self.areaTabelView = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 100, self.view.frame.size.height)];
    self.areaTabelView.delegate = self;
    self.areaTabelView.dataSource = self;
    
    [BaseUtil setExtraCellLineHidden:self.areaTabelView];
    [_backView addSubview:self.areaTabelView];
    
    
    //    _resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 100, self.view.frame.size.height) style:UITableViewStyleGrouped];
    //    _resultTableView.delegate = self;
    //    _resultTableView.dataSource = self;
    //    _resultTableView.backgroundColor = [UIColor whiteColor];
    //    _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
//加载城市数据
- (void)loadCityData
{
    [self.cityArr removeAllObjects];
    [self.city_idDic removeAllObjects];
    [self.loc_entryArr removeAllObjects];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"timestamp":timestamp};
    NSString *sig = [BaseUtil md5:[BaseUtil getSigWithArray:dic]];
    //    NSLog(@"KAPI_GetCityList(sig,timestamp) %@", KAPI_GetCityList(sig,timestamp));
    [BaseUtil get:KAPI_GetCityList(sig,timestamp) success:^(id respondObject) {
        NSLog(@"加载城市数据  %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            NSDictionary *dataDic= [respondObject objectForKey:@"data"];
            NSArray *citylistArr = [dataDic objectForKey:@"citylist"];
            for (NSDictionary *tempDic in citylistArr) {
                //base64解密
                NSString *plainString =[tempDic objectForKey:@"city"];
                [self.cityArr addObject:plainString];
                //通过城市名获取city_id
                [self.city_idDic setObject:[tempDic objectForKey:@"city_id"] forKey:plainString];
                //获取loc_entry
                [self.loc_entryArr addObject:[tempDic objectForKey:@"loc_entry"]];
            }
            
            for (int i = 0; i < self.cityArr.count; i++) {
                NSString *city = self.cityArr[i];
                //如果获得的城市跟里面的数据一样
                if ([city isEqualToString:[CMCUserManager shareManager].city]) {
                    NSString *loc_entry = self.loc_entryArr[i];
                    self.chooseCity = city;
                    _page = 0;
                    self.loc_entry = loc_entry;
                    [CMCUserManager shareManager].loc_entry = loc_entry;
                    self.city_idStr = [self.city_idDic objectForKey:city];
                    row = i;
                    break;//跳出循环
                }else{
                    
                    NSString *loc_entry = self.loc_entryArr[0];
                    self.chooseCity = city;
                    _page = 0;
                    self.loc_entry = loc_entry;
                    row = 0;
                    [CMCUserManager shareManager].loc_entry = loc_entry;
                    self.city_idStr = [self.city_idDic objectForKey:city];
                    NSLog(@"cmc ==== %@",[CMCUserManager shareManager].loc_entry);
                }
            }
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.cityTableView reloadData];
            [self tableView:_cityTableView didSelectRowAtIndexPath:indexPath];
            
        }else {
            [BaseUtil toast:@"服务器无响应,请重试"];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}
//加载社区数据
- (void)loadAreaData:(NSString *)city_id
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"chooseCity = %@",self.chooseCity);
    NSString *timestamp = kAPI_timestamp;
    NSString *pageStr = [NSString stringWithFormat:@"%d",_page];
    NSLog(@"----------self%@",city_id);
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"city_id":city_id,@"search":self.chooseCity,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
//    NSLog(@"===========^^^^^^^^^ %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_GetAreaList(city_id, self.chooseCity, pageStr, @"8", timestamp, sig);
    if (_page == 0) {
        [self.communityArr removeAllObjects];
    }
    NSLog(@"社区 url ==%@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"社区respondeobject = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCCommunity *community = [[CMCCommunity alloc] initWithCommunityDic:tempDic];
                    [self.communityArr addObject:community];
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                NSLog(@"^^^^^^^^%ld",self.communityArr.count);
                [self.areaTabelView reloadData];
                [self finishReloadingData];
                [self setFooterView];
            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                [self.areaTabelView reloadData];
                //                [BaseUtil toast:@"数据已加载完毕"];
                return ;
            }
        }else{
            
            [BaseUtil toast:@"服务端暂无响应,请重试"];
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cityTableView == tableView) {
        return self.cityArr.count;
    }
    if (self.areaTabelView == tableView) {
        return self.communityArr.count;
    }
    return self.reslutArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityTableView) {
        static NSString *used = @"cityTableView";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:used];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:used];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kAPI_AllMainColor;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        cell.textLabel.text = [self.cityArr objectAtIndex:indexPath.row];
        return cell;
    }
    
    if (tableView == self.areaTabelView) {
        NSString *str = @"CMCCommunityTableViewCell";
        
        CMCCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCCommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        CMCCommunity *community = [self.communityArr objectAtIndex:indexPath.row];
        cell.community = community;
        return cell;
    }
    
    //    if (tableView == self.resultTableView) {
    //        NSString *str = @"CMCCommunityResultCell";
    //
    //        CMCCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    //        if (cell == nil) {
    //            cell = [[CMCCommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    //        }
    //        CMCCommunity *community = _reslutArr[indexPath.row];
    //        cell.community = community;
    //        [cell setupRemoveSuperViewBlock:^{
    //            [_resultTableView removeFromSuperview];
    //        }];
    //        return cell;
    //    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityTableView == tableView) {
        return 44;
    }
    if (self.areaTabelView == tableView) {
        return 64;
    }
    return 64;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    if (tableView != self.cityTableView) {
    //        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.areaTabelView.frame.size.width, 40)];
    //        searchView.backgroundColor = [UIColor colorWithHexString:@"C4E5FD"];
    //        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 5, 164, 30)];
    //        _searchBar.delegate = self;
    //        _searchBar.backgroundColor = [UIColor whiteColor];
    //        [_searchBar setBackgroundImage:[UIImage imageNamed:@"searchBar"]];
    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        button.frame = CGRectMake(_searchBar.right, 0, 50, 40);
    //        [button setTitle:@"搜索" forState:UIControlStateNormal];
    //        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    //        button.titleLabel.font = [UIFont systemFontOfSize:15];
    //        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    //        [searchView addSubview:button];
    //
    //        [searchView addSubview:_searchBar];
    //        return searchView;
    //    }
    return nil;
}
- (void)didClickButton:(UIButton *)button
{
    [_searchBar resignFirstResponder];
    [self.reslutArr removeAllObjects];
    [_backView addSubview:_resultTableView];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",_searchBar.text];
    
    for (int i = 0; i < _communityArr.count; i++) {
        CMCCommunity *community = _communityArr[i];
        if ([predicate evaluateWithObject:community.name]) {
            [self.reslutArr addObject:community];
        }
        [_resultTableView reloadData];
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (tableView == self.areaTabelView) {
    //        return 40;
    //
    //    }
    //    if (tableView == self.resultTableView) {
    //        return 40;
    //    }
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityTableView == tableView) {
        if (indexPath.row != row  && isSelect == 1) {
            NSLog(@"once");
            NSIndexPath *seletIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            UITableViewCell *seletCell = [tableView cellForRowAtIndexPath:seletIndexPath];
            seletCell.backgroundColor = kAPI_AllMainColor;
            isSelect = 0;
        }
        
        //改变颜色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        NSString *city_id = [self.city_idDic objectForKey:[self.cityArr objectAtIndex:indexPath.row]];
        self.city_idStr = city_id;
        self.chooseCity = [self.cityArr objectAtIndex:indexPath.row];
        
        self.loc_entry = [self.loc_entryArr objectAtIndex:indexPath.row];
        _page = 0;
        [CMCUserManager shareManager].loc_entry = [self.loc_entryArr objectAtIndex:indexPath.row];
        [self creatAreaTableView];
        [self loadAreaData:city_id];
        
    }
    if (self.areaTabelView == tableView) {
        //登录的时候没有loc_entry跳转到此页面的,就调用 [self creatTabbar];其他的正常切换
        CMCCommunity *community;
        if (tableView == self.areaTabelView) {
            community = [self.communityArr objectAtIndex:indexPath.row];
        }
        
        [CMCUserManager shareManager].address = community.address;
        [[NSUserDefaults standardUserDefaults] setObject:community.zid forKey:@"zid"];
        [CMCUserManager shareManager].city = self.chooseCity;
        [CMCUserManager shareManager].city_id = self.city_idStr;
        [[NSUserDefaults standardUserDefaults] setObject:self.city_idStr forKey:@"city_id"];
        [CMCUserManager shareManager].z_name = community.name;
        [CMCUserManager shareManager].loc_entry = self.loc_entry;
        NSLog(@"cmc ==== %@",[CMCUserManager shareManager].loc_entry);

        [[NSUserDefaults standardUserDefaults] setValue:community.zid forKey:@"zid"];
       
        [self creatTabbar];
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
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *nv3  = [[UINavigationController alloc] initWithRootViewController:wuyeVC];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:accountVC];
    //    NSLog(@"kAPI_Property %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"property"]);
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _cityTableView) {
        //改变颜色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = kAPI_AllMainColor;
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
