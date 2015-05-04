//
//  CMCDicAndVoucherVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDicAndVoucherVC.h"
#import "CMCInofCell.h"
#import "CMCDateInfoCell.h"
#import "CMCDiscountDetailCell.h"
#import "CMCBuyMustKnowCell.h"
#import "CMCBuyVoucherVC.h"
#import "CMCDiscoutDetailModel.h" //折扣券model
#import "CMCVouchersDetailModel.h" //优惠券model
#import "CMCMyScrollView.h"

@interface CMCDicAndVoucherVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

//@property (nonatomic,strong)UIImageView *bannerImgV;
@property (nonatomic,strong)CMCMyScrollView *bannerScrollV;

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *couponArr;

@property (nonatomic, strong) NSMutableArray *vouchersArr;
@property (nonatomic, strong) NSString *phone;

@end

@implementation CMCDicAndVoucherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.category;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.couponArr = [[NSMutableArray alloc] init];
    self.vouchersArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    [self createSubViews];
    [self loadData];
}
- (void)loadData
{
    [self.couponArr removeAllObjects];
    [self.vouchersArr removeAllObjects];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"coupon_id":self.coupon_id,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    //    NSString *requestUrl = kAPI_getCouponDetail(self.coupon_id, timestamp);
    NSString *requestUrl = kAPI_getCouponDetail(self.coupon_id, timestamp, [BaseUtil md5:sig]);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"优惠券详情 %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                if ([self.category isEqualToString:@"折扣券详情"]) {
                    NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                    CMCDiscoutDetailModel *couponDetailModel = [[CMCDiscoutDetailModel alloc] initWithCouponDetailModel:dataDic];
                    NSString *image = [dataDic objectForKey:@"image"];
                    NSLog(@"image ====== %@",image);
                    NSArray *imageArr = [image componentsSeparatedByString:@","];
                    NSMutableArray *urlArr = [NSMutableArray array];
                    for (int i = 0; i < imageArr.count - 1; i++) {
                      NSURL *url = [BaseUtil systemRandomlyGenerated:imageArr[i]    type:@"20" number:@"1"];
                        [urlArr addObject:url];
                    }
                    _bannerScrollV.dataArr = urlArr;
                    [self.couponArr addObject:couponDetailModel];
                    [self.myTableView reloadData];
                }
                if ([self.category isEqualToString:@"代金券详情"]) {
                    if ([respondObject objectForKey:@"data"]) {
                        NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                        //将优惠券详情的数据缓存到本地
                        [[NSUserDefaults standardUserDefaults] setObject:dataDic forKey:@"voucherDetails"];
                        CMCVouchersDetailModel *vouchersDetail = [[CMCVouchersDetailModel alloc] initWithVouchersDetailModel:dataDic];
                        NSString *image = [dataDic objectForKey:@"image"];
                    
                        
                        NSArray *imageArr = [image componentsSeparatedByString:@","];
                        NSMutableArray *urlArr = [NSMutableArray array];
                        for (int i = 0; i < imageArr.count - 1; i++) {
                            NSURL *url = [BaseUtil systemRandomlyGenerated:imageArr[i]    type:@"20" number:@"6"];
                            [urlArr addObject:url];
                        }
                        _bannerScrollV.dataArr = urlArr;
                        [self.vouchersArr addObject:vouchersDetail];
                        
                        [self.myTableView reloadData];
                    }
                    
                }
                
            }
        }
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

#pragma mark - 创建子视图-
- (void)createSubViews{
    [self setupBanner];
    [self setupTableView];
    
    
}
- (void)setupBanner{
//    _bannerImgV = [[UIImageView alloc]init];
//    _bannerImgV.frame = CGRectMake(0, 0, self.view.width, 160);
//    _bannerImgV.image = [UIImage imageNamed:@"log"];
    _bannerScrollV = [[CMCMyScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 160) animationDuration:2];
    
}

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = _bannerScrollV;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
}


