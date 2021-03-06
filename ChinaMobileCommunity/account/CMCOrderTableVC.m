//
//  CMCOrderTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderTableVC.h"
//#import "CMCOrderTableViewCell.h"
#import "CMCAccountTableViewCell.h"
#import "CMCMyOrderDetailVC.h"
#import "CMCReserveTableVC.h"
#import "CMCNOPageViewController.h"
#import "CMCMyOrderTableViewCell.h"

#import "CMCMyOrderServiceOrderedVC.h" //服务项目  已接单
#import "CMCMyOrderServiceFinishedVC.h"//服务项目  已完成
#import "CMCMyOrderServiceToEvaluateVC.h" // 服务项目 去评价
#import "CMCMyOrderServiceRejectedVC.h" // 服务项目 已拒单
#import "CMCMyOrderServiceEvaluateRejectedVC.h" //服务项目 已拒单 评价
#import "CMCMyOrderServiceUnOrderVC.h" //服务项目 未接单 去评价

#import "CMCMyOrder.h"
#import "CMCOrderDtailVC.h"
#import "CMCTakeOutDetailVC.h"
#import "CMCMaiDanDetailVC.h"



@interface CMCOrderTableVC ()
{
    NSInteger _page;
}
@property (nonatomic, strong) NSMutableArray *myOrderArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *serviceDic;
@property (nonatomic, strong) NSMutableDictionary *processDic; //通过服务id获取@"C",@"P"
@property (nonatomic, strong) NSMutableArray *stateArr;//存放状态


@end

@implementation CMCOrderTableVC

- (NSMutableArray *)stateArr
{
    if (_stateArr == nil) {
        _stateArr = [NSMutableArray array];
    }

    return _stateArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _page = 1;
    self.myOrderArr = [[NSMutableArray alloc] init];
    self.serviceDic = [[NSMutableDictionary alloc] init];
    self.processDic = [[NSMutableDictionary alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self fromIdGeterviceNameOrProcess]; //通过项目的id取出对应的项目名
    
    [self createHeaderView];
    [self showRefreshHeader:YES];
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [backView addSubview:self.tableView];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


//通过项目的id取出对应的项目名
- (void)fromIdGeterviceNameOrProcess
{
//    NSLog(@"k_order %@",k_order);
    for (NSDictionary *tempDic in kAPI_Service) {
        [self.serviceDic setObject:[tempDic objectForKey:@"name"] forKey:[tempDic objectForKey:@"id"]];
        //从服务项目id取出对应的process
        [self.processDic setObject:[tempDic objectForKey:@"process"] forKey:[tempDic objectForKey:@"id"]];
        
    }
//    NSLog(@"通过项目的id取出对应的项目名 %@",self.serviceDic);
    
    
}
- (void)loadData
{
//    NSLog(@"kAPI_Service =======%@",kAPI_Service);
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
//    NSLog(@"%@",dic);
    NSString *requestStr = kAPI_getMyorder(timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], pageStr, @"8");

    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"respondObject =========%@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (_page == 1) {
            [self.myOrderArr removeAllObjects];
        }
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *dataArr = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataArr) {
                        CMCMyOrder *myOrder = [[CMCMyOrder alloc] initWithMyOrderDic:tempDic];
                        [self.myOrderArr addObject:myOrder];
                    }
                    self.tableView.hidden = NO;
                    [self.tableView reloadData];
                    [self finishReloadingData];
                    [self setFooterView];
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                self.tableView.hidden = NO;
            }else {
                [BaseUtil toast:@"数据已加载完毕"];
                [self.tableView reloadData];
                self.tableView.hidden = NO;

                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            }
        }else {
            [BaseUtil toast:@"服务器返回数据错误"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        }
        
    } failure:^(NSError *error) {
        
    }];



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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

    NSLog(@"%ld",self.myOrderArr.count);
    return self.myOrderArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CMCAccountTableViewCell";
    CMCMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.serviceDic = self.serviceDic;
    cell.processDic = self.processDic;
    CMCMyOrder *myOrder = [self.myOrderArr objectAtIndex:indexPath.row];
    [cell creatMyOrderCell:myOrder];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 65;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CMCMyOrder *myOrder = [self.myOrderArr objectAtIndex:indexPath.row];
    NSString *process = [self.processDic objectForKey:myOrder.service_id];
    NSLog(@"%@  %@   %@ ",process,myOrder.state,myOrder.payment_type);
    
    //买单
    if ([process isEqualToString:@"P"]) {
        CMCMaiDanDetailVC *maiDanVC = [[CMCMaiDanDetailVC alloc]init];
        maiDanVC.dataModel = myOrder;
        [self.navigationController pushViewController:maiDanVC animated:YES];
    }else{
        CMCTakeOutDetailVC *takeOutVC = [[CMCTakeOutDetailVC alloc]init];
        takeOutVC.dataModel = myOrder;
        [self.navigationController pushViewController:takeOutVC animated:YES];
        return;
    }
    
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
