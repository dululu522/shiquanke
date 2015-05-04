//
//  CMCTakeOutDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCTakeOutDetailVC.h"
#import "CMCInfoCell.h"
#import "CMCGoodsInfoCell.h"
#import "CneeInfoCell.h"
#import "CMCMyOrderEvaluateVC.h"
#import "OrderDetailModel.h"
#import "CMCBestPayModel.h"
#import "CMCCommentCell.h"
#import "CMCPhotoDisPlayVC.h"

@interface CMCTakeOutDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UIView *bottomView;
    UIButton *cancleBtt;
    
}
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)OrderDetailModel *myModel;
@property (nonatomic,assign)BOOL isHaveEval;
@property (nonatomic,strong)NSDictionary *evalDic;


@end

@implementation CMCTakeOutDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
//    self.dataModel.state = @"8";
//    self.dataModel.payment_type = @"0";
    
    [self createSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    
}


#pragma mark - 创建子视图  －
- (void)createSubViews{
    
    [self setupTableView];
    [self setupBottomView];
    [self createRightBtt];
    [self againFrame];//根据不同情况创建不同的控件
    
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

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 63 - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}
- (void)setupBottomView{
    bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0,self.view.height - 126, self.view.width, 63);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    cancleBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtt.frame = CGRectMake(15, 11,self.view.width - 30, 41);
    [cancleBtt setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancleBtt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtt setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [cancleBtt addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancleBtt];
}


- (void)againFrame{
    //线下支付
    if ([[self returnWithPayment_type:self.dataModel.payment_type] isEqualToString:@"货到付款"]) {
        //未接单
        if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"未接单"] |[[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"未付款"]) {
            
            //取消订单
  
            
        }else if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已完成"]){
            //完成订单可以评价，否则不能评价
//           [self createRightBtt];
            
        }else if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已接单"]){//0317
            //确认订单
            [cancleBtt setTitle:@"确认订单" forState:UIControlStateNormal];
            
        }else{
            //不能取消订单
            [bottomView removeFromSuperview];//取消订单标识去除
            _myTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
            
        }
        
        
    }
    
    
    
    //线上支付
    if (![[self returnWithPayment_type:self.dataModel.payment_type] isEqualToString:@"货到付款"]) {
        //未付款
        if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"未付款"]) {
            //去付款
            //取消订单
            NSLog(@"付款取消订单");
            [self btt];
            
        }else if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已拒单"] | [[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已取消"]){
            
            [bottomView removeFromSuperview];//移除
            _myTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
            
            
        }else if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state]isEqualToString:@"已完成"]){
            
            [bottomView removeFromSuperview];//移除
            _myTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
//            [self createRightBtt];//可以评价
            
        }else{
            //确认订单
            [cancleBtt setTitle:@"确认订单" forState:UIControlStateNormal];
            
        }
    }
    
    
}

//去付款，取消订单之类的
- (void)btt{
    _myTableView.frame = CGRectMake(0, 0, self.view.width,self.view.height - 118 - 64);
    bottomView.frame = CGRectMake(0,self.view.height - 118 - 64, self.view.width, 126);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 11,self.view.width - 30, 41);
    [button setTitle:@"去付款" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    cancleBtt.frame = CGRectMake(15, button.bottom + 10,self.view.width - 30, 41);
    [cancleBtt setBackgroundImage:[UIImage imageNamed:@"取消订单"] forState:UIControlStateNormal];
    [cancleBtt setTitleColor:kAPI_AllMainColor forState:UIControlStateNormal];
    
}

#pragma mark - 抢单响应的方法 －
- (void)cancleAction:(UIButton *)sender{
//    NSLog(@"取消订单");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":self.myModel.order_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        NSString *url = KAPI_orderCancel(self.myModel.order_id, timestamp, sig);
        [BaseUtil get:url success:^(id respondObject) {
            NSLog(@"取消订单-----------%@",respondObject);
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject  withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[[[respondObject objectForKey:@"info"]objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
                [BaseUtil toast:@"已取消"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            return ;
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"取消失败，稍后再试"];
        }];
    }
    if ([sender.titleLabel.text isEqualToString:@"确认订单"]) {//0317
        NSString *url = KAPI_orderFinish(self.myModel.order_id, timestamp, sig);
        [BaseUtil get:url  success:^(id respondObject) {
            NSLog(@"====respondObject====== %@",respondObject);
            if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
                [BaseUtil toast:@"确认成功"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"确认失败"];
                
            }
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [BaseUtil toast:@"确认失败"];
            
        }];
        
    }
    
    
    
}

