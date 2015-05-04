//
//  CMCVoucherDetailsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVoucherDetailsVC.h"
//#import "CycleScrollView.h"
#import "CMCMyScrollView.h"
#import "CMCVouchersTopTableViewCell.h"
//#import "CMCPictureVC.h"
#import "CMCVoucherPictureVCViewController.h"
#import "UIColor+ChangeColor.h"
@interface CMCVoucherDetailsVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CMCMyScrollView *mainScorllView;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *DgArr;
@property (nonatomic, strong) NSMutableArray *youhuiArr;
@property (nonatomic, strong) NSString *discription;
@property (nonatomic, strong) NSMutableArray *goods_nameArr,*idArr,*numArr;
@property (nonatomic, strong) NSString *before_price,*discount,*end_time,*id,*information,*is_all,*is_promise,*life,*notice,*price,*store_id,*titleStr,*type;

@end

@implementation CMCVoucherDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageArr = [[NSMutableArray alloc] init];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.idArr = [[NSMutableArray alloc] init];
    self.numArr = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.mainScorllView = [[CMCMyScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 180) animationDuration:2];
    self.tableView.tableHeaderView = self.mainScorllView;
//    [self creatScrollView];
    [self loadData];
    [self creatScrollView];
    [self creatTop];
}
- (void)creatTop
{
    //    NSLog(@"呵呵呵呵呵呵 %f",self.tableView.contentOffset.y);
    //        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    //        labelView.backgroundColor = [UIColor whiteColor];
    //        [self.view addSubview:labelView];
    //        UILabel *presentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 109, 30)];
    //
    //        presentPriceLabel.text = [NSString stringWithFormat:@"现价￥%@",self.price];
    //        presentPriceLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
    //        presentPriceLabel.font = [UIFont systemFontOfSize:18.0];
    //        [labelView addSubview:presentPriceLabel];
    //
    //        UILabel *originalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentPriceLabel.frame.size.width + 5, 20, 40, 20)];
    //        originalPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.before_price];
    //        originalPriceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //        originalPriceLabel.font = [UIFont systemFontOfSize:12.0];
    //        [labelView addSubview:originalPriceLabel];
    //
    //        UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(presentPriceLabel.frame.size.width + 2, 30, 44, 1)];
    //        middleImageView.backgroundColor = [UIColor lightGrayColor];
    //        [labelView addSubview:middleImageView];
    //
    //        UIButton *buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
    //        //        buyNowButton.backgroundColor = [UIColor colorWithHexString:@"65b9fc"];
    //        buyNowButton.frame = CGRectMake(self.view.bounds.size.width - 106, 5, 92, 35);
    //        [buyNowButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    //        [buyNowButton addTarget:self action:@selector(didClickbuyNowButton:) forControlEvents:UIControlEventTouchUpInside];
    //        [labelView addSubview:buyNowButton];
    
    
    
}
- (void)loadData
{
//    [self.dis_goodsArr removeAllObjects];
//    [self.imageArr removeAllObjects];
//    [self.goods_nameArr removeAllObjects];
//    [self.idArr removeAllObjects];
//    [self.numArr removeAllObjects];
//    NSDictionary *dic = @{@"id":self.coupon_id};
//    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponDetail];
//    NSLog(@"优惠券 =====请求的url ========%@",kAPI_getCouponDetail);
//    NSDictionary *infoDic = [postDic objectForKey:@"info"];
//    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
//        if ([postDic objectForKey:@"data"]) {
//            NSDictionary *dataDic = [postDic objectForKey:@"data"];
//            self.before_price = [dataDic objectForKey:@"before_price"];
//            self.discription = [dataDic objectForKey:@"description"];
//            NSArray *disgoodsArr= [dataDic objectForKey:@"dis_goods"];
//            NSLog(@"优惠券 代金券 =============%@",disgoodsArr);
//            self.is_all = [dataDic objectForKey:@"is_all"];
//            if ([self.is_all intValue] == 1) {
//                
//            } else {
//                if (disgoodsArr.count) {
//                    if ([[disgoodsArr objectAtIndex:0] isKindOfClass:[NSArray class]]) {
//                        if ([disgoodsArr objectAtIndex:0]) {
//                            NSArray *disgoodArr2 = [disgoodsArr objectAtIndex:0];
//                            for (NSString *tempDic in disgoodArr2) {
//                                [self.goods_nameArr addObject:tempDic];
//                                
//                            }
//                            
//                        }
//                        
//                    }
//                    if ([[disgoodsArr lastObject] isKindOfClass:[NSDictionary class]]) {
//                        for (NSDictionary *tempDic in disgoodsArr) {
//                            if ([tempDic objectForKey:@"goods_name"]) {
//                                [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
//                            }
//                            
//                        }
//                    }
//
//            
//            }
//                self.discount = [dataDic objectForKey:@"discount"];
//                self.end_time = [dataDic objectForKey:@"end_time"];
//                self.id = [dataDic objectForKey:@"id"];
//                for (NSString *str in [dataDic objectForKey:@"image"]) {
//                    [self.imageArr addObject:str];
//                }
//                self.information = [dataDic objectForKey:@"information"];
//                self.is_promise = [dataDic objectForKey:@"is_promise"];
//                self.life = [dataDic objectForKey:@"life"];
//                self.notice = [dataDic objectForKey:@"notice"];
//                self.price = [dataDic objectForKey:@"price"];
//                self.store_id = [dataDic objectForKey:@"store_id"];
//                self.titleStr = [dataDic objectForKey:@"title"];
//                self.type = [dataDic objectForKey:@"type"];
//                [self creatScrollView];
//                
//                [self.tableView reloadData];
//
//            }
//
//            
//        } else {
//            
//            [BaseUtil toast:@"没有相关的数据"];
//        }
//    } else {
//        [BaseUtil toast:@"服务端无响应"];
//        
//    }
    
}

