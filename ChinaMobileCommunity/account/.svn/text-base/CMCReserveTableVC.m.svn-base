//
//  CMCReserveTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-8.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCReserveTableVC.h"
#import "CMCReserveTableViewCell.h"
#import "CMCBooking.h"
#import "CMCMyBookingDetailsVC.h"

@interface CMCReserveTableVC ()
{

    NetWorkRequest *_request;
    NetWorkRequest *_cancelRequest;
}
//@property (nonatomic, strong) NSMutableArray *peoplenumArray ;//人数
//@property (nonatomic, strong) NSMutableArray *desknumArray ;//桌数
//@property (nonatomic, strong) NSMutableArray *typeArray ; //预订房间
//@property (nonatomic, strong) NSMutableArray *reservetimeArray ;//预定时间
//@property (nonatomic, strong) NSMutableArray *addtimeArray ;//日期
//@property (nonatomic, strong) NSMutableArray *category_idArray ;//
//@property (nonatomic, strong) NSMutableArray *merchant_nameArray ;//商家名字
//@property (nonatomic, strong) NSMutableArray *merchant_imageArray ;//商家图片
//@property (nonatomic, strong) NSMutableArray *usernameArray ;//商家图片
@property (nonatomic, strong) NSMutableArray *bookArr;


@end

@implementation CMCReserveTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:backView];
//    backView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    _cancelRequest = [[NetWorkRequest alloc] init];
    _cancelRequest.delegate = self;
    self.bookArr = [[NSMutableArray alloc] init];

    [BaseUtil setExtraCellLineHidden:self.tableView];
    self.tableView.hidden = YES;
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"token":[CMCUserManager shareManager].token,@"channel":kAPI_channel,@"timestamp":kAPI_timestamp};
  NSString *sig = [BaseUtil getSigWithArray:dic];
    
  NSString *postStr = kAPI_getMyReserve([CMCUserManager shareManager].token,[BaseUtil md5:sig]);
    [_request loadDataWithURLString:postStr];

}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    if (_request == netWorkRequest) {
        [self.bookArr removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"我的预订 %@",dic);
        NSDictionary *infoDic = [dic objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([dic objectForKey:@"data"]) {
                NSArray *dataArr = [dic objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCBooking *book = [[CMCBooking alloc] initWithBookDic:tempDic];
                    [self.bookArr addObject:book];
                    
                }
                self.tableView.hidden = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];
            } else {
                
                [self creat_NOOrder];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
            }
        }

    }
    if (_cancelRequest == netWorkRequest) {
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *infoDic= [dic objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [BaseUtil toast:@"取消预订成功"];
            [self loadData];
        }else {
            [BaseUtil toast:@"取消预订失败"];
        
        }
    }

}
- (void)creat_NOOrder
{
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(33, 31, 85, 100)];
    imageView.image = [UIImage imageNamed:@"no_order"];
    [backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + 33+12, 66+ 43, 200, 30)];
    label.text = @"您暂时还没有订单哦";
    [backView addSubview:label];
}
//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didClickItems:(int)number
{
    CMCBooking *book = [self.bookArr objectAtIndex:number];
    NSString *str= kAPI_timestamp;
    NSDictionary *dic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"rid":book.id,@"timestamp":str};
   NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr = KAPI_Clearreserve(str, [BaseUtil md5:sig], book.id, [CMCUserManager shareManager].token);
    [_cancelRequest loadDataWithURLString:requestStr];



}


#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
//    return self.msgArray.count;
    return self.bookArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CMCReserveTableViewCell";
    CMCReserveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"CMCReserveTableViewCell" owner:self options:0] lastObject];
        cell = [[CMCReserveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CMCBooking *book = [self.bookArr objectAtIndex:indexPath.row];
    [cell creatTableViewBooking:book number:indexPath.row];

    
    
    
  
//    if ([[self.typeArray objectAtIndex:indexPath.row]isEqualToString:@"散桌"]) {
//    }
//    cell.bookRoomLabel.text = [self]
    
//cell.downImageView
    
    // Configure the cell...
//    cell.cancelButton.layer.cornerRadius = 10;
//    cell.orderButton.layer.cornerRadius = 10;
//    
//        cell.detailLabel.text = [self.msgArray objectAtIndex:indexPath.row];
//        cell.orderNumberLabel.text = [self.order_numArray objectAtIndex:indexPath.row];
//        cell.shoperLabel.text = [self.shop_nameArray objectAtIndex:indexPath.row];
//            cell.cancelButton.selected = NO;
//            cell.priceLabel.text = [self.priceArray objectAtIndex:indexPath.row];
//            cell.totalLabel.text = [self.sum_priceArray objectAtIndex:indexPath.row];
//            cell.timeLabel.text = [self.timeArray objectAtIndex:indexPath.row];
//
//        
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.250/cc/%@",[self.imgArray objectAtIndex:indexPath.row]]];
//            [cell.downImageView setImageWithURL:url];
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    CMCMyBookingDetailsVC *myBookingDetailVC = [[CMCMyBookingDetailsVC alloc] init];
//    [self.navigationController pushViewController:myBookingDetailVC animated:YES];



}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
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
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
