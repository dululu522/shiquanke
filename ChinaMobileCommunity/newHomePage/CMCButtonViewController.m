//
//  CMCButtonViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCButtonViewController.h"
//#import "CMCButtonTableViewCell.h"
#import "CMCShopDetailViewController.h"

#import "CMCFoodHomeTableViewCell.h"
#import "CMCFood.h"

@interface CMCButtonViewController ()
{
    
    NSString *_currentPage;
    UIButton *_tasteButton;
    UIButton *_speedButton;
    UIButton *_severceButton;
    NSInteger _page;
    NSInteger _number;
    
}
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UITableView *speedTableView;
@property (strong, nonatomic)  UITableView *serveTableView;


@property (strong, nonatomic) NSMutableArray *foodArr;
@property (strong,nonatomic) NSString *type;
@end

@implementation CMCButtonViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    [self createHeaderView];
    [self showRefreshHeader:YES];
    self.title = self.merchant_name;
    self.foodArr = [[NSMutableArray alloc] init];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width - 50, 31)];
//    label.backgroundColor = kAPI_color;
    label.text = [NSString stringWithFormat:@"当前:%@",[CMCUserManager shareManager].address];
    label.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    [label setFont:[UIFont fontWithName:nil size:12.0]];
//    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    self.type = @"口味";
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(label.bounds.size.width + 20, 40 + 5, 20, 20)];

    [newButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    newButton.layer.cornerRadius = 5;
    [self.view addSubview:newButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.hidden = YES;



    [self creatThreeButton];
    [self didClickTasteButton];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self creatBackButton];

}
- (void)creatBackButton
{
    //后退按钮
    UIView *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    UIImageView *billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10,10, 20)];
    [backView addSubview:billImageView];
    
    billImageView.image = [UIImage imageNamed:@"后退_03"];
    billImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackBtn:)];
    [backView addGestureRecognizer:tap];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    
    //    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)didClickBackBtn:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    //上拉刷新
    if (aRefreshPos == EGORefreshHeader) {
        _page = 1;
        
    }else if (aRefreshPos == EGORefreshFooter){
        //下拉加载
        _page++;

    }
    [self loadDataType:self.type];

    
}

