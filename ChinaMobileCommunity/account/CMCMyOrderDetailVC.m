//
//  CMCMyOrderDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderDetailVC.h"
#import "CMCMyOrderDetailTableViewCell.h"
#import "CMCMyOrderEvaluateVC.h"
#import "CMCFoodMyOrder.h"
#import "CMCOrderWithoutPaymentDetailVC.h"  //未支付订单详情
#import "CMCCouponOrderDetailVC.h" //优惠券订单详情
#import "CMCOrderOrderDetailVC.h" //点菜订单详情
#import "CMCFirstServiceEvaluationVC.h" //评价
#import "CMCVouchersTopTableViewCell.h"

@interface CMCMyOrderDetailVC ()
{

    UIImageView *_photoImageView;
    UILabel *_rightlabel;
    NSInteger _page;
    UIView *_backView;

    NSInteger _allNumber;//总份数
    float _allPrice;//总价格

}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *foodMyOrderArr;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableDictionary *myOrderDic;
@property (nonatomic, strong) NSMutableArray *detailArr;
@end

@implementation CMCMyOrderDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.title = @"订单详情";
    self.myOrderDic = [[NSMutableDictionary alloc] init];
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];

    [self creatTableView];
    [BaseUtil setExtraCellLineHidden:self.myTableView];

    [self creatBackButton];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(10, self.view.frame.size.height - 120+7, self.view.frame.size.width -20, 40);
    payButton.backgroundColor = kAPI_AllMainColor;
    payButton.layer.cornerRadius = 5;
    [payButton setTitle:@"去付款" forState:UIControlStateNormal];
    [self.view addSubview:payButton];
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"去评价" style:UIBarButtonItemStylePlain target:self action:@selector(gotoEvaluate:)];
    [rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)creatTableView
{

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [_backView addSubview:self.myTableView];
    [self loadData];

}
////去评价
- (void)gotoEvaluate:(UIButton *)button
{
    CMCMyOrderEvaluateVC *myOrderEvaluateVC = [[CMCMyOrderEvaluateVC alloc] init];
    myOrderEvaluateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myOrderEvaluateVC animated:YES];


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
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                [_myOrderDic addEntriesFromDictionary:dataDic];
                NSLog(@"????????????_myOrderDic   %@",_myOrderDic);
                NSString *detail = [dataDic objectForKey:@"detail"];
               NSArray *arr = [detail componentsSeparatedByString:@"|"];
                self.detailArr = [[NSMutableArray alloc] initWithArray:arr];
                NSLog(@"self.detailArr %@",self.detailArr);
