//
//  CMCMyOrderServiceUnOrderVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderServiceUnOrderVC.h"
#import "CMCMyOrderDetailTableViewCell.h"
#import "CMCMyOrderEvaluateVC.h"

@interface CMCMyOrderServiceUnOrderVC ()
{
    UIView *_backView;
}
@property (nonatomic, strong) UITableView *finishedTabelView;
@property (nonatomic, strong) NSMutableDictionary *myOrderDic;
@end

@implementation CMCMyOrderServiceUnOrderVC

- (NSMutableDictionary *)myOrderDic
{
    if (_myOrderDic == nil) {
        _myOrderDic = [NSMutableDictionary dictionary];
    }
    return _myOrderDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_backView];
    [self creatTableView];
    [self creatMakeSureOrder];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"去评价" style:UIBarButtonItemStylePlain target:self action:@selector(gotoEvaluate:)];
    [rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [self loadData];
}
////去评价
- (void)gotoEvaluate:(UIButton *)button
{
    CMCMyOrderEvaluateVC *myOrderEvaluateVC = [[CMCMyOrderEvaluateVC alloc] init];
    myOrderEvaluateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myOrderEvaluateVC animated:YES];
    
}
- (void)creatTableView
{
    self.finishedTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 128)];
    self.finishedTabelView.delegate = self;
    self.finishedTabelView.dataSource = self;
    self.finishedTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [BaseUtil setExtraCellLineHidden:self.finishedTabelView];
    [_backView addSubview:self.finishedTabelView];
    
    
}
- (void)loadData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":self.order_id,@"timestamp":timestamp};
    NSLog(@"dic ========%@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *requestUrl = kAPI_getMyorderDetail(timestamp, [CMCUserManager shareManager].token, sig, self.order_id);
    NSLog(@"requestUrl ==========%@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"respondObject =======%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];

        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] integerValue] == 0) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            [_myOrderDic addEntriesFromDictionary:dataDic];
            [self.finishedTabelView reloadData];
        } else {
        
            [BaseUtil toast:@"服务端数据错误"];
        
        }

    } failure:^(NSError *error) {
        
    }];


}
- (void)creatMakeSureOrder
{
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.frame = CGRectMake(10, self.view.frame.size.height - 128 +1, self.view.frame.size.width - 20, 40);
    makeSureBtn.backgroundColor = kAPI_AllMainColor;
    makeSureBtn.layer.cornerRadius = 5;
    [makeSureBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn addTarget:self action:@selector(didClickMakeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:makeSureBtn];
    
    
    
}
- (void)didClickMakeSureBtn:(UIButton *)button
{
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    //    if (section == 3) {
    //        return 1;
    //    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *str = @"reused";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
//        [cell creatMyOrderDetailCellStatus:@"未接单" type:@"服务项目"];
//        [cell creatMyOrderDetailCellStatus:@"未接单" type:@"服务项目" name:@"" time:@""];
        [cell creatMyOrderDetailCell];
        cell.myOrderDetailDic = self.myOrderDic;
        
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *str = @"re";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatName:@"服务时间:2015-01-27" phone:@"备注:我需要2个小时日常保洁"];
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *str = @"CMCMyOrderDetailTableViewCell";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell creatMyOrderDetailCopyLabelText:nil priceText:nil onlinePay:nil note:nil];
        [cell creatName:@"姓名:石头" phone:@"手机号:15509845678" address:@"地址:苹果园通景大厦702室"];
        return cell;
    }
    //    if (indexPath.section == 3) {
    //        static NSString *str = @"re";
    //        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    //        if (cell == nil) {
    //            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    //        }
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        [cell creatName:@"姓名:natural" phone:@"手机号:13263446196"];
    //        return cell;
    //    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 136;
    }
    if (indexPath.section == 1) {
        return 60;
    }
    //    if (indexPath.section == 3) {
    //        return 50;
    //    }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 17;
    }
    if (section == 2) {
        return 17;
    }
    return 0;
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
