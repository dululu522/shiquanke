//
//  CMCTakeOutTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCTakeOutTableVC.h"
//#import "CMCTakeOutTVCell.h"
//#import "CMCNewClassfyDianCan.h"
//#import "CMCDianCan.h"
//
//#import "CMCOrderConfirmationVC.h"
//#import "YRJSONAdapter.h"
//#import "CMCNewOrderTableViewCell.h"
#import "CMCNewOrderTableViewCell.h"
#import "CMCNewClassfyDianCan.h"
#import "CMCDianCan.h"
#import "CMCDistrictDianCan.h"
#import "CMCShoppingCarTableVC.h"
#import "CMCPaymentDetailsVC.h"
#import "CMCOrderConfirmationVC.h"
#import "CMCFoodModel.h"
#import "CMCGoodsDetailVC.h"



@interface CMCTakeOutTableVC ()
{
    UITableView *_myTableView;
    UITableView *_classifyTableView;
    UIView *_buttomView;
    UILabel *_priceLabel;
    UIButton *_shopButton;
    UIButton *_maidanButton;
    UILabel *_totalLabel;
    UIImageView *_shopCarImageView;
    
    
}
@property (nonatomic, strong) NSMutableArray *dianCanArr;
@property (nonatomic, strong) NSMutableArray *dianCanClassfyArr;
@property (nonatomic, strong) NSString *urlStr;
@end
static BOOL isTrue;
@implementation CMCTakeOutTableVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
    [_buttomView removeFromSuperview];
    [_shopCarImageView removeFromSuperview];
    [_totalLabel removeFromSuperview];
    [_maidanButton removeFromSuperview];
    
}
#pragma mark -
#pragma mark - 设置顶部是否隐藏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
//    [self loadClassfyData];
    [self creatButtom];
    isTrue = YES;
    [self didClickTopRightButton:nil];
    
}
- (void)creatButtom
{
    [_buttomView removeFromSuperview];
    [_shopCarImageView removeFromSuperview];
    [_totalLabel removeFromSuperview];
    [_maidanButton removeFromSuperview];
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height , self.view.bounds.size.width, 64)];
    [self.navigationController.view addSubview:_buttomView];
    _buttomView.backgroundColor = [UIColor whiteColor];
    _shopCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
    _shopCarImageView.image = [UIImage imageNamed:@"shopCar"];
    [_buttomView addSubview:_shopCarImageView];
    
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopCarImageView.frame.size.width +10 , 10, 40, 50)];
    _totalLabel.text = @"合计:";
    [_buttomView addSubview:_totalLabel];
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_totalLabel.frame.size.width + _totalLabel.frame.origin.x, _totalLabel.frame.origin.y, 100, 50)];
    
    [_buttomView addSubview:_priceLabel];
    //买单
    _maidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_maidanButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [_buttomView addSubview:_maidanButton];
    [_maidanButton addTarget:self action:@selector(didClickMaiDanButton:) forControlEvents:UIControlEventTouchUpInside];
    [_maidanButton setTitle:@"提交" forState:UIControlStateNormal];
    
    _maidanButton.frame = CGRectMake(self.view.bounds.size.width - 95, 20, 80, 30);
    
    
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"外卖";
    [self creatTopRightButton];
    [self creatshopCarImageView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    
    self.dianCanArr = [[NSMutableArray alloc] init];
    self.dianCanClassfyArr = [[NSMutableArray alloc] init];
    ;
    [self loadClassfyData];
    
}
- (void)creatTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];


}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [_classifyTableView removeFromSuperview];
    isTrue = YES;

}
- (void)creatTableView
{
    [_myTableView removeFromSuperview];
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _myTableView.delegate =self;
    
    _myTableView.dataSource = self;
    _myTableView.hidden = YES;
    [self.view addSubview:_myTableView];
    [BaseUtil setExtraCellLineHidden:_myTableView];
    //    _myTableView.tableHeaderView = backView;
    
    
}
#pragma mark -
#pragma mark - 点击提交
- (void)didClickMaiDanButton:(UIButton *)button
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    float n = 0;
    for (int i = 0; i < self.dianCanArr.count; i++) {
        CMCDianCan *dianCan = [self.dianCanArr objectAtIndex:i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CMCNewOrderTableViewCell *cell = (CMCNewOrderTableViewCell*)[_myTableView cellForRowAtIndexPath:indexPath];
        if (cell.middleLabel.text.intValue == 0) {
            break;
        }
        n += cell.middleLabel.text.intValue * dianCan.price.floatValue;
        NSDictionary *dic = @{@"id":dianCan.id,@"num":cell.middleLabel.text};
        [array addObject:dic];
    }
    if (array.count == 0) {
        [BaseUtil toast:@"您还没有定外卖"];
        return;
    }
    ;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if ([CMCUserManager shareManager].token) {
        NSDictionary *newDic =@{@"token_agent":[CMCUserManager shareManager].token,@"goodslist":array};
        NSLog(@"newDic == %@",newDic);
        NSDictionary *postDic = [BaseUtil postString:[newDic JSONString] postUrlString:KAPI_GetTakeoutInfo];
        NSLog(@"外卖  postDic =====%@",postDic);
        NSDictionary *infoDic = [postDic objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([postDic objectForKey:@"data"]) {
                CMCOrderConfirmationVC *orderConfirmationVC = [[CMCOrderConfirmationVC alloc] init];
                orderConfirmationVC.tempDic = [postDic objectForKey:@"data"];
                orderConfirmationVC.store_id = self.merchant_id;
                orderConfirmationVC.shopName = self.merchant_name;
                [self.navigationController pushViewController:orderConfirmationVC animated:YES];
                
            }else {
                
                [BaseUtil toast:@"暂时没有提交的内容"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
            }
        }else {
            [BaseUtil toast:@"提交错误,请重试"];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } else {
        
        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }
    
}

#pragma mark- 创建分类按钮


- (void)creatTopRightButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 53, 33)];
    [button addTarget:self action:@selector(didClickTopRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItems = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItems;
}
#pragma mark -
#pragma mark - CMCNewOrderTableViewCellDelegate

- (void) loadItems
{
    float n = 0;
    for (int i = 0; i < self.dianCanArr.count; i++) {
        CMCDianCan *dianCan = [self.dianCanArr objectAtIndex:i];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CMCNewOrderTableViewCell *cell = (CMCNewOrderTableViewCell*)[_myTableView cellForRowAtIndexPath:indexPath];
        n += cell.middleLabel.text.intValue * dianCan.price.floatValue;
        
        
    }
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",n];
    //    NSLog(@"jia^^^^^^^^^%f",n);
    
    
}


#pragma mark -
#pragma mark - 分类
//点击分类
- (void)didClickTopRightButton:(UIButton *)button
{
    if (isTrue == YES) {
        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count)];
        _classifyTableView.delegate = self;
        _classifyTableView.dataSource = self;
        [BaseUtil setExtraCellLineHidden:_classifyTableView];
        [self.view addSubview:_classifyTableView];
        isTrue = NO;
    } else if (isTrue == NO){
        
        [_classifyTableView removeFromSuperview];
        isTrue = YES;
        
    }
    
    
    
    
    
}
//创建购物车和价格
- (void)creatshopCarImageView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, self.view.bounds.size.width, 49)];
    backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backView];
    
    UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    shopImageView.image = [UIImage imageNamed:@"小车_07"];
    [backView addSubview:shopImageView];
    
}
#pragma mark -
#pragma mark - 加载分类数据

