//
//  CMCConvenientLifeCouponsVCViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCConvenientLifeCouponsVC.h"
#import "CMCConvenientLifeDiscountCell.h"
#import "CMCCouponsModel.h"
#define CouponsType @"5"
#import "CMCDicAndVoucherVC.h"

@interface CMCConvenientLifeCouponsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)UIImageView *discountImgV;
@property (nonatomic,strong)UIImageView *voucherImgV;
@property (nonatomic,assign)BOOL isClickDiscount;
@property (nonatomic,assign)BOOL isClickVoucher;
@property (nonatomic,strong)NSMutableArray *discountArr; //折扣券
@property (nonatomic,strong)NSMutableArray *voucherArr; //代金券


@end

@implementation CMCConvenientLifeCouponsVC

- (NSMutableArray *)discountArr{
    if (_discountArr == nil) {
        //        self.discountArr = [NSMutableArray array];
        //        self.discountArr = [NSMutableArray arrayWithObjects:@"1",@"1",@"1", nil];
        self.discountArr = [NSMutableArray array];
        
    }
    return _discountArr;
}


- (NSMutableArray *)voucherArr{
    if (_voucherArr == nil) {
        //        self.voucherArr = [NSMutableArray array];
        //        self.voucherArr = [NSMutableArray arrayWithObjects:@"1",@"1",@"1", nil];
        self.voucherArr = [NSMutableArray array];
        
    }
    return _voucherArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"优惠券";
    self.isClickDiscount = NO;
    self.isClickVoucher = NO;
    // Do any additional setup after loading the view.
    [self createSubViews];
    [self loadData];
    
}

