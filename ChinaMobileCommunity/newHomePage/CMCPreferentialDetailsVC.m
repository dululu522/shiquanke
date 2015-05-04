//
//  CMCPreferentialDetailsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPreferentialDetailsVC.h"
#import "CMCMyScrollView.h"
#import "CMCVouchersTopTableViewCell.h"
#import "CMCPictureVC.h"
#import "UIColor+ChangeColor.h"


@interface CMCPreferentialDetailsVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CMCMyScrollView *mainScorllView;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *DgArr;
@property (nonatomic, strong) NSMutableArray *youhuiArr;
@property (nonatomic, strong) NSString *discription;
@property (nonatomic, strong) NSMutableArray *dis_goodsArr,*image;
@property (nonatomic, strong) NSString *before_price,*discount,*end_time,*id,*information,*is_all,*is_promise,*life,*notice,*price,*store_id,*titleStr,*type;
@end

@implementation CMCPreferentialDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dis_goodsArr = [[NSMutableArray alloc] init];
    self.imageArr = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self creatScrollView];
    [self loadData];
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
//    NSDictionary *dic = @{@"id":self.coupon_id};
//    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponDetail];
//    NSLog(@"优惠详情  %@",postDic);
//    NSDictionary *infoDic = [postDic objectForKey:@"info"];
//    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
//        if ([postDic objectForKey:@"data"]) {
//            NSDictionary *dataDic = [postDic objectForKey:@"data"];
//            self.before_price = [dataDic objectForKey:@"before_price"];
//            self.discription = [dataDic objectForKey:@"description"];
//            NSArray *dis_goodsArr = [dataDic objectForKey:@"dis_goods"];
////            NSArray *dis_goodsArr2 = [dis_goodsArr objectAtIndex:0];
//            for (NSString *str in dis_goodsArr) {
//                [self.dis_goodsArr addObject:str];
//            }
//            self.discount = [dataDic objectForKey:@"discount"];
//            self.end_time = [dataDic objectForKey:@"end_time"];
//            self.id = [dataDic objectForKey:@"id"];
//            for (NSString *str in [dataDic objectForKey:@"image"]) {
//                [self.imageArr addObject:str];
//            }
//            self.information = [dataDic objectForKey:@"information"];
//            self.is_all = [dataDic objectForKey:@"is_all"];
//            self.is_promise = [dataDic objectForKey:@"is_promise"];
//            self.life = [dataDic objectForKey:@"life"];
//            self.notice = [dataDic objectForKey:@"notice"];
//            self.price = [dataDic objectForKey:@"price"];
//            self.store_id = [dataDic objectForKey:@"store_id"];
//            self.titleStr = [dataDic objectForKey:@"title"];
//            self.type = [dataDic objectForKey:@"type"];
//            [self.tableView reloadData];
//            [self creatScrollView];
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
    if (self.imageArr.count) {
        for (int i = 0; i < self.imageArr.count; i++) {
            if ([[self.imageArr objectAtIndex:i] length]) {
                NSURL *url = [BaseUtil systemRandomlyGenerated:[self.imageArr objectAtIndex:i] type:@"20" number:@"5"];
                [arr addObject:url];
            }

        }
    }

    self.mainScorllView = [[CMCMyScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 180)];
    self.tableView.tableHeaderView = self.mainScorllView;
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
        }else {
            return self.dis_goodsArr.count;
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
        [cell creatCellVouchersLable:self.titleStr detailLabel:self.information flashLabel:self.end_time];
    }
    
    if (indexPath.section == 1) {
//        [cell creatOfferDetailsCellNameLabel:[self.dis_goodsArr objectAtIndex:indexPath.row]];
        if ([self.is_all isEqualToString:@"1"] ) {
            cell.textLabel.text = @"适用于本店全部商品";
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];


        } else {
//            [cell creatOfferDetailsCellNameLabel:[self.dis_goodsArr objectAtIndex:indexPath.row] numberLabel:@""];
            [cell creatOfferDetailsCellNameLabel:[self.dis_goodsArr objectAtIndex:indexPath.row] numberLabel:@"" priceText:@""];
        }

    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"查看图文详情";
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 3) {
        [cell creatPurchaseInformationVailLabel:self.life detailInfomationLabel:self.is_promise detailRuleLabel:self.notice];
        
    }
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    
    
    
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
//        [self.view addSubview:label]
//        return @" 优惠详情";
//    }
//
//
//    return nil;
//
//}


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
        
        UILabel *presentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 109, 30)];
            presentPriceLabel.text = [NSString stringWithFormat:@"%@折",self.discount];
            presentPriceLabel.textColor = [UIColor colorWithHexString:@"65b9fc"];
            presentPriceLabel.textAlignment = NSTextAlignmentCenter;
            presentPriceLabel.font = [UIFont systemFontOfSize:18.0];
            [labelView addSubview:presentPriceLabel];
            UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [downButton setTitle:@"立即下载" forState:UIControlStateNormal];
            //        buyNowButton.backgroundColor = [UIColor colorWithHexString:@"65b9fc"];
            downButton.frame = CGRectMake(self.view.bounds.size.width - 106, 5, 92, 35);
            [downButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
            [downButton addTarget:self action:@selector(didClickdownButton:) forControlEvents:UIControlEventTouchUpInside];
            [labelView addSubview:downButton];

        return labelView;
    }
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"优惠详情";
        label.textColor = [UIColor colorWithHexString:@"666666"];
        label.font = [UIFont systemFontOfSize:12];
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



}
- (void)didClickdownButton:(UIButton *)button
{

  NSDictionary *dic = @{@"token_agent":[CMCUserManager shareManager].token,@"id":self.coupon_id}
    ;
  NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponBuy];
    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([postDic objectForKey:@"data"]) {
            [BaseUtil toast:@"下载成功"];
        } else {
            [BaseUtil toast:@"下载失败"];

        
        }

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
