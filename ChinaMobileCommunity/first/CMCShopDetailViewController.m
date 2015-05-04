//
//  CMCShopDetailViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailViewController.h"
#import "CMCShopDetailTopTVCell.h"
#import "CMCShopDetailButtonTVCell.h"
#import "CMCShopDetailIntroductionTVCell.h"
#import "CMCManySpeciesTVCell.h"
#import "CMCNetCommentsTVCell.h"

//#import "CMCOrderFoodsVC.h"
#import "CMCOrderViewController.h"
#import "CMCFoodDetail.h"
#import "CMCFoodDetailEvaluation.h"
#import "CMCTakeOutTableVC.h"
#import "CMCOnlineBookingVC.h"
#import "CMCPayViewController.h"
#import "CMCYouHuiVC.h"

#import "TCShopStoreServiceTableViewCell.h"
static BOOL isTure ;
@interface CMCShopDetailViewController ()
{
//    BOOL _selectRow;
//    BOOL choose;
    
}


@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *foodDetailArr;//店铺详情列表
@property (nonatomic, strong) NSMutableArray *numberArr;// 是否有此项功能
@property (nonatomic, strong) NSMutableArray *unImageArr;//没有此项功能的图片
@property (nonatomic, strong) NSMutableArray *evaluationArr; //评价
@property (nonatomic, strong) NSString *merchant_name;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong)  UITableView *listTableView;
@property (nonatomic, strong) NSString *phone;

@end

@implementation CMCShopDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    _selectRow = NO;
    self.title = @"店铺详情";
    
    self.evaluationArr = [[NSMutableArray alloc] init];
    self.foodDetailArr = [[NSMutableArray alloc] init];
    
    isTure = YES;
    [self creatTableView];
    
    [self loadData];
    [self creatServiceButton];
    
    [BaseUtil setExtraCellLineHidden:self.detailTableView];
    
    //    [self loadEvaluationData];
    
    
    
}

- (void)creatTableView
{

    self.imageArr = [[NSMutableArray alloc] init];
    self.titleArr = [[NSMutableArray alloc] init];
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [self.view addSubview:_detailTableView];
    //    [self didClickserviceButton];
    
}
- (void)creatServiceButton
{
    //服务
    UIButton *serviceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 53, 33)];
    [serviceButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [serviceButton setTitle:@"服务" forState:UIControlStateNormal];
    serviceButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(didClickserviceButton) forControlEvents:UIControlEventTouchUpInside];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:serviceButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}
