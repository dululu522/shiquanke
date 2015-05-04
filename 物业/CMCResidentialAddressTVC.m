//
//  CMCResidentialAddressTVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCResidentialAddressTVC.h"
#import "CMCComplaintsVC.h"

@interface CMCResidentialAddressTVC ()
{
    NetWorkRequest *_request;

}
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *center_idArray;
@property (nonatomic, strong) NSMutableDictionary *center_idDic;

@end

@implementation CMCResidentialAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [BaseUtil setExtraCellLineHidden:self.tableView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    self.addressArray = [[NSMutableArray alloc] init];
    self.center_idArray = [[NSMutableArray alloc] init];
    self.center_idDic = [[NSMutableDictionary alloc] init];
    [self loadData];
    
    
    
}
//物业地址数据
- (void)loadData
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSString *timestamp = kAPI_timestamp;
//    if ([CMCUserManager shareManager].token) {
//        NSDictionary *dic = @{@"channel":kAPI_channel,@"mobile_phone":[CMCUserManager shareManager].phone,@"token":[CMCUserManager shareManager].token,@"timestamp":timestamp};
//        NSString *sig = [BaseUtil getSigWithArray:dic];
//        NSString *requestStr = KAPI_Addresslist([BaseUtil md5:sig], [CMCUserManager shareManager].token, [CMCUserManager shareManager].phone);
//        [_request loadDataWithURLString:requestStr];
//    }
}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        if ([dic objectForKey:@"data"]) {
            NSArray *dataArr = [dic objectForKey:@"data"];
            for (NSDictionary *tempDic in dataArr) {
                [self.addressArray addObject:[tempDic objectForKey:@"address"]];
                [self.center_idArray addObject:[tempDic objectForKey:@"center_id"]];
                [self.center_idDic setValue:[tempDic objectForKey:@"center_id"] forKey:[tempDic objectForKey:@"address"]];
                
            }
            [CMCUserManager shareManager].center_idDic = self.center_idDic;
            NSLog(@"呵呵呵呵+++++++%@",[CMCUserManager shareManager].center_idDic);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView reloadData];
        } else {
            [BaseUtil toast:@"暂无数据"];
            [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        }
    } else {
        [BaseUtil toast:@"服务端返回错误"];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

        
    }

}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.addressArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.addressArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [CMCUserManager shareManager].residentialAddressStr = [self.addressArray objectAtIndex:indexPath.row];
    [CMCUserManager shareManager].residentialCenter_id = [self.center_idArray objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];



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
