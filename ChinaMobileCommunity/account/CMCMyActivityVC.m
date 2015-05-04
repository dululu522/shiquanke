//
//  CMCMyActivityVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyActivityVC.h"
#import "CMCActivityTableViewCell.h"
#import "CMCMyActivityDetailVC.h"
#import "CMCActivityDetail.h"
#import "CMCQScrollView.h"


@interface CMCMyActivityVC ()

@property (nonatomic, strong) UITableView *activityTableView;
@property (nonatomic, strong) NSMutableArray *activityArr;

@end

@implementation CMCMyActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];

    self.activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.activityTableView.delegate = self;
    self.activityTableView.dataSource = self;
    [BaseUtil setExtraCellLineHidden:self.activityTableView];
    [self.view addSubview:self.activityTableView];
    [self loadData];
}

- (void)loadData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic= @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"timestamp":timestamp,@"app_ver":APPVersion,@"city_id":k_city_id,@"zid":@"1"};
    NSLog(@"我的活动列表 %@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr = kAPI_myactilist([CMCUserManager shareManager].token, k_city_id, timestamp, @"1", [BaseUtil md5:sig]);
    NSLog(@"sig %@",sig);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"我的活动列表 %@",respondObject);
        NSDictionary *infoDic= [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                NSDictionary *tempDic = [dataArr firstObject];
//                [self.activityArr addObjectsFromArray:dataArr];
                [self loadDetailData:[tempDic objectForKey:@"act_id"]];
            }
        }
    } failure:^(NSError *error) {
        
    }];
//    [_request loadDataWithURLString:requestStr];
}
- (void)loadDetailData:(NSString *)idStr
{
    [self.activityArr removeAllObjects];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"id":idStr,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = kAPI_actiinfo(k_zid, idStr, timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"%@",requestUrl);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *tempDic = [respondObject objectForKey:@"data"];
                CMCActivityDetail *activityDetail = [[CMCActivityDetail alloc] initWithActivityDetail:tempDic];
                [self.activityArr addObject:activityDetail];
            }
            [self.activityTableView reloadData];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CMCActivityDetail *activity = [self.activityArr objectAtIndex:indexPath.row];
    [cell creatMyCommunityActivitiesCell:activity];
    return cell;
} 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 94;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCActivityDetail *activity= [self.activityArr objectAtIndex:indexPath.row];
    CMCMyActivityDetailVC *myActivityDetailVC = [[CMCMyActivityDetailVC alloc] init];
    myActivityDetailVC.id = activity.id;
    myActivityDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myActivityDetailVC animated:YES];


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