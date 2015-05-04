//
//  CMCPayCostViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-13.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPayCostViewController.h"
#import "CMCManagementFeeVC.h"
#import "CMCGasFeeViewController.h"
#import "CMCElectricityViewController.h"
#import "CMCWaterBillDetailVC.h"
#import "CMCParkingViewController.h"
#import "CMCPropertyFeeListViewController.h"

@interface CMCPayCostViewController ()
{

    NetWorkRequest *_request;
}
@property (nonatomic, strong) NSMutableArray *buttonImageArr;
@property (nonatomic, strong) NSMutableArray *buttonTitleArr;
@property (nonatomic, strong) NSMutableArray *addressArr;
@property (nonatomic, strong) NSMutableArray *center_idArr;
@property (nonatomic, strong) NSMutableArray *idArr;
@property (nonatomic, strong) NSMutableDictionary *addressByidDic;//通过id获取地址

@end

@implementation CMCPayCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.addressArr = [[NSMutableArray alloc] init];
    self.center_idArr = [[NSMutableArray alloc] init];
    self.idArr = [[NSMutableArray alloc] init];
    self.addressByidDic = [[NSMutableDictionary alloc] init];
    

    self.buttonImageArr = [[NSMutableArray alloc] initWithObjects:@"property_fee",@"water_fee",@"gas_fee",@"electricity_fee",@"parking_fee", nil];
    self.buttonTitleArr = [[NSMutableArray alloc] initWithObjects:@"物业费",@"水费",@"煤气费",@"电费",@"停车费", nil];
    [self creatButton];

}


- (void)creatButton
{
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            if (i*3+j > self.buttonImageArr.count - 1) {
                return;
            }
            
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(10 + 100*j, 0+100*i, 100, 100)];
            tempView.tag = 4000 + i*3+j;
            [self.view addSubview:tempView];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 60, 60)];
            imageView.image =[UIImage imageNamed:[self.buttonImageArr objectAtIndex:i*3+j]];
            [tempView addSubview:imageView];
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.text = [self.buttonTitleArr objectAtIndex:i*3+j];
            nameLabel.font = [UIFont systemFontOfSize:12.0];
            [tempView addSubview:nameLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickButton:)];
            [tempView addGestureRecognizer:tap];

        }
        
    }
}
- (void)didClickButton:(UITapGestureRecognizer *)button
{
//    k_propertyAddress
    NSLog(@"kAPI_Property ===========%@",k_propertyAddress);
    if (![k_propertyAddress isKindOfClass:[NSDictionary class]] && [k_propertyAddress objectForKey:@"id"]) {
        return;
    }
    switch (button.view.tag - 4000) {
        case 0:
        {
            //物业费
            //
            CMCPropertyFeeListViewController *propertyFeeListVC = [[CMCPropertyFeeListViewController alloc] init];
            propertyFeeListVC.title = @"物业费";
            propertyFeeListVC.owner_id = [BaseUtil getPropertyAddressValue:@"id"];
            propertyFeeListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyFeeListVC animated:YES];

            
        }
            break;
        case 1:
        {
            //水费
            CMCPropertyFeeListViewController *propertyFeeListVC = [[CMCPropertyFeeListViewController alloc] init];
            propertyFeeListVC.title = @"水费";
            propertyFeeListVC.owner_id = [BaseUtil getPropertyAddressValue:@"id"];
            propertyFeeListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyFeeListVC animated:YES];
            
        }
            
            break;
        case 2:
        {
//            //燃气费
//            CMCGasFeeViewController *waterBillDetailVC = [[CMCGasFeeViewController alloc] init];
//            waterBillDetailVC.hidesBottomBarWhenPushed = YES;
//            waterBillDetailVC.addressByidDic = self.addressByidDic;
//            
//            [self.navigationController pushViewController:waterBillDetailVC animated:YES];
            //水费
            CMCPropertyFeeListViewController *propertyFeeListVC = [[CMCPropertyFeeListViewController alloc] init];
            propertyFeeListVC.title = @"煤气费";
            propertyFeeListVC.owner_id = [BaseUtil getPropertyAddressValue:@"id"];
            propertyFeeListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyFeeListVC animated:YES];
            
        }
            
            break;
        case 3:
        {
            //电费
//            CMCElectricityViewController *waterBillDetailVC = [[CMCElectricityViewController alloc] init];
//            waterBillDetailVC.hidesBottomBarWhenPushed = YES;
//            waterBillDetailVC.addressByidDic = self.addressByidDic;
//            [self.navigationController pushViewController:waterBillDetailVC animated:YES];
            CMCPropertyFeeListViewController *propertyFeeListVC = [[CMCPropertyFeeListViewController alloc] init];
            propertyFeeListVC.title = @"电费";
            propertyFeeListVC.owner_id = [BaseUtil getPropertyAddressValue:@"id"];
            propertyFeeListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyFeeListVC animated:YES];
            
        }
            
            break;
        case 4:
        {
            //停车费
//            CMCParkingViewController *waterBillDetailVC = [[CMCParkingViewController alloc] init];
//            waterBillDetailVC.hidesBottomBarWhenPushed = YES;
//            waterBillDetailVC.addressByidDic = self.addressByidDic;
//            [self.navigationController pushViewController:waterBillDetailVC animated:YES];
            CMCPropertyFeeListViewController *propertyFeeListVC = [[CMCPropertyFeeListViewController alloc] init];
            propertyFeeListVC.title = @"停车费";
            propertyFeeListVC.owner_id = [BaseUtil getPropertyAddressValue:@"id"];
            propertyFeeListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:propertyFeeListVC animated:YES];
            
        }
            
            break;

        default:
            break;
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
