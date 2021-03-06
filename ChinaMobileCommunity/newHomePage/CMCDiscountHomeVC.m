//
//  CMCDiscountHomeVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDiscountHomeVC.h"
#import "PickUpView.h"
#import "CMCDisAndVouCell.h"
#import "CMCDicAndVoucherVC.h"
#import "CMCSearchVC.h"
#import "CMCCouponsModel.h"
//#import "CMCPublicClassViewController.h"

@interface CMCDiscountHomeVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSInteger _page;
    NSInteger _num;

}
@property (nonatomic,strong)PickUpView *myPickUpView;//折扣券
@property (nonatomic,strong)UIScrollView *myScrollView;//scrollView
@property (nonatomic,strong)UITableView *myTableView;// 表格
@property (nonatomic,strong)UITableView *secondTableView;//第二个表格
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *couponArr;//折扣券
@property (nonatomic, strong) NSMutableArray *vouchersArr;//代金券
@end

@implementation CMCDiscountHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.couponArr = [[NSMutableArray alloc] init];
    self.vouchersArr = [[NSMutableArray alloc] init];
//    self.title = @"优惠专区";
    self.type = @"1";
//    _page = 1;
    _num = 1;
    [self showRefreshHeader:YES];
    [self createHeaderView];
    // Do any additional setup after loading the view.
    [self createSubView];
//    [self loadCouponzoneData];
    [self loadVouchersData];

    [self creatBackButton];
}
//返回按钮
- (void)creatBackButton
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"后退_03"] style:UIBarButtonItemStyleBordered target:self action:@selector(didClickBackBtn:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)didClickBackBtn:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - 创建子视图 - 


- (void)createSubView{
    [self _createPickUpView];
    [self _setupScrollView];
    [self _createTableView];//创建tableview
    [self setupRightBarItem];
}

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    //上拉刷新
    if (aRefreshPos == EGORefreshHeader) {
        _page = 1;
        _num = 1;
        
    }else if (aRefreshPos == EGORefreshFooter){
        //下拉加载
        _page++;
        _num++;
        
    }
    [self loadVouchersData];
    [self loadCouponzoneData];
    
}


//创建segment
- (void)_createPickUpView{
    self.myPickUpView = [[PickUpView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 41)];
    __weak typeof(self) wself = self;//解决循环引用问题
    [self.myPickUpView setMyBlock:^(NSUInteger tag) {
        [wself clickPickViewAction:tag];//可能会引起死循环(待修改)
        
    }];
    
    [self.view addSubview:self.myPickUpView];
}



//创建scrollView
- (void)_setupScrollView{
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.myPickUpView.bottom, self.view.width, self.view.height - self.myPickUpView.bottom - 64)];
    self.myScrollView.contentSize = CGSizeMake(self.view.width * 2,self.view.height - self.myPickUpView.frame.size.height - 64);
    self.myScrollView.delegate = self;
    self.myScrollView.backgroundColor = [UIColor orangeColor];
    self.myScrollView.pagingEnabled = YES;//整页翻
    self.myScrollView.bounces = NO;//第一页不让动
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.scrollEnabled = NO;
    [self.view addSubview:self.myScrollView];
}

//创建tableView
- (void)_createTableView{
    //代金券
    self.secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.width, self.view.height - self.myPickUpView.bottom - 64) style:UITableViewStylePlain];
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    self.secondTableView.backgroundColor = k_color(@"F7F7F7");
    self.secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //折扣券
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.width,0, self.view.width, self.view.height - self.myPickUpView.bottom - 64) style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = k_color(@"F7F7F7");
    
    
    
    [self.myScrollView addSubview:self.myTableView];
    [self.myScrollView addSubview:self.secondTableView];
    
}

#pragma mark - 搜索
- (void)setupRightBarItem{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"city_search"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchAction:)];
    rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}


- (void)searchAction:(UIButton *)sender{
    CMCSearchVC *searchVC = [[CMCSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
//加载优惠专区数据  折扣券
- (void)loadCouponzoneData
{
    if (_page == 1) {
        [self.couponArr removeAllObjects];
    }
    _num = 1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *timestamp = kAPI_timestamp;
    
        if ([CMCUserManager shareManager].token) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"tag":@"",@"type":self.type,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = KAPI_couponzone([CMCUserManager shareManager].token, @"", self.type, pageStr, @"8", kAPI_timestamp, [BaseUtil md5:sig]);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"优惠专区 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSArray *dataArr = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataArr) {
                        CMCCouponsModel *couponModel = [[CMCCouponsModel alloc] initWithCouponsModelDic:tempDic];
                        [self.couponArr addObject:couponModel];
                    }
                    [self.myTableView reloadData];
                    [self finishReloadingData];
                    [self setFooterView];

                }else {
                    [BaseUtil toast:@"数据加载完毕"];
                
                }
            }
        } failure:^(NSError *error) {
            
        }];

        } else {
            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        
        }

}
//加载优惠专区数据  代金券

