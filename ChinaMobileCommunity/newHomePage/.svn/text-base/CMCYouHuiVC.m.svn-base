 //
//  CMCYouHuiVC.m
//  CMCYouHuiVC
//
//  Created by 武鹏 on 14-11-11.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import "CMCYouHuiVC.h"
#import "DiscountCell.h"
#import "ChitCell.h"
//#import "CMCMoreDiscountCell.h"
//#import "CMCYouHuiDetailVC.h"
#import "CMCVouchers.h"
#import "CMCDiscount.h"
#import "CMCPreferentialDetailsVC.h"
#import "CMCVoucherDetailsVC.h"
#import "MBProgressHUD.h"

static BOOL sectionOne;
static BOOL sectionTwo;

@interface CMCYouHuiVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *myTableView;//tableview
@property (nonatomic,assign)int numberOfRows; //分区1的单元格数
@property (nonatomic,assign)int numberOfRows2;//分区2的单元格数
@property (nonatomic,strong)NSMutableArray *dicountArr;//折扣券
//@property (nonatomic,strong)NSMutableArray *chitArr;//代金券
@property (nonatomic, strong) NSMutableArray *vouchersArr; //代金券

- (void)_createTableView;

@end

@implementation CMCYouHuiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createTableView];
//    self.numberOfRows = 3;
//    self.numberOfRows2 = 3;

    
    self.dicountArr = [[NSMutableArray alloc] init];
    self.vouchersArr = [[NSMutableArray alloc] init];
    sectionOne = NO;
    sectionTwo = NO;
    [self loadData];
    [self loadVouchersData];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 自定义方法 － 


