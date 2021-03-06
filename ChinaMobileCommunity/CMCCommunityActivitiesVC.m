//
//  CMCCommunityActivitiesVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCommunityActivitiesVC.h"
#import "CMCActivityTableViewCell.h"
#import "CMCActivitiesDetailVC.h"
#import "CMCActivityList.h"

@interface CMCCommunityActivitiesVC ()
{
    NSInteger _page;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *activityArr;



@end

@implementation CMCCommunityActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityArr = [[NSMutableArray alloc] init];
    _page = 1;
    [self createHeaderView];
    [self showRefreshHeader:YES];
//    _request = [[NetWorkRequest alloc] init];
//    _request.delegate = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
        [self loadData];


    [self creatBackButton];
}
- (void)creatBackButton
{
    //后退按钮
    //    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    
    UIView *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10,10, 20)];
    [backView addSubview:billImageView];
    
    billImageView.image = [UIImage imageNamed:@"后退_03"];
    billImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackBtn:)];
    [backView addGestureRecognizer:tap];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    
    //    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)didClickBackBtn:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
    if (_page == 1) {
        [self.activityArr removeAllObjects];
    }
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
    NSLog(@"%@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = kAPI_actilist(k_zid, pageStr, @"8", timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token);
    NSLog(@"requestUrl  %@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"小区列表 %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];

        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCActivityList *activityList = [[CMCActivityList alloc] initWithActivityList:tempDic];
                    [self.activityArr addObject:activityList];
                    
                }
                self.tableView.hidden = NO;
                [self.tableView reloadData];
                [self finishReloadingData];
                [self setFooterView];
            }else {
                self.tableView.hidden = NO;
                [BaseUtil toast:@"数据已经加载完毕"];
            }
        }
    } failure:^(NSError *error) {
        
    }];



}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CMCActivityTableViewCell";
    CMCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
        CMCActivityList *activity = [self.activityArr objectAtIndex:indexPath.row];
        //    [cell creatCommunityActivitiesCell:activity];
        cell.sectionName = self.title;
        [cell creatCommunityActivitiesListCell:activity];

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 94;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CMCActivity *activity = [self.activityArr objectAtIndex:indexPath.row];
    CMCActivitiesDetailVC *activityDetail = [[CMCActivitiesDetailVC alloc] init];
     activityDetail.id = activity.id;
    activityDetail.title = @"活动详情";
    [self.navigationController pushViewController:activityDetail animated:YES];



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
