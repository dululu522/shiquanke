//
//  CMCNoticeVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCNoticeVC.h"
#import "CMCNoticeTableViewCell.h"
#import "NetWorkRequest.h"
#import "CMCVillageNoticeDetailVC.h"
#import "CMCCommunityNotification.h"

@interface CMCNoticeVC ()
{


//    NetWorkRequest *_request;
    NSInteger _page;
}
//@property (nonatomic, strong) NSMutableArray *requesttimeArray;
//@property (nonatomic, strong) NSMutableArray *managementtitleArray;
//@property (nonatomic, strong) NSMutableArray *managementcontentArr;
////@property (nonatomic, strong) NSMutableArray *newscontentArray;
////@property (nonatomic, strong) NSMutableArray *statusArray;
////@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) NSMutableArray *noticeListArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CMCNoticeVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"小区通知";
    _page = 1;
    self.noticeListArr = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame. size.height - 64)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self createHeaderView];
    [self showRefreshHeader:YES];
    
    [self loadData];

    [self creatNavigationBackButton];
    
}
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    //上拉刷新
    if (aRefreshPos == EGORefreshHeader) {
        _page = 1;
        
    }else if (aRefreshPos == EGORefreshFooter){
        //下拉加载
        _page++;
        
    }
    [self loadData];
    
}

- (void)loadData
{

    if ([CMCUserManager shareManager].token) {
        if (_page == 1) {
            [self.noticeListArr removeAllObjects];
        }
        NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":self.zid,@"timestamp":timestamp,@"page":pageStr,@"nums":@"8"};
        NSLog(@"%@",dic);
        NSString *sig = KAPI_GetSig(dic);
        NSString *requestUrl = KAPI_notice([CMCUserManager shareManager].token, self.zid, timestamp, sig, pageStr, @"8");
        [BaseUtil get:requestUrl success:^(id respondObject) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSLog(@"小区通知 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *dataDic = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataDic) {
                        CMCCommunityNotification *communotyNotification = [[CMCCommunityNotification alloc] initWithCommunityNotificationDic:tempDic];
                        [self.noticeListArr addObject:communotyNotification];
                    }

                    [self.tableView reloadData];
                    [self finishReloadingData];
                    [self setFooterView];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                }else {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                    [BaseUtil toast:@"暂无数据"];
                }

            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"暂无数据"];

            
            }
        } failure:^(NSError *error) {
            
        }];
    }



}
- (void)creatNavigationBackButton
{
    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    [billButton setBackgroundImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [billButton addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
}
#pragma mark-
#pragma mark- 返回按钮
- (void)didClickBackBtn:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return self.noticeListArr.count;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *str = @"reused";
    CMCNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
   
    if (cell == nil) {
         cell = [[CMCNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (self.noticeListArr.count) {
        CMCCommunityNotification *community = [self.noticeListArr objectAtIndex:indexPath.row];
//        [cell creatNoticeCell:community];
        cell.category = self.title;
        cell.community = community;
    }


    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        CMCCommunityNotification *community = [self.noticeListArr objectAtIndex:indexPath.row];
    CMCVillageNoticeDetailVC *villageNoticeVC = [[CMCVillageNoticeDetailVC alloc] init];
    villageNoticeVC.notice_id = community.id;
    villageNoticeVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:villageNoticeVC animated:YES];





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
