//
//  CMCOrderDtailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderDtailVC.h"
#import "CMCInfoCell.h"
#import "CMCGoodsInfoCell.h"
#import "CneeInfoCell.h"

@interface CMCOrderDtailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;

@end

@implementation CMCOrderDtailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createSubViews];
}

#pragma mark - 创建子视图  － 

- (void)createSubViews{
    
    [self setupTableView];
    [self setupBottomView];
}

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 63 - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}
- (void)setupBottomView{
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0,self.view.height - 126, self.view.width, 63);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 11,self.view.width - 30, 41);
    [button setTitle:@"取消订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(accpetAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    
}
#pragma mark - 抢单响应的方法 －
- (void)accpetAction:(UIButton *)sender{
    NSLog(@"取消订单");
    
}

#pragma mark - tableviewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.1;
    }
    if (section == 1) {
        return 20;
    }
    return 21;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 0);
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 155;
    }
    if (indexPath.section == 1) {
//        NSArray *detailArr = [self.myModel.detail componentsSeparatedByString:@"|"];
        NSArray *detailArr = [@"宫保鸡丁,1,30.00|宫保鸡丁,1,30.00|宫保鸡丁,1,30.00|宫保鸡丁,1,30.00" componentsSeparatedByString:@"|"];
        return 23 * detailArr.count + 50 + 10 + 25;
    }
    return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CMCInfoCell *cell = [[CMCInfoCell alloc]init];
//        cell.dataModel = self.dataModel;
//        cell.myModel = self.myModel;
        return cell;
        
    }
    if (indexPath.section == 1) {
        CMCGoodsInfoCell *cell = [[CMCGoodsInfoCell alloc]init];
//        cell.dataModel = self.dataModel;
//        cell.myModel = self.myModel;
        return cell;
    }
    //收货人信息
    CneeInfoCell *cell = [[CneeInfoCell alloc]init];
    return cell;
}


#pragma mark end
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
