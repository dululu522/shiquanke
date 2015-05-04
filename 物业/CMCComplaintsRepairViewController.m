//
//  CMCComplaintsRepairViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-14.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCComplaintsRepairViewController.h"
#import "CMCNoticeTableViewCell.h"
#import "CMCRepairVC.h"
#import "CMCComplaint.h"
#import "CMCComplaintDetailVC.h"

@interface CMCComplaintsRepairViewController ()
{
    
    NSInteger _page;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *complaintArr;

@end

@implementation CMCComplaintsRepairViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _page = 1;
    self.complaintArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self creatRightBarButtonItems];
    [self createHeaderView];
    [self showRefreshHeader:YES];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
    
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
        [self.complaintArr removeAllObjects];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":self.zid,@"type":self.type,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    
    NSString *requestUrl = KAPI_advicelist([CMCUserManager shareManager].token, self.zid, self.type, pageStr, @"8", timestamp,[BaseUtil md5:sig]);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"respondObject  %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] integerValue] == 0) {
            if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"] ;
                for (NSDictionary *tempDic in dataArr) {
                    CMCComplaint *complaint = [[CMCComplaint alloc] initWithComplaintDic:tempDic];
                    [self.complaintArr addObject:complaint];
                }
                [self.tableView reloadData];
                [self finishReloadingData];
                [self setFooterView];
            } else if ([[infoDic objectForKey:@"result"] integerValue] == 3){
                CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
                loginVC.hidesBottomBarWhenPushed = YES;
                
            }else{
                [BaseUtil toast:@"数据已加载完毕"];
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)creatRightBarButtonItems
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self.type intValue] == 0) {
        [rightButton setTitle:@"我要投诉" forState:UIControlStateNormal];
        
    } else {
        [rightButton setTitle:@"我要报修" forState:UIControlStateNormal];
        
    }
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    rightButton.frame = CGRectMake(self.view.frame.size.width - 80, 20, 80, 40);
    [rightButton addTarget:self action:@selector(didClickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
- (void)didClickRightButton
{
    //    我要投诉  我要报修
    CMCRepairVC *repairVC = [[CMCRepairVC alloc] init];
    repairVC.title = self.title;
    repairVC.type = self.type;
    repairVC.zid = self.zid;
    repairVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:repairVC animated:YES];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.complaintArr.count;
    
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
    cell.category = self.title;
    CMCComplaint *complaint = [self.complaintArr objectAtIndex:indexPath.row];
    cell.complaint = complaint;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCComplaintDetailVC *propertyVC = [[CMCComplaintDetailVC alloc] init];
    CMCComplaint *complaint = [self.complaintArr objectAtIndex:indexPath.row];
    
    if ([self.title isEqualToString:@"投诉列表"]) {
        propertyVC.title = @"投诉记录";
    } else {
        
        propertyVC.title = @"报修记录";
        
    }
    propertyVC.advice_id = complaint.id;
    propertyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:propertyVC animated:YES];
    
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