//                总份数
                if (arr.count) {
                    for (NSString *str in arr) {
                      NSArray *totalArr = [str componentsSeparatedByString:@","];
                        _allNumber += [[totalArr objectAtIndex:2] integerValue];
                        _allPrice += [[totalArr objectAtIndex:3] floatValue];
                    }
                }
                [self.myTableView reloadData];
            }

        } else {
            
            [BaseUtil toast:@"服务端数据错误"];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)creatBackButton
{
    //后退按钮
    //    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    
    UIView *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10,10, 20)];
    [backView addSubview:billImageView];
    
    billImageView.image = [UIImage imageNamed:@"后退_03"];
    billImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackBtn:)];
    [backView addGestureRecognizer:tap];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    
    //    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)didClickBackBtn:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)loadItems
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
        return self.detailArr.count;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CMCMyOrderDetailTableViewCell *cell = [[CMCMyOrderDetailTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myOrderDetailDic = _myOrderDic;
        [cell creatMyOrderDetailCell];
        
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *str = @"CMCVouchersTopTableViewCell";
        CMCVouchersTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCVouchersTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        [cell creatOfferDetailsCellNameLabel:@"肥牛套餐" numberLabel:@"1份" priceText:@"￥36"];
        if (self.detailArr.count) {
            cell.offerStr = [self.detailArr objectAtIndex:indexPath.row];
            [cell creatOfferDetailsCell];
        }
        return cell;
    }
    if (indexPath.section == 2) {
//        static NSString *str = @"CMCMyOrderDetailTableViewCell";
        CMCMyOrderDetailTableViewCell *cell = [[CMCMyOrderDetailTableViewCell alloc] init];
        
        cell.myOrderDetailDic = self.myOrderDic;
        cell.allNumber = _allNumber;
        cell.allPrice = _allPrice;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell creatMyOrderDetailCopyLabe];
        
//        [cell creatMyOrderDetailCopyLabelText:nil priceText:[NSString stringWithFormat:@"%f",_allPrice] onlinePay:nil note:nil];
        [cell creatMyOrderDetailCopyLabelText];
        
        return cell;
    }
    if (indexPath.section == 3) {
        CMCMyOrderDetailTableViewCell *cell = [[CMCMyOrderDetailTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myOrderDetailDic = self.myOrderDic;
        [cell creatName:@"姓名:natural" phone:@"手机号:13263446196"];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 136;
    }
    if (indexPath.section == 1) {
        return 40;
    }
    if (indexPath.section == 3) {
        return 50;
    }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 17;
    }
    if (section == 3) {
        return 17;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CMCFoodMyOrder *myOrder = [self.foodMyOrderArr objectAtIndex:indexPath.row];
//    if ([myOrder.status intValue] == 0) {
//                    //未付款详情
//                    CMCOrderWithoutPaymentDetailVC *orderWithoutPaymentDetailVC = [[CMCOrderWithoutPaymentDetailVC alloc] init];
////                    orderWithoutPaymentDetailVC.order_id = myOrder.order_num;
//                    orderWithoutPaymentDetailVC.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:orderWithoutPaymentDetailVC animated:YES];
//    }
//    //is_eval  0是未评价   1是已评价
//    if ([myOrder.status intValue] == 1&& [myOrder.is_eval intValue]== 0) {
//
//        CMCFirstServiceEvaluationVC *serviceVC = [[CMCFirstServiceEvaluationVC alloc] init];
//        serviceVC.order_id = myOrder.order_num;
//        serviceVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:serviceVC animated:YES];
//    }
//    if ([myOrder.status intValue] == 1 && [myOrder.is_eval intValue] == 1) {
//        //点菜订单已评价详情
//        CMCOrderOrderDetailVC *orderDetailVC = [[CMCOrderOrderDetailVC alloc] init];
//        orderDetailVC.hidesBottomBarWhenPushed = YES;
//        orderDetailVC.order_id = myOrder.order_num;
//        [self.navigationController pushViewController:orderDetailVC animated:YES];
//        
//
//    }
    
//    switch ([myOrder.status intValue]) {
//        case 0:
//        {
//            //未付款详情
//            CMCOrderWithoutPaymentDetailVC *orderWithoutPaymentDetailVC = [[CMCOrderWithoutPaymentDetailVC alloc] init];
//            orderWithoutPaymentDetailVC.order_id = myOrder.order_num;
//            orderWithoutPaymentDetailVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:orderWithoutPaymentDetailVC animated:YES];
//        }
//            break;
//        case 1:
//        {
//            //已付款
//            //点菜订单详情
//            CMCOrderOrderDetailVC *orderDetailVC = [[CMCOrderOrderDetailVC alloc] init];
//            orderDetailVC.hidesBottomBarWhenPushed = YES;
//            orderDetailVC.order_id = myOrder.order_num;
//            [self.navigationController pushViewController:orderDetailVC animated:YES];
//            
//            
//        }
//            break;
//        case 2:
//        {
////            //未付款详情
////            CMCOrderWithoutPaymentDetailVC *orderWithoutPaymentDetailVC = [[CMCOrderWithoutPaymentDetailVC alloc] init];
////            orderWithoutPaymentDetailVC.hidesBottomBarWhenPushed = YES;
////            [self.navigationController pushViewController:orderWithoutPaymentDetailVC animated:YES];
//        
//        
//        }
//            break;
//
//        case 3:
//        {
//            //优惠券订单详情
//            CMCCouponOrderDetailVC *couponOrderDetailVC = [[CMCCouponOrderDetailVC alloc] init];
//            couponOrderDetailVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:couponOrderDetailVC animated:YES];
//            
//            
//        }
//            break;
//        default:
//            break;
//    }



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
