//
//  CMCOrderViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-19.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderViewController.h"
#import "CMCNewOrderTableViewCell.h"
#import "CMCNewClassfyDianCan.h"
#import "CMCDianCan.h"
#import "CMCDistrictDianCan.h"
#import "CMCShoppingCarTableVC.h"
#import "CMCPaymentDetailsVC.h"
//#import "AFHTTPClient."
#import "CMCGoodsDetailVC.h"
#import "CMCFoodModel.h"
#import "CMCShoppingGoodsCell.h"


@interface CMCOrderViewController ()<CMCShoppingGoodsCellDelegate>
{
    UITableView *_myTableView;
    UITableView *_classifyTableView;
    UIView *_buttomView;
    UILabel *_priceLabel;
    UIButton *_shopButton;
    UIButton *_maidanButton;
    UILabel *_totalLabel;

}
@property (nonatomic, strong) NSMutableArray *dianCanArr;
@property (nonatomic, strong) NSMutableArray *dianCanClassfyArr;
@property (nonatomic, strong) NSString *urlStr;
@end


static BOOL isTure ;
@implementation CMCOrderViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setStatus:YES];
    


}
#pragma mark -
#pragma mark - 设置顶部是否隐藏
- (void)setStatus:(BOOL)select
{
    _buttomView.hidden = select;
    _totalLabel.hidden = select;
    _priceLabel.hidden = select;
    _shopButton.hidden = select;
    _maidanButton.hidden = select;


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    [self creatButtom];

}