- (void)_createTableView{
//    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) ];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor whiteColor];
//    _myTableView.rowHeight = 80;
    
    [BaseUtil setExtraCellLineHidden:self.myTableView];
    [self.view addSubview:_myTableView];
    
    

    
}
//加载折扣券数据
#pragma mark -
#pragma mark - 加载折扣券数据
- (void)loadData
{
    
    [self.dicountArr removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dic = @{@"store_id":self.store_id,@"type":@"1"};
    
   NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponList];
    NSLog(@"折扣券  %@",postDic);

    NSDictionary *infoDic = [postDic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([[postDic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *dataArr = [postDic objectForKey:@"data"];
            for (NSDictionary *tempDic in dataArr) {
                CMCDiscount *discount = [[CMCDiscount alloc] initWithDiscount:tempDic];
                [self.dicountArr addObject:discount];
                
            }
            //刷新第0分区的数据
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } else {
        
            [BaseUtil toast:@"暂时没有数据"];

            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            
        
        }
    }
    
}
#pragma mark -
#pragma mark - 加载代金券数据
- (void)loadVouchersData
{
    [self.vouchersArr removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"store_id":self.store_id,@"type":@"2"};
    NSDictionary *postDic = [BaseUtil postString:[dic JSONString] postUrlString:kAPI_getCouponList];
    NSLog(@"代金券 postDic === %@",postDic);
    NSDictionary *infoDic = [postDic objectForKey:@"info"];

    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([[postDic objectForKey:@"data"] isKindOfClass:[NSArray class]] ) {

            NSArray *dataArr = [postDic objectForKey:@"data"];
            for (NSDictionary *tempDic in dataArr) {
                
                CMCDiscount *discount = [[CMCDiscount alloc] initWithDiscount:tempDic];
                [self.vouchersArr addObject:discount];
                
            }

            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }else{
            [BaseUtil toast:@"暂时没有数据"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        }
    }
}


#pragma mark - 代理方法 － 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dicountArr.count > 2 && sectionOne == NO) {
            return 3;
        } else if (self.dicountArr.count > 2 && sectionOne == YES) {
            return self.dicountArr.count;
        } else {
            return self.dicountArr.count;
            
        }
        
        
    }
    if (section == 1) {
        if (self.vouchersArr.count > 2 && sectionTwo == NO) {
            return 3;
        } else if (self.vouchersArr.count > 2 && sectionTwo == YES) {
            return self.vouchersArr.count;
        } else{
            return self.vouchersArr.count;
            
        }

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *str = @"reused";
        DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[DiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        if (self.dicountArr.count > 2 && sectionOne == NO) {
            if (indexPath.row < 2) {
                CMCDiscount *disCount = [self.dicountArr objectAtIndex:indexPath.row];
                [cell creatCellDiscount:disCount];
            } else {
                cell.textLabel.text = @"加载更多折扣券";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            }
        } else if (self.dicountArr.count > 2 && sectionOne == YES){
        
                CMCDiscount *disCount = [self.dicountArr objectAtIndex:indexPath.row];
                [cell creatCellDiscount:disCount];
     
        
        
        
        }else {
            CMCDiscount *disCount = [self.dicountArr objectAtIndex:indexPath.row];
            [cell creatCellDiscount:disCount];
        
        }

        
//            [cell creatCellDiscount:disCount];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }

    if (indexPath.section == 1) {
        static NSString *str = @"ChitCell";

        ChitCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[ChitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            
        }
//        if (self.vouchersArr) {
//            CMCDiscount *disCount = [self.vouchersArr objectAtIndex:indexPath.row];
//            [cell creatCellWithVoucher:disCount];
//        }
        if (self.vouchersArr.count > 2 && sectionTwo == NO) {
            if (indexPath.row < 2) {
                CMCDiscount *disCount = [self.vouchersArr objectAtIndex:indexPath.row];
                 [cell creatCellWithVoucher:disCount];
            } else {
                cell.textLabel.text = @"加载更多代金券";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                
            }
            
            
        } else if (self.vouchersArr.count > 2 && sectionTwo == YES){
            
            CMCDiscount *disCount = [self.vouchersArr objectAtIndex:indexPath.row];
            [cell creatCellWithVoucher:disCount];
            
            
            
        } else {
            CMCDiscount *disCount = [self.vouchersArr objectAtIndex:indexPath.row];
            [cell creatCellWithVoucher:disCount];
        
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    
    return nil;

}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        if (self.dicountArr.count) {
            return 20;

        } else {
            return 0.001;
        
        }
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0 && indexPath.row == self.numberOfRows - 1) {
//        return 40;
//    }
//    if (indexPath.section == 1 && indexPath.row == self.numberOfRows2 - 1) {
//        return 40;
//    }
    if (indexPath.section == 0) {
        if (self.dicountArr.count > 2 &&sectionOne == NO) {
            if (indexPath.row == 2) {
                return 40;
            } else {
                return 83;
            }
        } else {
            
            return 83;
        }
    }
    if (indexPath.section == 1) {
        if (self.vouchersArr.count > 2&& sectionTwo == NO) {
            if (indexPath.row == 2) {
                return 40;
            }else {
                return 90;
            }
        } else {
            return 90;
            
            
        }
    }
    

    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section == 0) {
//        CMCYouHuiDetailVC *detailVC = [[CMCYouHuiDetailVC alloc] init];
//        CMCVouchers *vouchers = [self.dicountArr objectAtIndex:indexPath.row];
//        detailVC.coupon_id = vouchers.id;
//        [self.navigationController pushViewController:detailVC animated:YES];
        if (self.dicountArr.count > 2 && sectionOne == NO) {
            if (indexPath.row == 2) {
                sectionOne = YES;
                [self loadData];
            } else {
                CMCPreferentialDetailsVC *detailVC = [[CMCPreferentialDetailsVC alloc] init];
                CMCVouchers *vouchers = [self.dicountArr objectAtIndex:indexPath.row];
                detailVC.coupon_id = vouchers.id;
                detailVC.title = @"折扣券详情";
                [self.navigationController pushViewController:detailVC animated:YES];
            
            
            }
        } else {
            CMCPreferentialDetailsVC *detailVC = [[CMCPreferentialDetailsVC alloc] init];
            CMCVouchers *vouchers = [self.dicountArr objectAtIndex:indexPath.row];
            detailVC.coupon_id = vouchers.id;
            detailVC.title = @"折扣券详情";
            [self.navigationController pushViewController:detailVC animated:YES];

    }
    }
    if (indexPath.section == 1) {
        
        if (self.vouchersArr.count > 2 && sectionTwo == NO) {
            if (indexPath.row == 2) {
                sectionTwo = YES;
                [self loadVouchersData];

            } else {
            
                CMCVoucherDetailsVC *detailVC = [[CMCVoucherDetailsVC alloc] init];
                detailVC.title = @"代金券详情";
                CMCVouchers *vouchers = [self.vouchersArr objectAtIndex:indexPath.row];
                detailVC.coupon_id = vouchers.id;
                
                [self.navigationController pushViewController:detailVC animated:YES];
            
            }
        } else {
        
            CMCVoucherDetailsVC *detailVC = [[CMCVoucherDetailsVC alloc] init];
            detailVC.title = @"代金券详情";
            CMCVouchers *vouchers = [self.vouchersArr objectAtIndex:indexPath.row];
            detailVC.coupon_id = vouchers.id;
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }


    }

    
//    //其他单元格响应方法

    
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
