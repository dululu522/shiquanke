//
//  CMCYouHuiDetailVC.m
//  ChinaMobileCommunity
//
//  Created by 武鹏 on 14-11-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCYouHuiDetailVC.h"
//#import "UIImageView+UIImageView_WebCache.h"
#import "UIImageView+WebCache.h"
#import "CMCYouHuiModel.h"
#import "Config.h"
#import "ShopKnowCell.h"
#import "CMCTitleCell.h"
#import "CMCPictureVC.h"

#import "CycleScrollView.h"
@interface CMCYouHuiDetailVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *photoURLStringArray; //  图片URL数据数组

//@property (nonatomic, strong) UIScrollView *showImageViewScrollView;    //  展示图片轮播图
//@property (nonatomic, strong) UIPageControl *showImageViewPageControl;  //  展示图片
@property (nonatomic, strong) CycleScrollView *myScrollview;
@property (nonatomic, strong) UIPageControl *myPageControl;
@property (nonatomic,strong) UITableView *myTableView;

//@property (nonatomic,strong)CMCYouHuiModel *youHuiModel;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *DgArr;
@property (nonatomic, strong) NSMutableArray *youhuiArr;

@end

@implementation CMCYouHuiDetailVC

- (NSMutableArray *)imageArr{
    if (_imageArr == nil) {
        self.imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray *)DgArr{
    if (_DgArr == nil) {
        self.DgArr = [NSMutableArray array];
    }
    return _DgArr;
}
- (NSMutableArray *)youhuiArr
{
    if (_youhuiArr == nil) {
        self.youhuiArr = [NSMutableArray array];
    }
    return _youhuiArr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"优惠券详情";
    
//    [self addTimer];
//    [self createTableView];
    [self createTableView];
//    [self createSubViews];
//    [self.myTableView addSubview:self.showImageViewPageControl];
#warning mark - 暂时修改 －
    //后退按钮
    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    [billButton setBackgroundImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [billButton addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    
}
- (void)creatScrollView
{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    for (int i = 0; i < 5; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        tempLabel.backgroundColor = [(UIColor *)[colorArray objectAtIndex:i] colorWithAlphaComponent:0.5];
        [viewsArray addObject:tempLabel];
    }
    
    self.myScrollview = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) animationDuration:2];
    self.myScrollview.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.myScrollview.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.myScrollview.totalPagesCount = ^NSInteger(void){
        return 5;
    };
    self.myScrollview.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
    };
    [self.view addSubview:self.myScrollview];

 
}
//返回
- (void)didClickBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
//    kAPI_getCouponDetail(coupon_id)
    [BaseUtil get:kAPI_getCouponDetail(self.coupon_id) success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        NSLog(@"代金券详情===%@",kAPI_getCouponDetail(self.coupon_id));
        if ([[jsonObject objectForKey:@"status"] intValue] == 1) {
            [self.imageArr removeAllObjects];
            [self.DgArr removeAllObjects];
            NSDictionary *infoDic = [jsonObject objectForKey:@"info"];
            NSArray *imgArray = [infoDic objectForKey:@"image"];
//            NSArray *dis_goodsArray = [infoDic objectForKey:@"dis_goods"];
//            for (NSDictionary *tempDic in dis_goodsArray) {
//                
//                
//                
//            }
            NSArray *dis_goodsArr = [infoDic objectForKey:@"dis_goods"];
            for (NSDictionary *tempDic in dis_goodsArr) {
                CMCYouHuiModel *youhuiModel = [[CMCYouHuiModel alloc] initWithYouHuiData:tempDic];
                [self.youhuiArr addObject:youhuiModel];
                
            }
            
//            self.youHuiModel = [CMCYouHuiModel initYouHuiData:infoDic];
            for (NSString *str in imgArray) {
                [self.imageArr addObject:str];
            }
            [self creatScrollView];
//            for (NSString *str in dis_goodsArray) {
//                
//                [self.DgArr addObject:str];
//            }
//            
//           [self createSubViews];
//            self.myTableView.tableHeaderView = self.showImageViewScrollView;
//            [self.myTableView addSubview:self.showImageViewPageControl];
//            //加载图片
//            for (int i = 0; i < self.DgArr.count; i++) {
//                UIImageView *picImageView = (UIImageView *)[self.view viewWithTag:100+i];
//                [picImageView sd_setImageWithURL:[self.DgArr objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"log"]];
//                
//            }
            
            [self.myTableView reloadData];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}


//创建tableview
- (void)createTableView{
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
}


////  创建cell子视图
//- (void)createSubViews
//{
//    //  创建scrollView
//    [self createScrollView];
//    
//    //  创建pageControl
//    [self createPageControl];
//}

//  添加定时器, 实现轮播图
//- (void)addTimer
//{
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
//}

////  创建scrollView
//- (void)createScrollView
//{
//    self.showImageViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 200)];
//    
//    self.showImageViewScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.imageArr.count, 0);
//    //  锁定滑动方向
//    self.showImageViewScrollView.directionalLockEnabled = NO;
//    //  弹跳效果
//    self.showImageViewScrollView.bounces = NO;
//    //  分页效果
//    self.showImageViewScrollView.pagingEnabled = YES;
//    //  滚动条
//    self.showImageViewScrollView.showsHorizontalScrollIndicator = NO;
//    self.showImageViewScrollView.showsVerticalScrollIndicator = NO;
//    
//    self.showImageViewScrollView.delegate = self;
//    
//    //  scrollView 上面添加imageView
//    for (int i = 0; i < self.imageArr.count; i++)
//    {
//        NSLog(@"----------------------%d",self.imageArr.count);
//        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.bounds.size.width, self.showImageViewScrollView.frame.size.height)];
//        picImageView.tag = 100+i;
//        picImageView.backgroundColor = [UIColor colorWithRed:arc4random()%2  green:arc4random()%2 blue:arc4random()%2 alpha:1];
//        
//        [self.showImageViewScrollView addSubview:picImageView];
//        
//    }
//    
//}


////  创建pageControl
//- (void)createPageControl
//{
//    self.showImageViewPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120,180, 80, 20)];
//    
//    
//    //  页数
//    self.showImageViewPageControl.numberOfPages = self.imageArr.count;
//    self.showImageViewPageControl.backgroundColor = [UIColor clearColor];
//    //  页码控制点颜色
//    self.showImageViewPageControl.pageIndicatorTintColor = [UIColor grayColor];
//    self.showImageViewPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    //  pageControl 添加目标事件
//    [self.showImageViewPageControl addTarget:self action:@selector(didClickPageControlActionWith:) forControlEvents:UIControlEventValueChanged];
//    
//}
//
////  pageControl 点击相应事件
//- (void)didClickPageControlActionWith:(UIPageControl *)sender
//{
//    NSInteger currentPage = self.showImageViewPageControl.currentPage;
//    CGPoint offsetPoint = CGPointMake(currentPage * self.view.frame.size.width, 0);
//    
//    //  根据当前currentPage 滚动scrollView
//    [self.showImageViewScrollView setContentOffset:offsetPoint animated:YES];
//}
//
////  定时器响应方法
//- (void)runTimer
//{
//    if (self.showImageViewPageControl.currentPage == self.imageArr.count) {
//        self.showImageViewPageControl.currentPage = 0;
//    } else {
//        self.showImageViewPageControl.currentPage++;
//    }
//    
//    NSInteger currentPage = self.showImageViewPageControl.currentPage;
//    CGPoint offsetPoint = CGPointMake(self.view.frame.size.width *currentPage, 0);
//    
//    //  scrollView偏移到当前currentPage
//    [self.showImageViewScrollView setContentOffset:offsetPoint animated:YES];
//}
//
//
//#pragma mark - ScrollView Delegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //  计算scrollView的contentOffset 设置pageControl的currentPage
//    CGPoint offsetPoint = scrollView.contentOffset;
//    self.showImageViewPageControl.currentPage = offsetPoint.x / self.view.frame.size.width;
//}
//


//- (void)setPhotoURLStringArray:(NSMutableArray *)photoURLStringArray{
//    if (_photoURLStringArray != photoURLStringArray) {
//        _photoURLStringArray = photoURLStringArray;
//    }
//    
//    for (int i = 0; i < 3; i++) {
//        UIImageView *picImageView = (UIImageView *)[self.view viewWithTag:100+i];
//        [picImageView sd_setImageWithURL:[self.photoURLStringArray objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"log"]];
//        
//    }
//    
//    NSLog(@"photo array = %@",_photoURLStringArray);
//}




#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
            return 80;
            break;
        case 1:
            return 60;
            break;
        case 2:
//            if ([self.youHuiModel.is_promise isEqualToString:@"1"]) {
//                return 40;
//            }else{
//                return 0;
//            }
//            break;
        case 3:
            
            return 40;
            break;
        case 4:
            return self.DgArr.count * 20;
            break;
        case 5:
            return 50;
            break;
        case 6:
            return 20;
            break;
        case 7:
            return 300;
            break;
            break;
        default:
            break;
    }
    
    
    return 500;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