#pragma mark - tableviewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 48;
    }
    if (section == 1) {
        return 26;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一分区
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *content ;
            CGFloat width = 0.0;
            if ([self.category isEqualToString:@"折扣券详情"]) {
                if (self.couponArr.count) {
                    CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                    content = couponDetail.address;
                    width = self.view.width - 32;
                }
                
            }
            
            if ([self.category isEqualToString:@"代金券详情"]) {
                
                if (self.vouchersArr.count) {
                    CMCVouchersDetailModel *couponDetail = [self.vouchersArr objectAtIndex:0];
                    content = couponDetail.address;
                    width = 250;
                }
            }
            
            CGRect rect = [BaseUtil returnHeightWithContent:content WithFont:12 width:width height:0];
            
            return rect.size.height + 70;
            
        }
        if (indexPath.row == 1) {
            if ([self.category isEqualToString:@"折扣券详情"]) {
                return 50;
            }else{
                return 68;
            }
        }
    }
    
    //第二分区
    if (indexPath.section == 1) {
        NSString *content ;
        
        if ([self.category isEqualToString:@"折扣券详情"]) {
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                content = couponDetail.intro;
            }
            
        }
        
        if ([self.category isEqualToString:@"代金券详情"]) {
            
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *couponDetail = [self.vouchersArr objectAtIndex:0];
                content = couponDetail.intro;
            }
        }
        
        CGRect rect = [BaseUtil returnHeightWithContent:content WithFont:12.0 width:self.view.width - 32 height:0];
        
        return rect.size.height + 20;
    }
    
    //第三分区
    if (indexPath.section == 2) {
        
        NSString *content ;
        
        if ([self.category isEqualToString:@"折扣券详情"]) {
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                content = couponDetail.notice;
            }
            
        }
        
        if ([self.category isEqualToString:@"代金券详情"]) {
            
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *couponDetail = [self.vouchersArr objectAtIndex:0];
                content = couponDetail.notice;
            }
        }
        
        CGRect rect = [BaseUtil returnHeightWithContent:content WithFont:12.0 width:self.view.width - 32 height:0];
        
        return rect.size.height + 20;
    }
    
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        if ([self.category isEqualToString:@"折扣券详情"]) {
            return 1;
        }else{
            return 1;
        }
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 30);
    view.backgroundColor = k_color(@"f5f4f4");
    
    //第一分区
    if (section == 0) {
        UILabel *priceL = [[UILabel alloc]init];
        priceL.frame = CGRectMake(10, 14, 50, 22);
        priceL.font = k_font(18);
        priceL.textColor = k_color(@"ff0200");
        [view addSubview:priceL];
        
        //立即下载和立即购买
        UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
        btt.frame = CGRectMake(self.view.width - 11 - 79, 11, 79, 27);
        [btt addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
        btt.titleLabel.font = k_font(12);
        [btt setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        if ([self.category isEqualToString:@"折扣券详情"]) {
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                priceL.text = [NSString stringWithFormat:@"%@折",couponDetail.discount];
                
                
            }
            [btt setTitle:@"立即下载" forState:UIControlStateNormal];
            
        }else{
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                priceL.text = [NSString stringWithFormat:@"¥ %@",vouchersDetail.money_buy];
                 CGRect rect = [BaseUtil returnHeightWithContent:priceL.text WithFont:18 width:0 height:18];//0318
                priceL.frame = CGRectMake(10, 14,rect.size.width,22);
                
                [btt setTitle:@"立即购买" forState:UIControlStateNormal];
                UILabel *oldPL = [[UILabel alloc]init];
                oldPL.frame = CGRectMake(priceL.right + 8,25, 40, 10);
                oldPL.font = k_font(10);
                oldPL.textColor = k_color(@"acacac");
                oldPL.text = [NSString stringWithFormat:@"¥%@",vouchersDetail.money_use];
                //                [BaseUtil setCenterLineView:oldPL];
                
                [view addSubview:oldPL];
            }else {
                
                //                priceL.text = [NSString stringWithFormat:@"¥ %@",couponDetail.money_buy];
                [btt setTitle:@"立即购买" forState:UIControlStateNormal];
                UILabel *oldPL = [[UILabel alloc]init];
                oldPL.frame = CGRectMake(priceL.right + 8,25, 40, 10);
                oldPL.font = k_font(10);
                oldPL.textColor = k_color(@"acacac");
                //                if (self.vouchersArr.count) {
                //                    CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                //                    oldPL.text = [NSString stringWithFormat:@"¥%@",vouchersDetail.money_use];
                //                    [BaseUtil setCenterLineView:oldPL];
                //                }
                
                
            }
            
            
        }
        [view addSubview:btt];
        
        
    }
    
    //第二分区
    if (section == 1 | section == 2) {
        UILabel *nameL = [[UILabel alloc] init];
        nameL.frame = CGRectMake(0, 10, self.view.width, 13);
        nameL.textColor = k_color(@"444444");
        nameL.font = k_font(13);
        if (section == 1) {
            nameL.text = @"   优惠详情";
        }else{
            nameL.text = @"   购买须知";
        }
        [view addSubview:nameL];
    }
    
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //折扣券详情
    if ([self.category isEqualToString:@"折扣券详情"]) {
        if (indexPath.row == 0 && indexPath.section == 0) {
            CMCInofCell *cell = [[CMCInofCell alloc]init];
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                cell.couponDetail = couponDetail;
                cell.category = self.category;
                [cell setupPhoneBlock:^(NSString *phoneNumber) {
                    NSLog(@"phoneNumber = %@",phoneNumber);
                }];
            }
            
            return cell;
        }
        if (indexPath.row == 1 && indexPath.section == 0) {
            CMCDateInfoCell *cell = [[CMCDateInfoCell alloc]init];
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                cell.couponDetail = couponDetail;
            }
            cell.category = self.category;
            return cell;
        }
        if (indexPath.section == 1) {
            static NSString *cellIndentifier = @"discountDetailCell";
            
            CMCDiscountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (nil == cell) {
                cell = [[CMCDiscountDetailCell alloc]init];
                cell.category = self.category;
            }
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                cell.textLabel.text = couponDetail.intro;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
            }
            return cell;
        }
        if (indexPath.section == 2) {
            static NSString *cellIndentifier = @"discountMustKnowCell";
            CMCBuyMustKnowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (nil == cell) {
                cell = [[CMCBuyMustKnowCell alloc]init];
            }
            if (self.couponArr.count) {
                CMCDiscoutDetailModel *couponDetail = [self.couponArr objectAtIndex:0];
                cell.discountModel = couponDetail;
            }
            
            cell.category = self.title;
            return cell;
        }
        
    }
    
    if ([self.category isEqualToString:@"代金券详情"]) {
        if (indexPath.row == 0 && indexPath.section == 0) {
            CMCInofCell *cell = [[CMCInofCell alloc]init];
            cell.category = self.category;
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                cell.vouchersModel = vouchersDetail;
            }
            
            [cell setupPhoneBlock:^(NSString *phoneNumber) {
                //打电话
                [self phoneWithphoneNumber:phoneNumber];
                self.phone = phoneNumber;
                
            }];
            return cell;
        }
        
        if (indexPath.row == 1 && indexPath.section == 0) {
            CMCDateInfoCell *cell = [[CMCDateInfoCell alloc]init];
            cell.category = self.category;
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                cell.vouchersModel = vouchersDetail;
            }
            return cell;
        }
        
        if (indexPath.section == 1) {
            static NSString *cellIndentifier = @"vouchDetailcell";
            CMCDiscountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (nil == cell) {
                cell = [[CMCDiscountDetailCell alloc]init];
                cell.category = self.category;
            }
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                cell.vouchersModel = vouchersDetail;
                cell.textLabel.text = vouchersDetail.intro;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
            }
            return cell;
        }
        if (indexPath.section == 2) {
            static NSString *cellIndentifier = @"voucherMustKnowCell";
            CMCBuyMustKnowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (nil == cell) {
                cell = [[CMCBuyMustKnowCell alloc]init];
            }
            if (self.vouchersArr.count) {
                CMCVouchersDetailModel *vouchersDetail = [self.vouchersArr objectAtIndex:0];
                cell.vouchersModel = vouchersDetail;
            }
            cell.category = self.title;
            return cell;
        }
        
        
    }
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
    
}


