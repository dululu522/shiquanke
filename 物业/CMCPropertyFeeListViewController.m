 //
//  CMCPropertyFeeListViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPropertyFeeListViewController.h"
#import "CMCPropertyFeeList.h"
#import "CMCPropertyFeeCell.h"
#import "CMCManagementFeeVC.h"
#import "CMCLoginViewController.h"

@interface CMCPropertyFeeListViewController ()
{
    NSInteger _page;
}
@property (nonatomic, strong) NSMutableArray *feeListArr;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *feeListDic;



@end

@implementation CMCPropertyFeeListViewController

- (NSMutableArray *)feeListArr
{
    if (_feeListArr == nil) {
        _feeListArr = [NSMutableArray array];
    }
    return _feeListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.feeListDic = [[NSMutableDictionary alloc] init];
    _page = 1;
    [self createHeaderView];
    [self showRefreshHeader:YES];
    [self creatTableView];
    [self loadData];
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

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    if (aRefreshPos == EGORefreshHeader) {
        _page = 1;
    } else if (aRefreshPos == EGORefreshFooter) {
    
        _page++;
    }
    [self loadData];


}
- (void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [BaseUtil setExtraCellLineHidden:self.tableView];

}
- (void)loadData
{
    NSString *typeStr ;
    if ([self.title isEqualToString:@"物业费"]) {
        typeStr  =  @"1";
    }
    if ([self.title isEqualToString:@"停车费"]) {
        typeStr  =  @"2";
    }
    if ([self.title isEqualToString:@"水费"]) {
        typeStr  =  @"3";
    }
    if ([self.title isEqualToString:@"煤气费"]) {
        typeStr  =  @"4";
    }
    if ([self.title isEqualToString:@"电费"]) {
        typeStr  =  @"5";
    }
    if (_page == 1) {
        [self.feeListArr removeAllObjects];
        [_feeListDic removeAllObjects];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"owner_id":self.owner_id,@"type":typeStr,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *requestUrl = KAPI_mypropertyorder(timestamp, sig, [CMCUserManager shareManager].token, self.owner_id, typeStr, pageStr, @"8");
    NSLog(@"各种费用 requestUrl =======%@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic= [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCPropertyFeeList *propertyFee = [[CMCPropertyFeeList alloc] initWithPropertyFeeList:tempDic];
                    [self.feeListArr addObject:propertyFee];
                    [_feeListDic addEntriesFromDictionary:tempDic];
                    
                    
                }
                [self finishReloadingData];
                [self setFooterView];
                [self.tableView reloadData];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }else {
                [BaseUtil toast:@"数据加载完毕"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            }
        } else if ([[infoDic objectForKey:@"result"] intValue] == 3){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        
        } else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"服务端数据返回错误"];
        
        }
    } failure:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.feeListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *str = @"reused";
    CMCPropertyFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCPropertyFeeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    CMCPropertyFeeList *feeList = [self.feeListArr objectAtIndex:indexPath.row];
//    cell.textLabel.text = feeList.address;
    [cell creatPropertyFee:feeList];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
                CMCManagementFeeVC *waterBillDetailVC = [[CMCManagementFeeVC alloc] init];
                waterBillDetailVC.category = self.title;
                waterBillDetailVC.managementDic = self.feeListDic;
                waterBillDetailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:waterBillDetailVC animated:YES];



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
