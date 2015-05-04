 //
//  CMCConvenientLifeListVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCConvenientLifeListVC.h"
#import "CMCConvenientLifeListTVCell.h"
#import "CMCConvenientLifeDetailVC.h"
#import "CMCFood.h"

@interface CMCConvenientLifeListVC ()
{
    NSInteger _page; //第几页
    NSInteger _number;

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *foodArr;


@end

@implementation CMCConvenientLifeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.foodArr = [[NSMutableArray alloc] init];

    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    [self creatTabelView];
    [self loadDataType];
    
    self.title = self.merchant_name;
    [self createHeaderView];
    [self showRefreshHeader:YES];

    [self creatBackButton];
    
}
- (void)creatTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    [self setExtraCellLineHidden:self.tableView];
    [BaseUtil setExtraCellLineHidden:self.tableView];

}
- (void)creatBackButton
{
    //后退按钮
    UIView *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10,10, 20)];
    [backView addSubview:billImageView];
    
    billImageView.image = [UIImage imageNamed:@"后退_03"];
    billImageView.userInteractionEnabled = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackBtn:)];
    [backView addGestureRecognizer:tap];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    
    //    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 20, 20, 44);
    rightBtn.enabled = NO;
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
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
    
    [self loadDataType];

}

- (void)loadDataType
{

    NSString *timeStamp = kAPI_timestamp;
    NSLog(@"zid = %@",[CMCUserManager shareManager].zid);
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":[NSString stringWithFormat:@"%@",APPVersion],@"zid":k_zid,@"trade_id":self.merchant_type,@"page":pageStr,@"nums":@"8",@"timestamp":timeStamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *urlStr = KAPI_MerchantList(k_zid, self.merchant_type,pageStr, @"8", sig);
    
    if (_page == 1) {
        [self.foodArr removeAllObjects];
    }
    
    NSLog(@"============urlStr = %@",urlStr);
    [BaseUtil get:urlStr success:^(id respondObject) {
        NSLog(@"respondject = %@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([[[respondObject objectForKey:@"info"] objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCFood *merchantList = [[CMCFood alloc] initWithFood:tempDic];
                    [self.foodArr addObject:merchantList];
                }
                [self.tableView reloadData];
                [self finishReloadingData];
                [self setFooterView];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } else if([[[respondObject objectForKey:@"info"] objectForKey:@"result"] intValue] == 3){
                [MBProgressHUD hideHUDForView:self.view animated:YES];

                CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            
            } else{
                [BaseUtil toast:@"没有更多的数据了"];
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self removeHeaderView];
                
            }
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [BaseUtil toast:@"加载数据失败"];
        return;
    }];
    
    
}
- (void)removeFooter
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES ];
    [BaseUtil toast:@"没有更多的数据了"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    CMCConvenientLifeListTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCConvenientLifeListTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
    [cell creatCell:food];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCConvenientLifeDetailVC *detailVC = [[CMCConvenientLifeDetailVC alloc] init];
    CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
    detailVC.mid = food.mid;
    detailVC.title = food.name;
    detailVC.category = self.merchant_name;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
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