- (void)phoneWithphoneNumber:(NSString *)phoneNum{
    UIAlertView *arlerView = [[UIAlertView alloc]initWithTitle:@"选择操作" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话:%@",phoneNum],@"取消", nil];
    [arlerView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phone]]];
        
    }
    
    
}


#pragma mark - 立即下载，立即购买 －
- (void)downloadAction:(UIButton *)sender{
    
    if ([self.category isEqualToString:@"折扣券详情"]) {
//        [BaseUtil toast:@"优惠券已下载，可在我的券包里查看"];
        if ([CMCUserManager shareManager].token) {
            NSString *timestamp = kAPI_timestamp;
            NSDictionary *dic =@{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"coupon_id":self.coupon_id,@"timestamp":timestamp};
            NSString *sig= [BaseUtil getSigWithArray:dic];
            NSString *requestStr = KAPI_DownCoupon([CMCUserManager shareManager].token, timestamp, [BaseUtil md5:sig], self.coupon_id);
            [BaseUtil get:requestStr success:^(id respondObject) {
                NSLog(@"下载折扣: %@",respondObject);
                NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    if ([self.category isEqualToString:@"折扣券详情"]) {
                        [BaseUtil toast:@"折扣券下载成功，请到我的券包查看"];
                    }else{
                        [BaseUtil toast:@"购买成功"];
                    }
                }
            } failure:^(NSError *error) {
                
            }];
        } else {
            
        }
        
    }
    
    if ([self.category isEqualToString:@"代金券详情"]) {
        CMCBuyVoucherVC *buyV = [[CMCBuyVoucherVC alloc]init];
        [self.navigationController pushViewController:buyV animated:YES];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_bannerScrollV.animationTimer invalidate];
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