#pragma mark - 请求数据 －
- (void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.merchant_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MerchantCoupon(self.merchant_id, timestamp, sig);
    NSLog(@"优惠券url ==== %@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"优惠券 = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataDic = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataDic) {
                    if ([[tempDic objectForKey:@"type"] intValue] == 0) {
                        NSLog(@"%@",[tempDic objectForKey:@"address"]);
                        CMCCouponsModel *couponsModel = [[CMCCouponsModel alloc] initWithCouponsModelDic:tempDic];
                        [self.discountArr addObject:couponsModel];
                        
                    }
                    if ([[tempDic objectForKey:@"type"] intValue] == 1) {
                        NSLog(@"address  %@",[tempDic objectForKey:@"address"]);
                        
                        CMCCouponsModel *couponsModel = [[CMCCouponsModel alloc] initWithCouponsModelDic:tempDic];
                        [self.voucherArr addObject:couponsModel];
                    }
                }
                [self.myTableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } else {
                [BaseUtil toast:@"此服务暂无商品"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            
            
        } else {
            [BaseUtil toast:@"服务端返回数据错误"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}



#pragma mark - 创建子视图-

- (void)createSubViews{
    [self setupTableView];
    [self setupImageView];
}

- (void)setupTableView{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
}

- (void)setupImageView{
    
    _discountImgV = [[UIImageView alloc]init];
    _discountImgV.frame = CGRectMake(200, 15, 9, 9);
    _discountImgV.image = [UIImage imageNamed:@"convenience_down"];
    
    _voucherImgV = [[UIImageView alloc]init];
    _voucherImgV.frame = CGRectMake(200, 15, 9, 9);
    _voucherImgV.image = [UIImage imageNamed:@"convenience_down"];
    
    
}

#pragma mark - tableviewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //折扣券
    if (section == 0) {
        //        if (self.discountArr.count >2) {
        //            if (self.isClickDiscount) {
        //                return self.discountArr.count + 1;
        //            }else{
        //                return 3;
        //            }
        //        }
        //        if (self.discountArr.count <= 2) {
        //            return self.discountArr.count;
        //        }
        if (self.discountArr.count) {
            return self.discountArr.count;
            
        }
        return 0;
    }
    //代金券
    if (section == 1) {
        //        if (self.voucherArr.count >2) {
        //            if (self.isClickVoucher) {
        //                return self.voucherArr.count + 1;
        //            }else{
        //                return 3;
        //            }
        //        }
        //        if (self.voucherArr.count <= 2) {
        //            return self.voucherArr.count;
        //        }
        return self.voucherArr.count;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    //折扣券
    //    if (indexPath.section == 0) {
    //        if (self.discountArr.count > 2) {
    //            if (self.isClickDiscount) {
    //                if (indexPath.row == self.discountArr.count) {
    //                    return 37;
    //                }
    //            }else{
    //                if (indexPath.row == 2) {
    //                    return 37;
    //                }
    //            }
    //
    //        }
    //    }
    //    //代金券
    //    if (indexPath.section == 1) {
    //        if (self.voucherArr.count > 2) {
    //            if (self.isClickVoucher) {
    //                if (indexPath.row == self.voucherArr.count) {
    //                    return 37;
    //                }
    //            }else {
    //                if (indexPath.row == 2) {
    //                    return 37;
    //                }
    //            }
    //
    //        }
    //    }
    
    return 83;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 20);
    view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一分区 折扣券
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"DiscountCell";
        CMCConvenientLifeDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCConvenientLifeDiscountCell alloc]init];
        }
        cell.section = indexPath.section;
        CMCCouponsModel *couponsModel = [self.discountArr objectAtIndex:indexPath.row];
        cell.couponsModel = couponsModel;
        //        [cell setupDownLoadBlock:^{
        //            NSLog(@"下载折扣券");
        //        }];
        return cell;
        
        
    }
    //第二分区
    if (indexPath.section == 1) {
        static NSString *cellIndentifier = @"VoucherCell";
        CMCConvenientLifeDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCConvenientLifeDiscountCell alloc]init];
        }
        cell.section = indexPath.section;
        CMCCouponsModel *couponsModel = [self.voucherArr objectAtIndex:indexPath.row];
        cell.couponsModel = couponsModel;
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CMCCouponsModel *couponsModel = [self.discountArr objectAtIndex:indexPath.row];
        CMCDicAndVoucherVC *disVC = [[CMCDicAndVoucherVC alloc]init];
        disVC.category = @"折扣券详情";
        disVC.coupon_id = couponsModel.id;
        [self.navigationController pushViewController:disVC animated:YES];
    }
    if (indexPath.section == 1) {
        CMCCouponsModel *couponsModel = [self.voucherArr objectAtIndex:indexPath.row];
        CMCDicAndVoucherVC *disVC = [[CMCDicAndVoucherVC alloc]init];
        disVC.category = @"代金券详情";
        disVC.coupon_id = couponsModel.id;
        [self.navigationController pushViewController:disVC animated:YES];
    }
    
    //    CMCDicAndVoucherVC *disVC = [[CMCDicAndVoucherVC alloc]init];
    //    [self.navigationController pushViewController:disVC animated:YES];
    //
    //    if (tableView == _myTableView) {
    //        disVC.category = @"折扣券详情";
    //    }
    //
    //    if (tableView == _secondTableView) {
    //        disVC.category = @"代金券详情";
    //    }
    
    
    
    
    
    //    //折扣券
    //    if (indexPath.section == 0) {
    //        if (self.isClickDiscount) {
    //            self.isClickDiscount = NO;
    //            _discountImgV.image = [UIImage imageNamed:@"convenience_down"];
    //        }else{
    //            self.isClickDiscount = YES;
    //            _discountImgV.image = [UIImage imageNamed:@"convenience_top"];
    //        }
    //
    //
    //    }
    //
    //
    //    //代金券
    //    if (indexPath.section == 1) {
    //        if (self.isClickVoucher) {
    //            self.isClickVoucher = NO;
    //            _voucherImgV.image = [UIImage imageNamed:@"convenience_down"];
    //        }else{
    //            self.isClickVoucher = YES;
    //            _voucherImgV.image = [UIImage imageNamed:@"convenience_top"];
    //        }
    //    }
    //
    //    [_myTableView reloadData];
    //
    
    
}

- (UITableViewCell *)createCellWithIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *titleL = [[UILabel alloc]init];
    titleL.frame = CGRectMake(120, 13, 80, 11);
    titleL.textColor = [UIColor colorWithHexString:@"616161"];
    titleL.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        titleL.text = @"更多折扣券";
        [cell.contentView addSubview:_discountImgV];
    }else{
        titleL.text = @"更多代金券";
        [cell.contentView addSubview:_voucherImgV];
    }
    [cell.contentView addSubview:titleL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
