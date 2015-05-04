//
//  CMCActivityNewlyOpenTVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivityNewlyOpenTVC.h"
#import "CMCActivityNewlyOpened.h"
#import "CMCActivityTableViewCell.h"
#import "CMCConvenientLifeDetailVC.h"

@interface CMCActivityNewlyOpenTVC ()
{
    NSInteger _page;
}
@property (nonatomic, strong) NSMutableArray *activityArr;
@end

@implementation CMCActivityNewlyOpenTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.activityArr = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self createHeaderView];
    [self showRefreshHeader:YES];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    [self loadNewlyOpenedData];
    [self creatBackButton];
}
- (void)creatBackButton
{
    //后退按钮
    //    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    
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
    [self loadNewlyOpenedData];
    
    
    
    
}
- (void)loadNewlyOpenedData
{
    if (_page == 1) {
        [self.activityArr removeAllObjects];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *timestamp = kAPI_timestamp;
    if ([CMCUserManager shareManager].token && k_zid) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"page":pageStr,@"nums":@"8",@"timestamp":timestamp};
        NSLog(@"%@",dic);
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = kAPI_newsmerchant(k_zid, pageStr, @"8", timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token);
        NSLog(@"requestUrl =%@",requestUrl);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"本周新开张 %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"info"] intValue] == 0) {
                    if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                        NSArray *dataArr = [respondObject objectForKey:@"data"];
                        if (dataArr.count) {
                            for (NSDictionary *tempDic in dataArr) {
                                CMCActivityNewlyOpened *activityNewlyOpened = [[CMCActivityNewlyOpened alloc] initWithActivityNewlyOpened:tempDic];
                                [self.activityArr addObject:activityNewlyOpened];
                            }
                            [self.tableView reloadData];
                                                    [self finishReloadingData];
                                                    [self setFooterView];
                            
                        }else {
                            [BaseUtil toast:@"数据已加载完毕"];
                        }
                        

                    }
            } else {
                [BaseUtil toast:@"服务端返回数据错误"];
            }

        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.activityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reused = @"CMCActivityTableViewCell";
    CMCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reused];
    if (cell== nil) {
        cell = [[CMCActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reused];
    }
    if (self.activityArr.count) {
        CMCActivityNewlyOpened *newlyOpened = [self.activityArr objectAtIndex:indexPath.row];
        [cell creatNewlyopenedCell:newlyOpened];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 94;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

 CMCActivityNewlyOpened *newlyOpened = [self.activityArr objectAtIndex:indexPath.row];

    CMCActivityNewlyOpened *activityNewlyOpened = [self.activityArr objectAtIndex:0];
    CMCConvenientLifeDetailVC *detailVC = [[CMCConvenientLifeDetailVC alloc] init];
    //        CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
    detailVC.mid = activityNewlyOpened.mid;
    //        detailVC.title = food.name;
    //        detailVC.category = self.merchant_name;
    [self.navigationController pushViewController:detailVC animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end