//        CMCTitleCell *cell = [[CMCTitleCell alloc]init];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.titleLable.text = self.youHuiModel.titleStr;
//        cell.detailLable.text = self.youHuiModel.desPtion;
//        
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 80 - 1, self.view.frame.size.width, 1)];
//        view.backgroundColor = [UIColor lightGrayColor];
//        [cell addSubview:view];
//        
//        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
//        view1.backgroundColor = [UIColor lightGrayColor];
//        [cell addSubview:view1];
        
        return cell;
    }
    if (indexPath.row == 1) {
//        cell.imageView.image = [UIImage imageNamed:@"时间_10.png"];
//        cell.textLabel.text = @"限时抢购：22天3小时22分";
//        cell.textLabel.text = self.youHuiModel.end_time;
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60 - 1, self.view.frame.size.width, 1)];
//        view.backgroundColor = [UIColor lightGrayColor];
//        [cell addSubview:view];
        return cell;
    }
    if (indexPath.row == 2) {
//        cell.imageView.image = [UIImage imageNamed:@"对号_13.png"];
//        if ([self.youHuiModel.is_promise isEqualToString:@"1"]) {
//            cell.textLabel.text = @"须提前预约";
//        }
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 40 - 1, self.view.frame.size.width, 1)];
        view.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:view];
        return cell;
        
    }
    
    if (indexPath.row == 3) {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"优惠详情";
        return cell;
        
    }
    
    
    if (indexPath.row == 4) {
        if (self.DgArr.count != 0) {
            for (int i = 0; i < self.DgArr.count; i++) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20 * i, 100, 20)];
                label.text = [self.DgArr objectAtIndex:i];
                //                label.backgroundColor = [UIColor orangeColor];
                [cell addSubview:label];
            }
            
            
        }
        
        
        return cell;
    }
    if (indexPath.row == 5) {
        cell.textLabel.text = @"查看图文详情";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
    
    if (indexPath.row == 7) {
        ShopKnowCell *cell =  [[[NSBundle mainBundle] loadNibNamed:@"ShopKnowCell" owner:self options:0] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i < 3; i++) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(85, 61 + i*65, 8, 8)];
            view.layer.cornerRadius = 4;
            view.clipsToBounds = YES;
            view.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:view];
        }
//        cell.end_timeL.text = [NSString stringWithFormat:@"有效期%@天",self.youHuiModel.life];
//        cell.noticeL.text = self.youHuiModel.notice;
//        cell.ruleL.text = self.youHuiModel.information;
        
        
        return cell;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 39, 20)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 100, 60)];
    lable.font = [UIFont systemFontOfSize:20];
    lable.textColor = [UIColor greenColor];
//    lable.text = [NSString stringWithFormat:@"%@折",self.youHuiModel.discount];
    [view addSubview:lable];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(210, 10, 90, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"booking@2x.png"]forState:UIControlStateNormal];
    [button setTitle:@"立即购买" forState:UIControlStateNormal];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:button];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
       
//        CMCPictureVC *pictureVC = [[CMCPictureVC alloc]init];
//        pictureVC.youhuiModel = self.youHuiModel;
//        pictureVC.goodsArr = self.DgArr;
//        [self.navigationController pushViewController:pictureVC animated:YES];
    }
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