- (void)creatButtom
{
    if (_buttomView == nil) {
        _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height , self.view.bounds.size.width, 64)];
        [self.navigationController.view addSubview:_buttomView];
        _buttomView.backgroundColor = [UIColor whiteColor];
        UIImageView *shopCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
        shopCarImageView.image = [UIImage imageNamed:@"shopCar"];
        [_buttomView addSubview:shopCarImageView];
        
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCarImageView.frame.size.width +10 , 10, 40, 50)];
        _totalLabel.text = @"合计:";
        [_buttomView addSubview:_totalLabel];
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_totalLabel.frame.size.width + _totalLabel.frame.origin.x, _totalLabel.frame.origin.y, 100, 50)];
        
        [_buttomView addSubview:_priceLabel];
        
        
        //买单
        _maidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maidanButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
        [_buttomView addSubview:_maidanButton];
        [_maidanButton addTarget:self action:@selector(didClickMaiDanButton:) forControlEvents:UIControlEventTouchUpInside];
        [_maidanButton setTitle:@"买单" forState:UIControlStateNormal];

        _maidanButton.frame = CGRectMake(self.view.bounds.size.width - 95, 20, 80, 30);
    } else {
        [self setStatus:NO];
    
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"点菜";
    [self setStatus:NO];
    [self creatTopRightButton];
    [self creatshopCarImageView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    
    self.dianCanArr = [[NSMutableArray alloc] init];
    self.dianCanClassfyArr = [[NSMutableArray alloc] init];
;
    [self loadClassfyData];
    isTure = YES;
    [self didClickTopRightButton:nil];

    
//    [self creatButtom];

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
}
#pragma mark -
#pragma mark - 点击购物车
- (void)didClickShopBtn:(UIButton *)button
{

//    _priceLabel.text
    CMCShoppingCarTableVC *shopCarVC = [[CMCShoppingCarTableVC alloc] init];
    shopCarVC.title = @"我的购物车";
    shopCarVC.priceText = _priceLabel.text;
    NSLog(@"????????%@",_priceLabel.text);
    shopCarVC.shop_id = self.merchant_id;
    [self.navigationController pushViewController:shopCarVC animated:YES];

}
#pragma mark -
#pragma mark - 点击买单
- (void)didClickMaiDanButton:(UIButton *)button
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
        [BaseUtil toast:@"您还没有点餐"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        return;
    }
    ;
    if ([CMCUserManager shareManager].token) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *newDic =@{@"token_agent":[CMCUserManager shareManager].token,@"store_id":self.merchant_id,@"type":@"1",@"goodslist":array,@"address_id":@"0",@"address_id":@"0",@"payment":@"0",@"comment":@"0"};
        NSLog(@"newDic == %@",newDic);
        NSDictionary *postDic = [BaseUtil postString:[newDic JSONString] postUrlString:KAPI_GetSubmitorder];
            NSLog(@"买单postDic =======%@",postDic);
        NSDictionary *infoDic = [postDic objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([postDic objectForKey:@"data"]) {
                NSDictionary *dataDic = [postDic objectForKey:@"data"];
                CMCPaymentDetailsVC *paymentDetailVC = [[CMCPaymentDetailsVC alloc] init];
                paymentDetailVC.tempDic = dataDic;
                paymentDetailVC.merchantName = self.merchant_name;
                paymentDetailVC.numberCount = array.count;
                [self.navigationController pushViewController:paymentDetailVC animated:YES];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        } else {
            
            [BaseUtil toast:@"暂无数据"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            
        }
        
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
//    _classifyTableView.hidden = YES;
    float n = 0;
    for (int i = 0; i < self.dianCanArr.count; i++) {
        CMCDianCan *dianCan = [self.dianCanArr objectAtIndex:i];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CMCNewOrderTableViewCell *cell = (CMCNewOrderTableViewCell*)[_myTableView cellForRowAtIndexPath:indexPath];
        n += cell.middleLabel.text.intValue * dianCan.price.floatValue;
        
        
    }
    _priceLabel.text = [NSString stringWithFormat:@"%.2f元",n];
//    NSLog(@"jia^^^^^^^^^%f",n);


}


#pragma mark -
#pragma mark - 分类
//点击分类
- (void)didClickTopRightButton:(UIButton *)button
{
    if (isTure == YES) {
        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count)];
        _classifyTableView.delegate = self;
        _classifyTableView.dataSource = self;
        [BaseUtil setExtraCellLineHidden:_classifyTableView];
        [self.view addSubview:_classifyTableView];
        isTure = NO;
    }
    else if (isTure == NO) {
        [_classifyTableView removeFromSuperview];
        isTure = YES;
    }

}
//创建购物车和价格
- (void)creatshopCarImageView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, self.view.bounds.size.width, 49)];
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
        NSLog(@"=====%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCNewClassfyDianCan *dianCanClassfy = [[CMCNewClassfyDianCan alloc] initWithDianCan:tempDic];
                    [self.dianCanClassfyArr addObject:dianCanClassfy];
                    
                }
                NSLog(@"diancanArr = %@",self.dianCanClassfyArr);
                CMCNewClassfyDianCan  *newClassfyDianCan = [self.dianCanClassfyArr objectAtIndex:0];
                
                 [self loadData:newClassfyDianCan.id];
                [_classifyTableView reloadData];
                _classifyTableView.frame = CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count);
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            } else {
                
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
            }
        } else {
            [BaseUtil toast:@"服务端数据错误,请重试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            
        }
    } failure:^(NSError *error) {
        
    }];
    

}

//加载数据
- (void)loadData:(NSString *)idStr
{
    NSLog(@"idStr = %@",idStr);
    [self creatTableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.dianCanArr removeAllObjects];
    
    
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.merchant_id,@"type_id":idStr,@"page":@"0",@"nums":@"8",@"timestamp":kAPI_timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url =  KAPI_MerchantGoodsList(self.merchant_id, idStr, @"0", @"8", sig,self.service_id);
    NSLog(@"url = %@",url);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondObject = %@",respondObject);
      NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                _myTableView.hidden = NO;
                
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
//                    CMCDianCan *dianCan = [[CMCDianCan alloc] initWithDianCanClassfy:tempDic];
                    CMCFoodModel *model = [CMCFoodModel foodWithDic:tempDic];
                    [self.dianCanArr addObject:model];
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


#pragma mark - tableviewDelegate -
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        self.urlStr = dianCanClassfy.id;
        [self loadData:self.urlStr];
        [_classifyTableView removeFromSuperview];
        isTure = YES;

    }
    if (_myTableView == tableView) {
        [_classifyTableView removeFromSuperview];
        isTure = YES;
        
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
