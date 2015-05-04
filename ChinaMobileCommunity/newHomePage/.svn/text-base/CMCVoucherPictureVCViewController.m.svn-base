//
//  CMCVoucherPictureVCViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVoucherPictureVCViewController.h"
#import "CMCVouchersTopTableViewCell.h"

@interface CMCVoucherPictureVCViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *DgArr;
@property (nonatomic, strong) NSMutableArray *youhuiArr;
@property (nonatomic, strong) NSString *discription;
@property (nonatomic, strong) NSMutableArray *goods_nameArr,*idArr,*numArr;
@property (nonatomic, strong) NSString *before_price,*discount,*end_time,*id,*information,*is_all,*is_promise,*life,*notice,*price,*store_id,*titleStr,*type;
@end

@implementation CMCVoucherPictureVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图文详情";
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.idArr = [[NSMutableArray alloc] init];
    self.numArr = [[NSMutableArray alloc] init];
    self.imageArr = [[NSMutableArray alloc] init];
    [self _creatTableView];
    [self loadData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)loadData
{
//    [self.imageArr removeAllObjects];
//    NSDictionary *dic = @{@"id":self.coupon_id};
//    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponDetail];
//    NSLog(@"优惠详情  %@",postDic);
//    NSDictionary *infoDic = [postDic objectForKey:@"info"];
//    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
//        if ([postDic objectForKey:@"data"]) {
//            NSDictionary *dataDic = [postDic objectForKey:@"data"];
//            self.before_price = [dataDic objectForKey:@"before_price"];
//            self.discription = [dataDic objectForKey:@"description"];
//            NSArray *disgoodsArr= [dataDic objectForKey:@"dis_goods"];
//            if (disgoodsArr.count) {
//                if ([[disgoodsArr objectAtIndex:0] isKindOfClass:[NSArray class]]) {
//                    NSArray *disgoodArr2 = [disgoodsArr objectAtIndex:0];
//                    for (NSString *tempDic in disgoodArr2) {
//                        [self.goods_nameArr addObject:tempDic];
//                        
//                    }
//                    
//                }
//                if ([[disgoodsArr lastObject] isKindOfClass:[NSDictionary class]]) {
//                    for (NSDictionary *tempDic in disgoodsArr) {
//                        [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
//                    }
//                }
//                
//                self.discount = [dataDic objectForKey:@"discount"];
//                self.end_time = [dataDic objectForKey:@"end_time"];
//                self.id = [dataDic objectForKey:@"id"];
//                for (NSString *str in [dataDic objectForKey:@"image"]) {
//                    [self.imageArr addObject:str];
//                }
//                self.information = [dataDic objectForKey:@"information"];
//                self.is_all = [dataDic objectForKey:@"is_all"];
//                self.is_promise = [dataDic objectForKey:@"is_promise"];
//                self.life = [dataDic objectForKey:@"life"];
//                self.notice = [dataDic objectForKey:@"notice"];
//                self.price = [dataDic objectForKey:@"price"];
//                self.store_id = [dataDic objectForKey:@"store_id"];
//                self.titleStr = [dataDic objectForKey:@"title"];
//                self.type = [dataDic objectForKey:@"type"];
//                self.myTableView.hidden = NO;
//                [self.myTableView reloadData];
//            }
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

#pragma mark - 自定义方法 －

- (void)_creatTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.hidden = YES;
    
    [self.view addSubview:self.myTableView];
}
#pragma mark - delegate代理方法 -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.goods_nameArr.count;
    }
    if (section == 1) {
        if (self.notice) {
            return 1;
        }
    }
    if (section == 2) {
        if (self.imageArr) {
            return 1;
        }
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        return 40;
    }
    if (indexPath.section == 1) {
        if (self.notice) {
            return 350;
        }
    }
    if (indexPath.section == 2) {
        if (self.imageArr) {
            if (self.imageArr.count % 2 == 0 ) {
                return self.imageArr.count/2 *125;
            } else {
                return (self.imageArr.count/2 + 1) * 125;
                
                
            }
        }
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"reused";
    CMCVouchersTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCVouchersTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    
    
    if (indexPath.section == 0) {
        if (self.goods_nameArr) {
            //            [cell creatOfferDetailsCellNameLabel:[self.dis_goodsArr objectAtIndex:indexPath.row]];
//            [cell creatOfferDetailsCellNameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] numberLabel:[self.numArr objectAtIndex:indexPath.row]];
//            [cell creatOfferDetailsCellNameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] numberLabel:@""];
            [cell creatOfferDetailsCellNameLabel:[self.goods_nameArr objectAtIndex:indexPath.row] numberLabel:@"" priceText:@""];

        }
        
    }
    
    if (indexPath.section == 1) {
        if (self.life) {
            [cell creatPurchaseInformationVailLabel:self.life detailInfomationLabel:self.is_promise detailRuleLabel:self.notice];
        }
        
        
    }
    if (indexPath.section == 2) {
        [cell creatGraphicDetailsCellArr:self.imageArr];
    }
    
    
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
        
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 50)];
        labelView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:labelView];
        
                    UILabel *presentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 109, 30)];
                    presentPriceLabel.text = [NSString stringWithFormat:@"现价￥%@",self.price];
                    presentPriceLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
                    presentPriceLabel.font = [UIFont systemFontOfSize:18.0];
                    [labelView addSubview:presentPriceLabel];
                    UILabel *originalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentPriceLabel.frame.size.width + 5, 20, 40, 20)];
                    originalPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.before_price];
                    originalPriceLabel.textColor = [UIColor colorWithHexString:@"666666"];
                    originalPriceLabel.font = [UIFont systemFontOfSize:12.0];
                    [labelView addSubview:originalPriceLabel];
                    UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(presentPriceLabel.frame.size.width + 2, 30, 44, 1)];
                    middleImageView.backgroundColor = [UIColor lightGrayColor];
                    [labelView addSubview:middleImageView];
                    UIButton *buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
                    //        buyNowButton.backgroundColor = [UIColor colorWithHexString:@"65b9fc"];
                    buyNowButton.frame = CGRectMake(self.view.bounds.size.width - 106, 5, 92, 35);
                    [buyNowButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
                    [buyNowButton addTarget:self action:@selector(didClickbuyNowButton:) forControlEvents:UIControlEventTouchUpInside];
                    [labelView addSubview:buyNowButton];
        
        

        
        return labelView;
    }
    
    
    return nil;
    
}
- (void)didClickbuyNowButton:(UIButton *)button
{
    
    
    
    
}
//- (void)didClickdownButton:(UIButton *)button
//{
//    NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"id":self.coupon_id}
//    ;
//    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponBuy];
//    NSDictionary *infoDic = [postDic objectForKey:@"info"];
//    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
//        if ([postDic objectForKey:@"data"]) {
//            [BaseUtil toast:@"下载成功"];
//        } else {
//            [BaseUtil toast:@"下载失败"];
//            
//            
//        }
//        
//    }
//    
//    
//}

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
