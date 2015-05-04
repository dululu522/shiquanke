//
//  CMCShoppingGoodsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCShoppingGoodsVC.h"
#import "CMCShoppingGoodsCell.h"
#import "CMCGoodsDetailVC.h"
#import "CMCOrderMakeSureVC.h"
#import "CMCNewClassfyDianCan.h"
#import "CMCDianCan.h"


@interface CMCShoppingGoodsVC ()
{
    UIView *_backView;
    UITableView *_classifyTableView;
    UILabel *edgeLabel;
    UILabel *priceLabel;
     NSInteger _page;
    BOOL isTure;
}
@property (nonatomic, strong) UITableView *shoppingTabelView;

@property (nonatomic, strong) NSMutableArray *dianCanArr;
@property (nonatomic, strong) NSMutableArray *dianCanClassfyArr;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic,strong)  NSString  *numberOfOrder;
@property (nonatomic,strong)  NSMutableArray *numberArr;


@end


@implementation CMCShoppingGoodsVC
- (NSMutableArray *)numberArr{
    if (_numberArr == nil) {
        self.numberArr = [NSMutableArray array];
    }
    return _numberArr;
}

- (NSMutableArray *)dianCanArr{
    if (_dianCanArr == nil) {
        self.dianCanArr = [NSMutableArray array];
    }
    return _dianCanArr;
}
- (NSMutableArray *)dianCanClassfyArr{
    if (_dianCanClassfyArr == nil) {
        self.dianCanClassfyArr = [NSMutableArray array];
    }
    return _dianCanClassfyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 1;
    isTure = NO;
    [CMCUserManager shareManager].orderDic = [NSMutableDictionary dictionary];
    [CMCUserManager shareManager].dataDic = [NSMutableDictionary dictionary];
    self.numberOfOrder = @"0";
    [self.view addSubview:_backView];
    [self createSubViews];
    [self loadClassfyData];
    [self addNotifierCenter];
    [self createHeaderView];
    [self showRefreshHeader:YES];
}

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    if (aRefreshPos == EGORefreshHeader) {
        _page = 1;
    } else if (aRefreshPos == EGORefreshFooter){
    
        _page++;
    }

    [self loadData:self.urlStr];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_shoppingTabelView reloadData];
}

#pragma mark - 注册通知 － 
- (void)addNotifierCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againAddData:) name:@"againAddData" object:nil];
    
}
- (void)againAddData:(NSNotification *)sender{
    NSArray *object = (NSArray *)sender.object;
    edgeLabel.text = object[0];
    priceLabel.text = object[1];
    
    
}
- (void)creatBackButton
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 100, 44);
    [backBtn setImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 0, 80)];
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
}
- (void)didClickBackBtn:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建子视图 -
- (void)createSubViews{
    [self creatTableView];
    [self creatBottomView];
    [self  creatTopRightButton];
    [self creatBackButton];
    
}

- (void)creatTableView
{
    self.shoppingTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 120)];
     self.shoppingTabelView.delegate = self;
    self.shoppingTabelView.dataSource = self;
//    _shoppingTabelView.backgroundColor = [UIColor redColor];
    