- (void)loadVouchersData
{
    if (_num ==1) {
        [self.vouchersArr removeAllObjects];
    }
    _page = 1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_num];
    NSString *timestamp = kAPI_timestamp;
    if ([CMCUserManager shareManager].token) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"tag":@"",@"type":self.type,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = KAPI_couponzone([CMCUserManager shareManager].token, @"", self.type, pageStr, @"8", kAPI_timestamp, [BaseUtil md5:sig]);
        NSLog(@"requestUrl =========%@",requestUrl);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"优惠专区 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSArray *dataArr = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataArr) {
                        CMCCouponsModel *couponModel = [[CMCCouponsModel alloc] initWithCouponsModelDic:tempDic];
                        [self.vouchersArr addObject:couponModel];
                    }
                    [self.secondTableView reloadData];
                    [self finishReloadingData];
                    [self setFooterView];
                    
                }else {
                    
//                    [BaseUtil toast:@"数据加载完毕"];
                    
                }
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}
#pragma mark - block响应方

- (void)clickPickViewAction:(NSUInteger)tag

{
    //如果点击的是代金券
    if (tag == 200) {
        _num = 1;
        self.type = @"1";
        [self loadVouchersData];
        //改变提示警告
        [UIView animateWithDuration:0.5 animations:^{
            self.myScrollView.contentOffset = CGPointZero;//移动
        }];
        self.myPickUpView.voucherImgV.image = [UIImage imageNamed:@"icon_onsalezone_dis_unpress "];
        self.myPickUpView.discoutImgV.image = [UIImage imageNamed:@"icon_onsalezone_voun_press "];//代金券
    }
    //如果点击的是折扣券
    if (tag == 201) {
        _page = 1;
        self.type = @"0";
        [self loadCouponzoneData];
        [UIView animateWithDuration:0.5 animations:^{
            self.myScrollView.contentOffset = CGPointMake(self.view.width, 0);//移动
        }];
        self.myPickUpView.discoutImgV.image = [UIImage imageNamed:@"icon_onsalezone_voun_unpress "];
        self.myPickUpView.voucherImgV.image = [UIImage imageNamed:@"icon_onsalezone_dis_press"];
    }
    
}



#pragma mark - tableviewdelegate -- 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _myTableView) {
        return self.couponArr.count;
    }
    if (tableView == _secondTableView) {
        return self.vouchersArr.count;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView  alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 28);
    view.backgroundColor = k_color(@"f5f4f4");
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(17, 8.5, 15, 15);
    imgView.image = [UIImage imageNamed:@"icon_onsalezone_shop "];
    [view addSubview:imgView];
    
    UILabel *nameL = [[UILabel alloc]init];
    nameL.frame = CGRectMake(imgView.right + 3, imgView.top, 100, imgView.height);
    nameL.text = @"热门商户";
    nameL.textColor = k_color(@"666666");
    nameL.font = k_font(15);
    [view addSubview:nameL];
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _myTableView) {
    static NSString *cellIndentifier = @"discountCell";
        CMCDisAndVouCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCDisAndVouCell alloc]init];
        }
        cell.section = 0;
        if (self.couponArr.count) {
            CMCCouponsModel *couponsModel = [self.couponArr objectAtIndex:indexPath.row];
            cell.couponsModel= couponsModel;
        }

        [cell setupDownLoadBlock:^{
            [BaseUtil toast:@"折扣券下载成功,请到我的券包查看"];
        }];
        return cell;
    }
    
    if (tableView == _secondTableView) {
        static NSString *cellIndentifier = @"voucherCell";
        CMCDisAndVouCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCDisAndVouCell alloc]init];
        }
        if (self.vouchersArr.count) {
            CMCCouponsModel *couponsModel = [self.vouchersArr objectAtIndex:indexPath.row];
            cell.vouchersModel = couponsModel;
        }


        cell.section = 1;
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CMCDicAndVoucherVC *disVC = [[CMCDicAndVoucherVC alloc]init];

    if (tableView == _myTableView) {
        disVC.category = @"折扣券详情";
        CMCCouponsModel *couponsModel = [self.couponArr objectAtIndex:indexPath.row];
        disVC.coupon_id = couponsModel.id;
    }
    
    if (tableView == _secondTableView) {
        disVC.category = @"代金券详情";
        CMCCouponsModel *couponsModel = [self.vouchersArr objectAtIndex:indexPath.row];
        disVC.coupon_id = couponsModel.id;
    }
    
    [self.navigationController pushViewController:disVC animated:YES];

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