- (void)payAction:(UIButton *)sender{
    NSLog(@"去付款");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":self.myModel.order_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_orderPay(self.myModel.order_id, timestamp, sig);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"去付款-----------%@",respondObject);
        if ([[[[respondObject objectForKey:@"info"]objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            NSString *money = [dataDic objectForKey:@"money"];
            NSString *order_id = [dataDic objectForKey:@"order_id"];
           
            
            //跳转支付宝
            //外卖类有物流费用
            if ([[BaseUtil returnProcessWithService_id:self.dataModel.service_id]isEqualToString:@"H"]){
                if ([money floatValue] < [[CMCUserManager shareManager].order_money floatValue]) {
                    float p = [money floatValue] + [[CMCUserManager shareManager].express_money floatValue];
                    NSString *price = [NSString stringWithFormat:@"%.2f",p];
                    
                    //翼支付
                    if ([self.dataModel.payment_type isEqualToString:@"2"]) {
                        CMCBestPayModel *model = [[CMCBestPayModel alloc] init];
                        [model bestWithOrder_id:order_id money:price];
                    }
                    //支付宝
                    if ([self.dataModel.payment_type isEqualToString:@"1"]) {
                      [BaseUtil PaymentForGoodsTradeNO:order_id productName:@"订单详情" amount:price];
                    }
                    
                }else {
                    
                    //翼支付
                    if ([self.dataModel.payment_type isEqualToString:@"2"]) {
                        CMCBestPayModel *model = [[CMCBestPayModel alloc] init];
                        [model bestWithOrder_id:order_id money:money];
                    }
                    
                    //支付宝
                    if ([self.dataModel.payment_type isEqualToString:@"1"]) {
                        [BaseUtil PaymentForGoodsTradeNO:order_id productName:@"订单详情" amount:money];
                    }
                    
                }
                
            } else {
            
                //翼支付
                if ([self.dataModel.payment_type isEqualToString:@"2"]) {
                    CMCBestPayModel *model = [[CMCBestPayModel alloc] init];
                    [model bestWithOrder_id:order_id money:money];
                }
                
                //支付宝
                if ([self.dataModel.payment_type isEqualToString:@"1"]) {
                    [BaseUtil PaymentForGoodsTradeNO:order_id productName:@"订单详情" amount:money];
                }
            
            
            }
            
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        return ;
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [BaseUtil toast:@"取消失败，稍后再试"];
    }];
    
    
    
    
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
    if ([self.dataModel.service_id isEqualToString:@"5"]) {//优惠
        return 2;
    }
    if (self.isHaveEval) {
        return 4;
    }
    
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
        if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已拒单"]) {
            return 190;
        }
        CGRect rect = [BaseUtil returnHeightWithContent:[NSString stringWithFormat:@"商家地址：%@",self.myModel.merchant_address] WithFont:15 width:245 height:0];
        return rect.size.height + 135;
    }
    if (indexPath.section == 1) {
        
        if ([self.dataModel.service_id isEqualToString:@"8"]) {//房源信息
            return 260;
        }
        if ([self.dataModel.service_id isEqualToString:@"7"]) {//家政服务
            return 75;
        }
        if ([self.dataModel.service_id isEqualToString:@"4"]) {//订做
            return 120;
        }
        //优惠
        if ([self.dataModel.service_id isEqualToString:@"5"]) {
            return 70;
        }
        
        
        //如果是外卖类
        if ([[BaseUtil returnProcessWithService_id:self.dataModel.service_id] isEqualToString:@"H"]) {
            NSArray *detailArr = [self.myModel.detail componentsSeparatedByString:@"|"];
            if ([[BaseUtil returnCategoryWithService_id:self.dataModel.service_id WithState:self.dataModel.state] isEqualToString:@"已拒单"] && ![self.dataModel.payment_type isEqualToString:@"0"]) {//需要退款得时候
                
                return 23 * detailArr.count + 50 + 10 + 25 + 25 + 25;
                
            }else{
                
                return 23 * detailArr.count + 50 + 10 + 25 + 25;
                
            }
        }
        
        NSArray *detailArr = [self.myModel.detail componentsSeparatedByString:@"|"];
        return 23 * detailArr.count + 50 + 10 + 25;
    }
    
    
    if (indexPath.section == 2) {
        if ([[BaseUtil returnProcessWithService_id:self.dataModel.service_id] isEqualToString:@"S"] | [self.dataModel.service_id isEqualToString:@"7"] | [self.dataModel.service_id isEqualToString:@"8"]) {
            return 70;
        }
    }
    
    //如果有评论
    if (indexPath.section == 3) {
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
    
    
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CMCInfoCell *cell = [[CMCInfoCell alloc]init];
        cell.dataModel = self.dataModel;
        cell.myModel = self.myModel;
        return cell;
        
    }    
    if (indexPath.section == 1) {
        if ([self.dataModel.service_id isEqualToString:@"5"]) {
            //收货人信息
            CneeInfoCell *cell = [[CneeInfoCell alloc]init];
            cell.dataModel = self.dataModel;
            cell.myModel = self.myModel;
            return cell;
        }
        CMCGoodsInfoCell *cell = [[CMCGoodsInfoCell alloc]init];
        cell.dataModel = self.dataModel;
        cell.myModel = self.myModel;
        return cell;
    }
    
    if (indexPath.section == 3) {
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
    
    //收货人信息
    CneeInfoCell *cell = [[CneeInfoCell alloc]init];
    cell.dataModel = self.dataModel;
    cell.myModel = self.myModel;
    return cell;
}


#pragma mark - 公共方法 － 
- (NSString *)returnWithPayment_type:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        return @"货到付款";
    }
    if ([type isEqualToString:@"1"]) {
        return @"支付宝";
    }
    
    return @"翼支付";
    
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