//    [BaseUtil setExtraCellLineHidden:self.shoppingTabelView];
    [_backView addSubview:self.shoppingTabelView];
    
    _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count) style:UITableViewStyleGrouped];
    NSLog(@"--------%@",_dianCanClassfyArr);
    _classifyTableView.delegate = self;
    _classifyTableView.dataSource = self;
    
    [self.view addSubview:_classifyTableView];
    
    
}
- (void)creatBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 120, self.view.width, 60)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:bottomView];
    

    //购物车
    UIImage *image = [UIImage imageNamed:@"shopCar_goods"];
    UIImageView *shopCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, image.size.width, image.size.height)];
    shopCarImageView.image = image;
    [bottomView addSubview:shopCarImageView];
    
    //角标
    edgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCarImageView.right -5, 15, 15, 15)];
    edgeLabel.backgroundColor = [UIColor colorWithHexString:@"ff8f21"];
    edgeLabel.layer.cornerRadius = 7.5;
    edgeLabel.layer.masksToBounds = YES;
    edgeLabel.textAlignment = NSTextAlignmentCenter;
    edgeLabel.font = k_font(15);
    edgeLabel.adjustsFontSizeToFitWidth = YES;
    edgeLabel.text = @"0";
    [bottomView addSubview:edgeLabel];
    
    //合计
    UILabel *combinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(edgeLabel.right + 10, 0, 30, 70)];
    combinedLabel.font = [UIFont systemFontOfSize:13.0];
    combinedLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    combinedLabel.text = @"合计:";
    [bottomView addSubview:combinedLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(combinedLabel.right+2, 0, 100, 70)];
    priceLabel.text = @"";
    priceLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    priceLabel.font = [UIFont systemFontOfSize:13.0];
    [bottomView addSubview:priceLabel];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(self.view.frame.size.width- 105, 10, 90, 35);
    submitButton.layer.cornerRadius = 5;
    [bottomView addSubview:submitButton];
    submitButton.backgroundColor = kAPI_AllMainColor;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];

}
//提交按钮
#pragma mark -//提交按钮
#pragma mark -didClickSubmitButton
- (void)didClickSubmitButton:(UIButton *)button
{
    //0319
    if (![CMCUserManager shareManager].token) {
        [BaseUtil toast:@"您还没登录，请登录再试"];
        CMCLoginViewController *log = [[CMCLoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
        return;
    }
    
    if ([CMCUserManager shareManager].orderDic.count == 0) {
        [BaseUtil toast:@"您还没有订单"];
        return;
    }
    
    CMCOrderMakeSureVC *makeSureVC = [[CMCOrderMakeSureVC alloc]init];
    makeSureVC.price = priceLabel.text;
    makeSureVC.orderDic = [CMCUserManager shareManager].orderDic;
    makeSureVC.merchant_name = self.merchant_name;
    makeSureVC.category = self.title;
    makeSureVC.merchant_id = self.merchant_id;
    makeSureVC.service_id = self.service_id;
    [self.navigationController pushViewController:makeSureVC animated:YES];
    
}

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

#pragma mark - 分类
//点击分类
- (void)didClickTopRightButton:(UIButton *)button
{
//    if (isTure == YES) {
//        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count)];
//        _classifyTableView.delegate = self;
//        _classifyTableView.dataSource = self;
//        [BaseUtil setExtraCellLineHidden:_classifyTableView];
//        [self.view addSubview:_classifyTableView];
//        isTure = NO;
//}
//    else if (isTure == NO) {
//        [_classifyTableView removeFromSuperview];
//        isTure = YES;
//    }
    
    if (isTure == YES) {
        [self.view addSubview:_classifyTableView];
        isTure = NO;
    }
    else if (isTure == NO) {
        [_classifyTableView removeFromSuperview];
        isTure = YES;
    }
    
    
}


#pragma mark - CMCShoppingGoodsCellDelegate -
//计算点菜的数量和价格
- (void)didClickItemsWithNumber:(NSString *)number andFoodModel:(NSArray *)diancan{
    self.numberOfOrder = number;
//    NSArray *infoArr = [NSArray arrayWithObjects:diancan.image.firstObject,diancan.name,diancan.price,diancan.id, nil];
    [[CMCUserManager shareManager].orderDic setObject:number forKey:diancan];
    [[CMCUserManager shareManager].dataDic setObject:number forKey:diancan];
    NSArray *keyArr = [CMCUserManager shareManager].orderDic.allKeys;
    NSArray *valueArr = [CMCUserManager shareManager].orderDic.allValues;
    //购物总价格
    float price = 0;
    for (int i = 0; i < keyArr.count; i++) {
        NSArray *arr = keyArr[i];
        price += ([arr[2] floatValue] * [valueArr[i] integerValue]);
    }
    priceLabel.text = [NSString stringWithFormat:@"%.2f",price];
    
    
    //购物数量
    NSInteger num = 0;
    for (int i = 0; i < valueArr.count; i++) {
        if ([valueArr[i] integerValue] == 0) {
            [[CMCUserManager shareManager].orderDic removeObjectForKey:keyArr[i]];
        }
        num += [valueArr[i] integerValue];
    }
    
    edgeLabel.text = [NSString stringWithFormat:@"%d",num];
    
    
    NSLog(@"dic = %@",[CMCUserManager shareManager].orderDic);
    
}

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
    NSLog(@"QQQ商户商品分类 %@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"=====%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCNewClassfyDianCan *dianCanClassfy = [[CMCNewClassfyDianCan alloc] initWithDianCan:tempDic];
                    [self.dianCanClassfyArr addObject:dianCanClassfy];
                    
                }
                CMCNewClassfyDianCan  *newClassfyDianCan = [self.dianCanClassfyArr objectAtIndex:0];
                
                self.urlStr = newClassfyDianCan.id;

                [self loadData:newClassfyDianCan.id];
                [_classifyTableView reloadData];
                _classifyTableView.frame = CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            } else {
                
                [BaseUtil toast:@"此服务暂无商品"];
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
//    [self creatTableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_page == 1) {
        [[CMCUserManager shareManager].dataDic removeAllObjects];
        [self.dianCanArr removeAllObjects];
    }

    NSString *timestamp = kAPI_timestamp;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.merchant_id,@"type_id":idStr,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
//    NSString *url =  KAPI_MerchantGoodsList(self.merchant_id, idStr, @"0", @"8", sig);
    NSString *url = KAPI_MerchantGoodsList(self.merchant_id, idStr, pageStr,  @"8", sig,self.service_id);
    NSLog(@"^^^^^^^^^^^url = %@",url);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondObject = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                _shoppingTabelView.hidden = NO;
                
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    //                    CMCDianCan *dianCan = [[CMCDianCan alloc] initWithDianCanClassfy:tempDic];
                    CMCFoodModel *model = [CMCFoodModel foodWithDic:tempDic];
//                    [self.dianCanArr addObject:model];
                    NSArray *keyArr = @[model.image.firstObject,model.name,model.price,model.id];
                    [[CMCUserManager shareManager].dataDic setObject:@"0" forKey:keyArr];
                    [self.dianCanArr addObject:keyArr];
                }