- (void)creatSearchButton
{
    //搜索
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"homepage_search"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(didClickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
}
- (void)didClickSearchButton:(UIButton *)button
{
    
    
    
    
}
- (void)creatThreeButton
{
    _tasteButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 0,( self.view.bounds.size.width - 10)/3, 40)];
    _tasteButton.tag = 1000;
    [_tasteButton setTitle:@"口味" forState:UIControlStateNormal];
    _tasteButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_tasteButton setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [_tasteButton setBackgroundImage:[UIImage imageNamed:@"list_taste"] forState:UIControlStateNormal];
    [_tasteButton addTarget:self action:@selector(didClickTasteButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tasteButton];
    
    [_tasteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    _speedButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 10)/3 + 5, 0,( self.view.bounds.size.width - 10)/3, 40)];
    _speedButton.tag = 1101;
    _speedButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
  [_speedButton setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [_speedButton setTitle:@"速度" forState:UIControlStateNormal];
    [_speedButton addTarget:self action:@selector(didClickSpeedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_speedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self.view addSubview:_speedButton];
    
    _severceButton = [[UIButton alloc] initWithFrame:CGRectMake(2*(self.view.bounds.size.width - 10)/3 + 5, 0,( self.view.bounds.size.width - 10)/3, 40)];
    [_severceButton setTitle:@"服务" forState:UIControlStateNormal];
    _severceButton.tag = 1102;
    _severceButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
  [_severceButton setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [_severceButton setBackgroundImage:[UIImage imageNamed:@"list_serve"] forState:UIControlStateNormal];
    [_severceButton addTarget:self action:@selector(didClickSeverceButton:) forControlEvents:UIControlEventTouchUpInside];
    [_severceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    //    _severceButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_severceButton];
    [self didClickSeverceButton:nil];



}

- (void)loadDataType:(NSString *)type 
{
    self.tableView.hidden = NO;
    [BaseUtil setExtraCellLineHidden:self.tableView];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.merchant_name == nil) {
        self.merchant_name = @"";
    }

    if (_page == 1) {
        [self.foodArr removeAllObjects];
    }
//    NSDictionary *dic = @{@"trade_id":self.merchant_type,@"zid":[CMCUserManager shareManager].zid,@"type":type,@"nums":@"8",@"page":[NSString stringWithFormat:@"%ld",(long)_page]};
//    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"timestamp":kAPI_timestamp,@"app_ver":APPVersion,@"zid":[CMCUserManager shareManager].zid};
    NSString *timeStamp = kAPI_timestamp;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"zid":[CMCUserManager shareManager].zid,@"trade_id":self.merchant_type,@"page":pageStr,@"nums":@"8",@"timestamp":timeStamp};
    
    
    
    
//    NSDictionary *requestDic = [BaseUtil postString:[dic JSONString] postUrlString:[NSString stringWithFormat:@"%@/merchant/list",kAPI_loc_entry]];
//    
//    
//    
//    NSDictionary *infoDic = [requestDic objectForKey:@"info"];
//    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if ([requestDic objectForKey:@"data"]) {
//            NSArray *dataArr = [requestDic objectForKey:@"data"];
//            for (NSDictionary *tempDic in dataArr) {
//                
//                CMCFood *merchantList = [[CMCFood alloc] initWithFood:tempDic];
//                [self.foodArr addObject:merchantList];
//            }
//            self.tableView.hidden = NO;
//            [self.tableView reloadData];
//            [self finishReloadingData];
//            [self setFooterView]; 
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        } else {
//            self.tableView.hidden = NO;
//            [self.tableView reloadData];
//            [BaseUtil toast:@"数据已加载完毕"];
//        
//        }
//        
//
//        
//    } else {
//    
//        [BaseUtil toast:@"加载数据失败"];
//        return;
//    }


}


- (void)loadTableView
{
    [self.tableView  removeFromSuperview];
    self.tableView = nil;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 40+30, self.view.bounds.size.width - 10,self.view.bounds.size.height - 80)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];


}

//点击口味
- (void)didClickTasteButton
{
//    [self.foodArr removeAllObjects];
    [self.tableView  removeFromSuperview];
    
    _page = 1;


    [_tasteButton setBackgroundColor:[UIColor colorWithHexString:@"ebebeb"]];
    _severceButton.backgroundColor = [UIColor whiteColor];
    _speedButton.backgroundColor = [UIColor whiteColor];;
    [self loadDataType:@"taste"];
    self.type = @"taste";
    [self loadTableView];
    [self createHeaderView];
    [self showRefreshHeader:YES];

}
//点击速度
- (void)didClickSpeedButton:(UIButton *)button
{
    _page = 1;

    [self loadTableView];
    [_speedButton setBackgroundColor:[UIColor colorWithHexString:@"ebebeb"]];
    _tasteButton.backgroundColor = [UIColor whiteColor];
    _severceButton.backgroundColor = [UIColor whiteColor];
    [self loadDataType:@"speed"];
    [self.tableView reloadData];
    self.type = @"speed";
    [self createHeaderView];
    [self showRefreshHeader:YES];


}
- (void)didClickSeverceButton:(UIButton *)button
{
    _page = 1;
//    [self loadTableView];
    [_severceButton setBackgroundColor:[UIColor colorWithHexString:@"ebebeb"]];
    _tasteButton.backgroundColor = [UIColor whiteColor];
    _speedButton.backgroundColor = [UIColor whiteColor];
    [self loadDataType:@"serve"];
    [self.tableView reloadData];
    self.type = @"serve";
    [self createHeaderView];
    [self showRefreshHeader:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView) {
        return self.foodArr.count;

    }
    return 0;

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *str = @"reused";
        CMCFoodHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCFoodHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        

        
        CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
        [cell creatcellfood:food];
        return cell;
    }

    return nil;


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
            return 99;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
            CMCShopDetailViewController *shopDetailVC = [[CMCShopDetailViewController alloc] init];
            shopDetailVC.hidesBottomBarWhenPushed = YES;
    CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
    shopDetailVC.merchant_id = food.merchant_id;

    [self.navigationController pushViewController:shopDetailVC animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
