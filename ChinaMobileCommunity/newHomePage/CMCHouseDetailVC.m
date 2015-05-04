//
//  CMCHouseDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-7.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCHouseDetailVC.h"
#import "CMCPaketInfoCell.h"
#import "CMCPreLookHouseVC.h"
#import "CMCHoseDetailCell.h"
#import "CMCFoodModel.h"
#import "CMCQScrollView.h"
@interface CMCHouseDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIView *_backView;
}

@property (nonatomic,strong)UIImageView *bannerImgV;
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic,strong)CMCFoodModel *dataModel;
@property (nonatomic, strong) UIPageControl* pageControl;

@property (nonatomic, strong) NSMutableDictionary *nextDic;//传递到预约看房

@property (nonatomic, strong) NSMutableArray *detailArr;
@property (nonatomic ,strong) CMCQScrollView* focusScorllView;
@property (nonatomic, strong) NSMutableArray *focusImageArray;

@end

@implementation CMCHouseDetailVC
- (NSMutableArray *)infoArr{
    if (_infoArr == nil) {
        self.infoArr = [NSMutableArray array];
    }
    return _infoArr;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.focusScorllView stopScorllView];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailArr = [[NSMutableArray alloc] init];
    self.nextDic = [[NSMutableDictionary alloc] init];
    self.focusImageArray = [[NSMutableArray alloc] init];
    self.title = @"房屋详情";
    // Do any additional setup after loading the view.
    [self createSubViews];
    [self loadData];
}

#pragma mark - 创建子视图 － 
- (void)createSubViews{
    [self setupTableView];
    [self setupBanner];

    [self setupBottomView];
}
#pragma mark - 加载数据 -
//商品详情
- (void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"id":self.goodsId,@"timestamp":kAPI_timestamp};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url =  KAPI_MerchantGoodDetail(self.goodsId, sig);
    NSLog(@"url ========%@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondobject = %@",respondObject);
        
       // [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if (IsSuccess) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];

            CMCFoodModel *foodModel = [[CMCFoodModel alloc] initWithDic:dataDic];
            [self.nextDic addEntriesFromDictionary:dataDic];
            [self.detailArr addObject:foodModel];
            [self createSubViews];
            if ([[dataDic objectForKey:@"image"] count]) {
             NSArray *imagesArr = [dataDic objectForKey:@"image"];
                for (NSString *imageStr in imagesArr) {
                    if (imageStr.length) {
                        NSURL *url = [BaseUtil systemRandomlyGenerated:imageStr type:@"11" number:@"1"];
                        [self.focusImageArray addObject:url];
                    }

                }
            }
            NSLog(@"数据加载失败=========%@",self.focusImageArray);
            //给banner上得数组赋值
            self.focusScorllView.imageArr = [NSMutableArray arrayWithArray:self.focusImageArray];
            //                        _qScrollView.imageArr = [NSMutableArray arrayWithArray:innerBannerArr];
            [self.focusScorllView creatWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130) cout:self.focusScorllView.imageArr.count];
        }
//        NSLog(@"数据加载失败  %@",self.nextDic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [BaseUtil toast:@"数据加载失败"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    
    
}

- (void)setupBanner{
//    _bannerImgV = [[UIImageView alloc]init];
//    _bannerImgV.frame = CGRectMake(0, 0, self.view.width, 160);
//    _bannerImgV.backgroundColor = [UIColor redColor];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    
    self.focusScorllView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];    //    self.myTableview.tableHeaderView = _qScrollView;
//    [_backScrollView addSubview:_qScrollView];
    [_backView addSubview:self.focusScorllView];
    self.myTableView.tableHeaderView = _backView;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.frame = CGRectMake(0, 155, self.view.frame.size.width, 25);//0, 0, 320, 25
    _pageControl.currentPage = 0;
//    [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    [_backView addSubview:_pageControl];
}

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 63) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = _bannerImgV;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
    
}

- (void)setupBottomView{
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0,self.view.height - 63, self.view.width, 63);
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 11,self.view.width - 30, 41);
    [button setTitle:@"预约看房" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(preBookTime:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];

}

//预约看房
- (void)preBookTime:(UIButton *)sender{
    CMCPreLookHouseVC *houseVC = [[CMCPreLookHouseVC alloc]init];
    houseVC.preDic = self.nextDic;
    houseVC.merchant_id  = self.mid;
    houseVC.service_id = self.service_id;
    houseVC.goodsID = self.goodsId;//0319
    [self.navigationController pushViewController:houseVC animated:YES];
}

#pragma mark - tableviewdelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 14;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一分区
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 55;
        }
        if (indexPath.row == 1) {
            if (self.detailArr.count) {
                CMCFoodModel *foodModel = [self.detailArr objectAtIndex:0];
                NSString *str = foodModel.intro;
                CGRect rect = [BaseUtil returnHeightWithContent: str WithFont:14 width:232 height:0];
                CGFloat heigt = rect.size.height;
                NSLog(@"qqqqqqqqqqqqqqq%f",heigt);
                return  heigt + 20;

            }

//            return 100;

        }
//        if (indexPath.row == 2) {
////            CGFloat heigt = [BaseUtil returnHeightWithContent: @"床    沙发    热水器   洗衣机   电饭锅   电视   空调   煤气   宽带网   暖气  冰箱" WithFont:13 width:232 height:0];
////            return heigt + 30;
//            
//        }
    }
    //第二分区
    if (indexPath.section == 1) {
        return 44;
    }
    
    //第三分区
    CGRect rect = [BaseUtil returnHeightWithContent:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试" WithFont:13 width:self.view.width - 20 height:0];
    CGFloat heigt = rect.size.height;
    return heigt + 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CMCPaketInfoCell *cell = [[CMCPaketInfoCell alloc]init];
        if (self.detailArr.count) {
            CMCFoodModel *food = [self.detailArr objectAtIndex:0];
//            cell.dataStr = food.intro;

        }
//        cell.dataStr = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        return cell;
    }
    CMCHoseDetailCell *cell = [[CMCHoseDetailCell alloc]init];
    if (self.detailArr.count) {
        CMCFoodModel *food = [self.detailArr objectAtIndex:0];
        cell.foodModel = food;
        
    }
    cell.indexPath = indexPath;
    return cell;
    
    
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
