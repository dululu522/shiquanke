//
//  CMCSearchVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-9.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCSearchVC.h"
#import "CMCDisAndVouCell.h"
#import "CMCDicAndVoucherVC.h"
#import "CMCSearchVC.h"



@interface CMCSearchVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _page;

}

@property (nonatomic,strong)UISearchBar *mySearchBar;
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *resultArr;
@property (nonatomic, strong) NSMutableArray *couponArr;


@end

@implementation CMCSearchVC

- (NSMutableArray *)resultArr{
    if (_resultArr == nil) {
        self.resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.couponArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createSubViews];
}


#pragma mark - 创建子视图 - 

- (void)createSubViews{
    [self setupLeftBarItem];
    [self setupSearchBar];
    [self setupTableView];
    
}

- (void)setupLeftBarItem{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"后退_03"] style:UIBarButtonItemStyleBordered target:self action:@selector(didClickBackBtn)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"city_search"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchAction)];
    rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)didClickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchAction{
    
    NSLog(@"searchAction");
    
}

//创建searchBar
- (void)setupSearchBar{
    
    _mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 200, 40)];
    _mySearchBar.placeholder = @"请输入商家名";
    _mySearchBar.translucent = YES;
    _mySearchBar.backgroundImage = [UIImage imageNamed:@"确定"];
    [_mySearchBar sizeToFit];
    _mySearchBar.delegate = self;
    _mySearchBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = _mySearchBar;
    
}
    
    

- (void)setupTableView{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
}


#pragma mark - tableviewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        static NSString *cellIndentifier = @"discountCell";
        CMCDisAndVouCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCDisAndVouCell alloc]init];
        }
        cell.section = 0;
        [cell setupDownLoadBlock:^{
            NSLog(@"下载折扣");
        }];
        return cell;
    }
    if (indexPath.row % 2 == 1) {
        static NSString *cellIndentifier = @"voucherCell";
        CMCDisAndVouCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (nil == cell) {
            cell = [[CMCDisAndVouCell alloc]init];
        }
        cell.section = 1;
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CMCDicAndVoucherVC *disVC = [[CMCDicAndVoucherVC alloc]init];
    [self.navigationController pushViewController:disVC animated:YES];
    
    if (indexPath.row % 2 == 0 ) {
        disVC.category = @"折扣券详情";
    }
    if (indexPath.row % 2 == 1) {
        disVC.category = @"代金券详情";
    }
    
}


#pragma mark - searchBarDelegate - 
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{

    return YES;
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mySearchBar resignFirstResponder];
    
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