//创建scrollview
- (void)creatScrollView
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.imageArr.count; i++) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:[self.imageArr objectAtIndex:i] type:@"20" number:@"6"];
        [arr addObject:url];
    }
    self.mainScorllView.dataArr = arr;
    [self.mainScorllView setupTapActionBlock:^(NSInteger pageIndex) {
        NSLog(@"%ld",(long)pageIndex);
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.titleStr) {
            return 1;
        }
    }
    if (section == 1) {
        if ([self.is_all isEqualToString:@"1"]) {
            return 1;
        }
        if ([self.is_all isEqualToString:@"0"]) {
            return self.goods_nameArr.count;

        }
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        if (self.notice) {
            return 1;
            
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    CMCVouchersTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCVouchersTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if (indexPath.section == 0) {
        NSLog(@"self.end_time =======%@",self.end_time);
        [cell creatCellVouchersLable:self.titleStr detailLabel:self.information flashLabel:self.end_time];
    }
    
    if (indexPath.section == 1) {
//        [cell creatOfferDetailsCellNameLabel:[self.goods_nameArr objectAtIndex:indexPath.row]];
        if ([self.is_all isEqualToString:@"0"]) {
                    [cell creatOfferDetailsCellNameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] numberLabel:nil priceText:nil];
        }
        if ([self.is_all isEqualToString:@"1"]) {
            cell.textLabel.text = @"适用于本店全部商品";
            cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];

        }
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"查看图文详情";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 3) {
        [cell creatPurchaseInformationVailLabel:self.life detailInfomationLabel:self.is_promise detailRuleLabel:self.notice];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 2) {
//        
//        CMCVoucherPictureVCViewController *pictureVC = [[CMCVoucherPictureVCViewController alloc] init];
//        pictureVC.coupon_id = self.coupon_id;
//        [self.navigationController pushViewController:pictureVC animated:YES];
//        
//    }
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 144;
    }
    if (indexPath.section == 1) {
        return 40;
    }
    if (indexPath.section == 2) {
        return 35;
    }
    if (indexPath.section == 3) {
        return 350;
    }
    return 0;
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 50)];
        labelView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:labelView];
        
       
            UILabel *presentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 30)];
            presentPriceLabel.text = [NSString stringWithFormat:@" ￥%@",self.price];
            presentPriceLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
            presentPriceLabel.font = [UIFont systemFontOfSize:18.0];
            [labelView addSubview:presentPriceLabel];
            UILabel *originalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, presentPriceLabel.frame.size.height +presentPriceLabel.frame.origin.y, 200, 20)];
            originalPriceLabel.text = [NSString stringWithFormat:@" ￥%@",self.before_price];
            originalPriceLabel.textColor = [UIColor colorWithHexString:@"666666"];
            originalPriceLabel.font = [UIFont systemFontOfSize:12.0];
            [labelView addSubview:originalPriceLabel];
        [BaseUtil setCenterLineView:originalPriceLabel];
//            UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(presentPriceLabel.frame.size.width + 2, 30, 44, 1)];
//            middleImageView.backgroundColor = [UIColor lightGrayColor];
//            [labelView addSubview:middleImageView];
            UIButton *buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
            //        buyNowButton.backgroundColor = [UIColor colorWithHexString:@"65b9fc"];
            buyNowButton.frame = CGRectMake(self.view.bounds.size.width - 106, 5, 92, 35);
            [buyNowButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
            [buyNowButton addTarget:self action:@selector(didClickbuyNowButton:) forControlEvents:UIControlEventTouchUpInside];
            [labelView addSubview:buyNowButton];
        
        return labelView;
    }
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"优惠详情";
        label.textColor = [UIColor colorWithHexString:@"666666"];
        return label;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
        
    }
    if (section == 1) {
        return 35;
    }
    if (section == 3) {
        return 15;
    }
    
    return 0;
}

- (void)didClickbuyNowButton:(UIButton *)button
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"id":self.coupon_id};
    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponBuy];
    NSLog(@"代金券购买 ======= %@",postDic);
    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"info"] intValue] == 0) {
        if ([postDic objectForKey:@"data"]) {
            NSDictionary *dataDic = [postDic objectForKey:@"data"];
            NSDictionary *dataDicTwo = [dataDic objectForKey:@"data"];
            NSArray *goodslistArr = [dataDicTwo objectForKey:@"goodslist"];
            NSDictionary *allGoodDic = [goodslistArr objectAtIndex:0];
            NSLog(@"allGoodDic == %@",allGoodDic);
            [BaseUtil PaymentForGoodsTradeNO:[dataDicTwo objectForKey:@"order_id"] productName:[allGoodDic objectForKey:@"goods_name"] amount:[dataDicTwo objectForKey:@"pay"]];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } else {
            [BaseUtil toast:@"暂时不能购买"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
        
    }else {
        
        [BaseUtil toast:@"购买失败,请重新购买"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    }

    
    
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