//                self.dianCanArr = [NSMutableArray arrayWithArray:[CMCUserManager shareManager].dataDic.allKeys];
//                self.numberArr = [NSMutableArray arrayWithArray:[CMCUserManager shareManager].dataDic.allValues];
                
                //切换点菜的时候，保持点菜的数量
                [self exchangeNumber];
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_shoppingTabelView reloadData];
                [self finishReloadingData];
                [self setFooterView];
                
            } else {
//                _shoppingTabelView.hidden = YES;
//                [BaseUtil toast:@"此分类暂无商品"];
                [BaseUtil toast:@"数据已加载完毕"];

                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            
            
        } else {
            [BaseUtil toast:@"数据加载失败,请重试"];
            
            _shoppingTabelView.hidden = YES;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

//切换点菜的时候，保持点菜的数量
- (void)exchangeNumber{
    if ([CMCUserManager shareManager].orderDic) {
        NSArray *keyArr = [CMCUserManager shareManager].orderDic.allKeys;
        NSArray *valueArr = [CMCUserManager shareManager].orderDic.allValues;
        for (int i = 0; i < keyArr.count; i++) {
            [[CMCUserManager shareManager].dataDic setObject:valueArr[i] forKey:keyArr[i]];
        }
        
    }
}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_classifyTableView == tableView) {
        return self.dianCanClassfyArr.count;
    }
    if (_shoppingTabelView == tableView) {
        return self.dianCanArr.count;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _shoppingTabelView) {
        
        static NSString *str = @"CMCShoppingGoodsCell";
        CMCShoppingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCShoppingGoodsCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        CMCFoodModel *dianCan = [self.dianCanArr objectAtIndex:indexPath.row];
        NSArray *dianCan = self.dianCanArr[indexPath.row];
        NSString *number = [[CMCUserManager shareManager].dataDic objectForKey:dianCan];
        cell.count = [number integerValue];
        NSLog(@"diancan===== %@",dianCan);
        cell.diancan = dianCan;
        cell.category = self.service_id;
        cell.delegate = self;
        cell.row = indexPath.row;
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
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_shoppingTabelView == tableView) {
        if ([self returnYesOrNoWithCategory:self.title]) {
            return 140;
        }
        if ([self isCate:self.title]) {
            return 160;
        }
        return 100;
        
    }
    if (_classifyTableView == tableView) {
        return 44;
    }
    return 0;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (tableView == _shoppingTabelView) {
//        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
//        sectionView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//        UIImage *image = [UIImage imageNamed:@"shangjia"];
//        UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, image.size.width, image.size.height)];
//        shopImageView.image = image;
//        [sectionView addSubview:shopImageView];
//        UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopImageView.right + 10, 0, self.view.frame.size.width - 80, 34)];
//        [sectionView addSubview:shopLabel];
//        shopLabel.text = self.merchant_name;
//        shopLabel.textColor = [UIColor colorWithHexString:@"505050"];
//        shopLabel.font = [UIFont systemFontOfSize:14.0];
//        
//        return sectionView;
//    }
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (tableView == _shoppingTabelView) {
//        return 34;
//    }
    if (tableView == _classifyTableView) {
        return 0.1;

    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (_classifyTableView == tableView) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        self.urlStr = dianCanClassfy.id;
        _page = 1;
        [self loadData:self.urlStr];
        [_classifyTableView removeFromSuperview];
        isTure = YES;
        
    }
    if (_shoppingTabelView == tableView) {
        [_classifyTableView removeFromSuperview];
        isTure = YES;
        
        NSArray *dianCan = [self.dianCanArr objectAtIndex:indexPath.row];
        CMCGoodsDetailVC *detailVC = [[CMCGoodsDetailVC alloc]init];
        detailVC.goodsId =  dianCan[3];
        detailVC.mid = self.merchant_id;
        detailVC.price = priceLabel.text;
        detailVC.category = self.title;
        detailVC.merchant_name = self.merchant_name;
        detailVC.numberOfOrder = [[CMCUserManager shareManager].dataDic objectForKey:dianCan];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (BOOL)returnYesOrNoWithCategory:(NSString *)cate{
    if ([cate isEqualToString:@"预约洗车"]) {
        return YES;
    }
    if ([cate isEqualToString:@"预约装饰"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门装饰"]) {
        return YES;
    }
    if ([cate isEqualToString:@"上门洗车"]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)isCate:(NSString *)cate
{
    if ([cate isEqualToString:@"到店美甲"] | [cate isEqualToString:@"到店修脚"]|[cate isEqualToString:@"到店按摩"]  |[cate isEqualToString:@"上门按摩"] |[cate isEqualToString:@"上门修脚"] |[cate isEqualToString:@"上门美甲"]) {
        //        [self changeStoreNailFrame];
        return YES;
    }
    return NO;
    
}
#pragma mark - end
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