#pragma mark -
#pragma mark - didClickserviceButton
- (void)didClickserviceButton
{
    
    if (isTure == YES) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 94, 0, 94, self.titleArr.count*44)];
        _listTableView.hidden = NO;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [self.view addSubview:_listTableView];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        isTure = NO;
    } else if (isTure == NO) {

        [_listTableView removeFromSuperview];
        isTure = YES;
    }
    //
    
    
    
}
//返回
- (void)didClickBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)loadData
{
    
    [self.foodDetailArr removeAllObjects];
    NSDictionary *dic = @{@"merchant_id":self.merchant_id};
    
    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getmerchantnews];
    
    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    NSLog(@"postDic 店铺详情 ===%@",postDic);
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        NSArray *dataArr = [postDic objectForKey:@"data"];
        for (NSDictionary *tempDic in dataArr) {
            CMCFoodDetail *foodDetail = [[CMCFoodDetail alloc] initWithDetailFood:tempDic];
            [self.foodDetailArr addObject:foodDetail];
            if ([[tempDic objectForKey:@"order_state"] intValue] == 1) {
                [self.titleArr addObject:@"点餐"];
                [self.imageArr addObject:@"home_order"];
            }
            if ([[tempDic objectForKey:@"schedule_state"] intValue] == 1) {
                [self.titleArr addObject:@"预订"];
                [self.imageArr addObject:@"home_booking"];
                
            }
            if ([[tempDic objectForKey:@"check_state"] intValue] == 1) {
                [self.titleArr addObject:@"买单"];
                [self.imageArr addObject:@"home_pay"];
                
            }
            if ([[tempDic objectForKey:@"takeout_state"] intValue] == 1) {
                [self.titleArr addObject:@"外卖"];
                [self.imageArr addObject:@"home_takeout"];
                
            }
            if ([[tempDic objectForKey:@"coupon_state"] intValue] == 1) {
                [self.titleArr addObject:@"优惠"];
                [self.imageArr addObject:@"home_preferential"];
            }
            
        }
        [self didClickserviceButton];
        [_detailTableView reloadData];
    }
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.detailTableView == tableView) {
        if (section == 0 || section == 1 || section == 2) {

            return self.foodDetailArr.count;
        }
      
        
    }
    
    if (self.listTableView == tableView) {
        return self.imageArr.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.detailTableView == tableView) {
        return 5;
    }
    
    return 1;
    //    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailTableView == tableView) {
        if (indexPath.section == 0) {
            static NSString *str = @"reused";
            CMCShopDetailTopTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[CMCShopDetailTopTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:indexPath.section];
                [cell creatTabelViewCellfood:foodDetail];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                return cell;
        }

        }
        
        
        
    }
    
    //    if (indexPath.section == 1) {
    //        static NSString *str1 = @"CMCShopDetailButtonTVCell";
    //        CMCShopDetailButtonTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
    //        if (cell == nil) {
    //            cell = [[CMCShopDetailButtonTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    //        }
    //        cell.delegate = self;
    ////    [cell creatButtonImageStr:self.imageArr  labelStr:self.buttonArr];
    ////        NSLog(@"self.numberArr.count   ===%d",self.numberArr.count);
    ////        CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
    //        NSLog(@"********%@",self.numberArr);
    //
    //        if (self.numberArr) {
    //            [cell creatButtonImageStr:self.imageArr labelStr:self.buttonArr unAbleNumberArr:self.numberArr unAbleImageArr:self.unImageArr];
    //        }
    //
    //        CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:indexPath.section];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    //
    //        return cell;
    //    }
    //餐厅简介
    if (indexPath.section == 1) {
        static NSString *str = @"CMCShopDetailIntroductionTVCell";
        CMCShopDetailIntroductionTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCShopDetailIntroductionTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        if (self.foodDetailArr.count == 0) {
            
        } else {
            CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
            if (indexPath.row == 0) {
                [cell creatTitleLabel:@"餐厅简介" contentLabel:foodDetail.merchant_content
                 ];
                
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    if (indexPath.section == 2) {
        static NSString *str = @"reused";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
        
        cell.textLabel.text = foodDetail.phone;

        self.phone = foodDetail.phone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        return cell;
    }
    if (self.listTableView == tableView) {
        static NSString *str = @"TCShopStoreServiceTableViewCell";
        TCShopStoreServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[TCShopStoreServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        [cell creatImageView:[self.imageArr objectAtIndex:indexPath.row] title:[self.titleArr objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 0 || indexPath.section == 1) {
    //        return 120;
    //
    //    }
    //    if (indexPath.section == 2 ) {
    //        if (indexPath.row == 0) {
    //            return 64;
    //
    //        }
    //        if (indexPath.row == 1) {
    //            return 44;
    //        }
    //
    //    }
    //
    //    if (indexPath.section == 3) {
    //            return 64;
    //
    //    }
    //    if (indexPath.section == 4) {
    //
    //        return 200;
    //    }
    if (self.detailTableView == tableView) {
        if (indexPath.section == 0) {
            return 120;
            
        }
        if (indexPath.section == 1) {
            return 100;
        }
        if (indexPath.section == 2) {
            return 44;
        }
        
    }
    if (self.listTableView == tableView) {
        return 44;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 1) {
//        return 30;
//    }
    //    if (section == 2) {
    //        return 10;
    //    }
    //    if (section == 3) {
    //        return 10;
    //    }
    //    if (section == 4) {
    //        return 30;
    //    }
    
    
    return 0;
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (self.detailTableView == tableView) {
//        if (section == 1) {
//            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 100, 30)];
//            titleView.backgroundColor = [UIColor whiteColor];
//            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            titleButton.frame =CGRectMake(0, 0, self.view.bounds.size.width, 30);
//            [titleView addSubview:titleButton];
//            [titleButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
//            
//            titleButton.imageEdgeInsets = UIEdgeInsetsMake(10, self.view.bounds.size.width - 20, 0, 0);
//            //            [titleButton addTarget:self action:@selector(didClickTitleButton) forControlEvents:UIControlEventTouchUpInside];
//            [titleView addSubview:titleButton];
//            [titleButton setTitle:@"餐厅简介:" forState:UIControlStateNormal];
//            [titleButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -titleButton.titleLabel.bounds.size.width-150 , 0, 100);
//            return titleView;
//            
//            
//        }
//        if (section == 4) {
//            UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
//            labelView.backgroundColor = [UIColor whiteColor];
//            
//            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            titleButton.frame =CGRectMake(0, 0, self.view.bounds.size.width, 30);
//            [labelView addSubview:titleButton];
//            [titleButton setImage:[UIImage imageNamed:@"detail_indicator"] forState:UIControlStateNormal];
//            titleButton.imageEdgeInsets = UIEdgeInsetsMake(10, self.view.bounds.size.width - 20, 10, 10);
//            [titleButton addTarget:self action:@selector(didClickTitleButton) forControlEvents:UIControlEventTouchUpInside];
//            [labelView addSubview:titleButton];
//            [titleButton setTitle:@"网友点评" forState:UIControlStateNormal];
//            [titleButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -titleButton.titleLabel.bounds.size.width-150 , 0, 100);
//            //        titleButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//            
//            
//            return labelView;
//        }
//        
//    }
    
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listTableView == tableView) {
        if ([CMCUserManager shareManager].token) {
            if ([[self.titleArr objectAtIndex:indexPath.row] isEqualToString:@"点餐"]) {
                                    CMCOrderViewController *orderVC = [[CMCOrderViewController alloc] init];
                                    CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
                                    orderVC.merchant_id = foodDetail.merchant_id;
                                    orderVC.merchant_name = foodDetail.merchant_name;
                                    [self.navigationController pushViewController:orderVC animated:YES];
            }
            if ([[self.titleArr objectAtIndex:indexPath.row] isEqualToString:@"预订"]) {
                                    CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
                                    CMCOnlineBookingVC *onLineBookVC = [[CMCOnlineBookingVC alloc] init];
                                    onLineBookVC.merchant_id = foodDetail.merchant_id;
                                    onLineBookVC.title = @"在线预订";
                                    onLineBookVC.merchant_name = foodDetail.merchant_name;
                                    [self.navigationController pushViewController:onLineBookVC animated:YES];
            }
            if ([[self.titleArr objectAtIndex:indexPath.row] isEqualToString:@"买单"]) {
                                    CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
                                    //买单
                                    CMCPayViewController *payVC = [[CMCPayViewController alloc] init];
                                    payVC.merchant_name = foodDetail.merchant_name;
                                    [self.navigationController pushViewController:payVC animated:YES];
            }
            if ([[self.titleArr objectAtIndex:indexPath.row] isEqualToString:@"外卖"]) {
                                    CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
                                    CMCTakeOutTableVC *takeOutVC = [[CMCTakeOutTableVC alloc] init];
                                    takeOutVC.title = @"外卖菜单";
                                    takeOutVC.merchant_name = foodDetail.merchant_name;
                                    takeOutVC.merchant_id = foodDetail.merchant_id;
                                    [self.navigationController pushViewController:takeOutVC animated:YES];
            }
            if ([[self.titleArr objectAtIndex:indexPath.row] isEqualToString:@"优惠"]) {
                                    CMCYouHuiVC *youHuiVC = [[CMCYouHuiVC alloc]init];
                                    youHuiVC.title = @"优惠";
                                    CMCFoodDetail *foodDetail = [self.foodDetailArr objectAtIndex:0];
                                    youHuiVC.store_id = foodDetail.merchant_id ;
                                    youHuiVC.hidesBottomBarWhenPushed = YES;
                                    [self.navigationController pushViewController:youHuiVC animated:YES];
            }
        } else {
                                CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
                                [self.navigationController pushViewController:loginVC animated:YES];
        
        }

        
        
    }
    if (self.detailTableView == tableView) {
        
        [_listTableView removeFromSuperview];
        isTure = YES;
        if (indexPath.section == 2) {
            UITableViewCell *cell = (UITableViewCell *)[self.detailTableView cellForRowAtIndexPath:indexPath];
//            [BaseUtil callAndBack:cell.textLabel.text];
            [BaseUtil callAndBackWeb:cell.textLabel.text];
        }
    }
    
    
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return @"餐厅简介:";
//    }
//    return nil;
//
//}
#pragma mark-
#pragma mark- 点击网友点评
//- (void)didClickTitleButton
//{
//    
//    if (number %2 == 0) {
//        _selectRow = NO;
//        //        [self.detailTableView reloadData];
//        
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
//        [self.detailTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    } else {
//        _selectRow = YES;
//        //        [self.detailTableView reloadData];
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
//        [self.detailTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }
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