//商户商品分类
- (void)loadClassfyData
{
    [self.dianCanClassfyArr removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.merchant_id,@"timestamp":kAPI_timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MerchantType(self.merchant_id, sig,self.service_id);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"fenlei = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ( [respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCNewClassfyDianCan *dianCanClassfy = [[CMCNewClassfyDianCan alloc] initWithDianCan:tempDic];
                    [self.dianCanClassfyArr addObject:dianCanClassfy];
                    
                }
                CMCNewClassfyDianCan  *newClassfyDianCan = [self.dianCanClassfyArr objectAtIndex:0];
                
                [self loadData:newClassfyDianCan.id];
                [_classifyTableView reloadData];
                _classifyTableView.frame = CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count);
                
            } else {
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideAllHUDsForView:self.view animated: YES];
                
            }
        } else {
            
            [BaseUtil toast:@"服务端数据错误,请重试"];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
  
   
   
    
    
}


//列表数据
- (void)loadData:(NSString *)idStr
{
    [self creatTableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.dianCanArr removeAllObjects];
    //获取商品
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.merchant_id,@"type_id":idStr,@"page":@"0",@"nums":@"8",@"timestamp":kAPI_timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url =  KAPI_MerchantGoodsList(self.merchant_id,idStr, @"0", @"8", sig,self.service_id);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"diancan = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                _myTableView.hidden = NO;
                
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
//                    CMCDianCan *dianCan = [[CMCDianCan alloc] initWithDianCanClassfy:tempDic];
                    CMCFoodModel *dianCan = [CMCFoodModel foodWithDic:tempDic];
                    [self.dianCanArr addObject:dianCan];
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_myTableView reloadData];
                
            } else {
                _myTableView.hidden = YES;
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            
            
        } else {
            [BaseUtil toast:@"数据加载失败,请重试"];
            
            _myTableView.hidden = YES;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
    

   
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_classifyTableView == tableView) {
        return self.dianCanClassfyArr.count;
    }
    if (_myTableView == tableView) {
        return self.dianCanArr.count;
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myTableView == tableView) {
        static NSString *str = @"reused";
        CMCNewOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCNewOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.delegate = self;
        
//        CMCDianCan *dianCan = [self.dianCanArr objectAtIndex:indexPath.row];
//        [cell creatLeftImageCellleftX:0 rightY:self.view.bounds.size.width /2 dianCan:dianCan];
        CMCFoodModel *dianCan = [self.dianCanArr objectAtIndex:indexPath.row];
        [cell creatLeftImageCellleftX:0 rightY:self.view.width / 2 dianCan:dianCan];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if(_classifyTableView == tableView){
        static NSString *str = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        cell.textLabel.text = dianCanClassfy.name;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myTableView == tableView) {
        return 100;
        
    }
    if (_classifyTableView == tableView) {
        return 44;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (_classifyTableView == tableView) {
        //        _myTableView.hidden = YES;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        self.urlStr = dianCanClassfy.id;
        [self loadData:self.urlStr];
        
    }
//    isTrue = YES;
//    [_classifyTableView removeFromSuperview];
    if (_myTableView == tableView) {
        isTrue = YES;
        [_classifyTableView removeFromSuperview];
        
        CMCFoodModel *dianCan = [self.dianCanArr objectAtIndex:indexPath.row];
        CMCGoodsDetailVC *detailVC = [[CMCGoodsDetailVC alloc]init];
        detailVC.goodsId =  dianCan.id;
        detailVC.mid = self.merchant_id;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        
    }

    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _myTableView) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
        backView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 11, 14, 13)];
        imageView.image = [UIImage imageNamed:@"shangjia"];
        [backView addSubview:imageView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + imageView.frame.size.width + 5, 0, 200, 35)];
        nameLabel.text = self.merchant_name;
        [backView addSubview:nameLabel];
        
        
        return backView;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_myTableView == tableView) {
        return 35;
        
    }
    return 0;
    
}
@end
