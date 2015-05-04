//
//  CMCMaiDanDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMaiDanDetailVC.h"
#import "CMCInfoCell.h"
#import "CMCGoodsInfoCell.h"
#import "CneeInfoCell.h"
#import "OrderDetailModel.h"
#import "CMCMyOrderEvaluateVC.h"
#import "CMCCommentCell.h"
#import "CMCPhotoDisPlayVC.h"



@interface CMCMaiDanDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)OrderDetailModel *myModel;
@property (nonatomic,assign)BOOL isHaveEval;
@property (nonatomic,strong)NSDictionary *evalDic;


@end

@implementation CMCMaiDanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    
}


#pragma mark - 创建子视图  －

- (void)createSubViews{
    
    [self setupTableView];
    [self createRightBtt];
    
}

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}

- (void)createRightBtt{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"去评价" style:UIBarButtonItemStylePlain target:self action:@selector(gotoEvaluate:)];
    [rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

////去评价
- (void)gotoEvaluate:(UIButton *)button
{
    CMCMyOrderEvaluateVC *myOrderEvaluateVC = [[CMCMyOrderEvaluateVC alloc] init];
    myOrderEvaluateVC.mid = self.dataModel.mid;
    myOrderEvaluateVC.order_id = self.myModel.order_id;
    myOrderEvaluateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myOrderEvaluateVC animated:YES];
    
}



#pragma mark - 加载数据 －
- (void)loadData{
    
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":self.dataModel.id,@"timestamp":timestamp};
    NSLog(@"dic ========%@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *requestUrl = kAPI_getMyorderDetail(timestamp, [CMCUserManager shareManager].token, sig, self.dataModel.id);
    NSLog(@"requestUrl ==========%@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"respondObject =======%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] integerValue] == 0) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            
            //判断是否有评论
            if ([[dataDic objectForKey:@"eval"] isKindOfClass:[NSArray class]]) {
                self.isHaveEval = NO;
                
            }
            if ([[dataDic objectForKey:@"eval"] isKindOfClass:[NSDictionary class]]) {
                self.isHaveEval = YES;
                self.evalDic = [dataDic objectForKey:@"eval"];
                self.navigationItem.rightBarButtonItem = nil;
            }
            
            self.myModel = [[OrderDetailModel alloc]init];
            [self.myModel setValuesForKeysWithDictionary:dataDic];
            [_myTableView reloadData];
        } else {
            [BaseUtil toast:@"服务端数据错误"];
            
        }
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
}



#pragma mark - tableviewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isHaveEval) {
        return 3;
    }
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:( UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.1;
    }
    
    return 25;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 0);
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGRect rect = [BaseUtil returnHeightWithContent:[NSString stringWithFormat:@"商家地址：%@",self.myModel.merchant_address] WithFont:15 width:245 height:0];
        return rect.size.height + 135;
        
    }
    
    //如果有评论
    if (indexPath.section == 2) {
        NSString *contentStr = [self.evalDic objectForKey:@"content"];
        CGRect rect = [CMCUserManager _getSizeWithString:contentStr withWidth:self.view.width - 46 withHeight:20000];
        
        NSString *imageStr = [self.evalDic objectForKey:@"image"];
        CGFloat imgF = 0.0;
        if (imageStr.length > 1) {
            imgF = 40;
        }else{
            imgF = 0.0;
        }
        return 10 + 32 + 7.5 + rect.size.height + 10 + imgF;
        
    }
    
    return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CMCInfoCell *cell = [[CMCInfoCell alloc]init];
        cell.dataModel = self.dataModel;
        cell.myModel = self.myModel;
        return cell;
        
    }
    
    if (indexPath.section == 2) {
        CMCCommentCell *cell = [[CMCCommentCell alloc]init];
        cell.dataDic = self.evalDic;
        [cell setupTapBlock:^(int num) {
            CMCPhotoDisPlayVC *playVC = [[CMCPhotoDisPlayVC alloc]init];
            playVC.num = num + 1;
            
            NSString *imageStr = [self.evalDic objectForKey:@"image"];
            if (imageStr.length > 1) {
                NSArray *imgArr = [imageStr componentsSeparatedByString:@","];
                NSMutableArray *dataArr = [NSMutableArray array];
                for (NSString *string in imgArr) {
                    
                    [dataArr addObject:string];
                }
                
                playVC.dataArr = [NSArray arrayWithArray:dataArr];
                [self.navigationController pushViewController:playVC animated:YES];
            }
            
            
        }];
        
        return cell;
    }
    
    //总金额
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = @"总金额";
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",self.dataModel.money];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
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
