//
//  CMCPacketVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPacketVC.h"
#import "CMCPacketCell.h"
#import "CMCPaketDetailVC.h"
#import "CMCPacket.h"

@interface CMCPacketVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _page;

}

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *packetArr;

@end

@implementation CMCPacketVC
- (NSMutableArray *)packetArr
{
    if (_packetArr == nil) {
        _packetArr = [NSMutableArray array];
    }
    return _packetArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"社区红包";
    // Do any additional setup after loading the view.
    _page = 1;
    [self createHeaderView];
    [self showRefreshHeader:YES];
    [self createSubViews];
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

#pragma mark - 创建子视图 － 
- (void)createSubViews{
    
    [self setupTableView];
    
}

//tableview
- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
}
- (void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    if (aRefreshPos == EGORefreshHeader) {
        //上拉刷新
        _page = 1;
    } else {
    //下拉加载
        _page ++;
    
    }

    [self loadData];


}
#pragma mark - 加载数据- 

- (void)loadData{
    if (_page == 1) {
        [self.packetArr removeAllObjects];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MyBonus(pageStr, timestamp, sig);
    NSLog(@"我的红包 url ===== %@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"我的红包 respondObject ====== %@",respondObject);
        
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCPacket *packet = [[CMCPacket alloc] initWithPacketDic:tempDic];
                    [self.packetArr addObject:packet];
                }

                [self.myTableView reloadData];
                [self finishReloadingData];
                [self setFooterView];
            } else {
                [BaseUtil toast:@"数据已加载完毕"];
            
            
            }

        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}




#pragma mark - tableviewDelegate - 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.packetArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndetifier = @"cell";
    CMCPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (nil == cell) {
        cell = [[CMCPacketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }

    if (self.packetArr.count) {
        CMCPacket *packet = [self.packetArr objectAtIndex:indexPath.row];
        cell.packet = packet;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CMCPacket *packet = [self.packetArr objectAtIndex:indexPath.row];
    CMCPaketDetailVC *detailVC = [[CMCPaketDetailVC alloc]init];
    detailVC.bonusID = packet.bonus_id;
    detailVC.dataModel = packet;//0318
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
