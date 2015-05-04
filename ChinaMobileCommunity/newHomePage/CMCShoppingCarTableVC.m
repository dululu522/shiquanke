//
//  CMCShoppingCarTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShoppingCarTableVC.h"

#import "CMCShoppingCarTableViewCell.h"

#import "CMCPaymentDetailsVC.h"
//#import "CMCShopCarPaymentDetailVC.h"
//#import "YRJSONAdapter.h"

@interface CMCShoppingCarTableVC ()
{

    float allPrice;
    UILabel *_combinedLabel;
    UIView *_backView;
    UIButton *_allButton;
    UIButton *_goToButton;


}
@property (nonatomic, strong) NSMutableArray *idArr;
@property (nonatomic, strong) NSMutableArray *goods_nameArr;
@property (nonatomic, strong) NSMutableArray *priceArr;
@property (nonatomic, strong) NSMutableArray *quantityArr;
@property (nonatomic, strong) NSMutableArray *amountArr;
@property (nonatomic, strong) NSMutableArray *default_imageArr;
@property (nonatomic, strong) NSMutableArray *discripArr;
@property (nonatomic, strong) NSString *shop_nameStr;




@end

@implementation CMCShoppingCarTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatButtomView];
}
- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [_backView removeFromSuperview];
    [_goToButton removeFromSuperview];
    [_allButton removeFromSuperview];
    [_combinedLabel removeFromSuperview];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kAPI_color;
    self.navigationController.navigationBar.translucent = NO;
    
    UIImage *image=[UIImage imageNamed:@"后退_03.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
    

    self.idArr = [[NSMutableArray alloc] init];
    self.goods_nameArr = [[NSMutableArray alloc] init];
    self.priceArr = [[NSMutableArray alloc] init];
    self.quantityArr = [[NSMutableArray alloc] init];
    self.amountArr = [[NSMutableArray alloc] init];
    self.default_imageArr = [[NSMutableArray alloc] init];
    self.discripArr = [[NSMutableArray alloc] init];
    [self loadData];



    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//创建底部的控件
- (void)creatButtomView
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+ 15 , self.view.bounds.size.width, 49)];
    _backView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [self.navigationController.view addSubview:_backView];
    
    _allButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
    [_allButton setBackgroundImage:[UIImage imageNamed:@"小车_07"] forState:UIControlStateNormal];
    [_backView addSubview:_allButton];
    _combinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(_allButton.frame.origin.x + _allButton.frame.size.width, _allButton.frame.origin.y, 150, 24)];
    _combinedLabel.font = [UIFont fontWithName:nil size:17.0];
    
//    _combinedLabel.text = [NSString stringWithFormat:@"合计:%@",self.priceText];
    [_backView addSubview:_combinedLabel];
    
    _goToButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 110, 5, 100, 40)];
    [_goToButton setTitle:@"去结算" forState:UIControlStateNormal];
    [_goToButton setBackgroundImage:[UIImage imageNamed:@"代理费_03"] forState:UIControlStateNormal];
    [_goToButton addTarget: self action:@selector(clickGoToButton:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_goToButton];
    
    float n = 0;
    for (int i = 0; i < self.priceArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CMCShoppingCarTableViewCell *cell = (CMCShoppingCarTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        //        n = cell.priceLable.text.floatValue * cell.numberLabel.text.intValue;
        n += [[self.priceArr objectAtIndex:i] floatValue] * [cell.numberLabel.text intValue];
        //       _combinedLabel.text = [NSString stringWithFormat:@"合计:￥%.2f",n];
        _combinedLabel.text =  [NSString stringWithFormat:@"合计:%.2f",n];
        
    }

    

}
- (void)didClickBackButton:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];




}
#pragma mark -
#pragma mark - CMCShoppingCarTableViewCellDelegate
- (void)didClickItems:(int) items
{
    float n = 0;
    for (int i = 0; i < self.priceArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CMCShoppingCarTableViewCell *cell = (CMCShoppingCarTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//        n = cell.priceLable.text.floatValue * cell.numberLabel.text.intValue;
        n += [[self.priceArr objectAtIndex:i] floatValue] * [cell.numberLabel.text intValue];
//       _combinedLabel.text = [NSString stringWithFormat:@"合计:￥%.2f",n];
       _combinedLabel.text =  [NSString stringWithFormat:@"合计:%.2f",n];
        
    }




}


#pragma mark -
#pragma mark - 加载数据
- (void)loadData
{
    //http://192.168.1.250/cc/index.php/api/buycar/mybuycarlist?user_id=15&shop_id=1
    

[BaseUtil get:kAPI_mybuycarlist(@"29",self.shop_id) success:^(AFHTTPRequestOperation *operation, id jsonObject) {
    NSLog(@"我的购物车 === %@",kAPI_mybuycarlist([CMCUserManager shareManager].userInfo.id,self.shop_id));
    NSLog(@"我的购物车  %@",jsonObject);
    [BaseUtil errorMesssage:jsonObject];
    if ([[jsonObject objectForKey:@"info"] isKindOfClass:[NSString class]]) {
        return ;
    }
    if ([[jsonObject objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *infoDic = [jsonObject objectForKey:@"info"];
        self.shop_nameStr = [infoDic objectForKey:@"shop_name"];
        NSArray *goodslistArr = [infoDic objectForKey:@"goodslist"];
        for (NSDictionary *tempDic in goodslistArr) {
            [self.idArr addObject:[tempDic objectForKey:@"goods_id"]];
            [self.goods_nameArr addObject:[tempDic objectForKey:@"goods_name"]];
            [self.priceArr addObject:[tempDic objectForKey:@"price"]];
            [self.quantityArr addObject:[tempDic objectForKey:@"quantity"]];
            [self.amountArr addObject:[tempDic objectForKey:@"amount"]];
            [self.default_imageArr addObject:[tempDic objectForKey:@"default_image"]];
            [self.discripArr addObject:[tempDic objectForKey:@"discription"]];
        }

        [self.tableView reloadData];

    }
    
} faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];



}
#pragma mark -
#pragma mark - 去结算
- (void)clickGoToButton:(UIButton *)button
{
    
    
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.goods_nameArr.count; i++) {
//        CMCDianCan *dianCan = [self.dianCanArr objectAtIndex:i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CMCShoppingCarTableViewCell *cell = (CMCShoppingCarTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        NSDictionary *dic = @{@"id":[self.idArr objectAtIndex:i],@"num":cell.numberLabel.text};
        [array addObject:dic];
    }
    NSLog(@"array ==== %@",array);
    ;
    NSDictionary *newDic =@{@"user_id":@"29",@"shop_id":self.shop_id,@"type":@"1",@"goodslist":array};
    NSLog(@"newDic == %@",newDic);
    
    //    NSDictionary *infoDic = @{@"info":@{@"user_id":@"29",@"shop_id":self.merchant_id,@"type":@"1",@"goodslist":array}};
    ////    NSLog(@"=====%@",[infoDic JSONString]);
    //    NSString *post = [NSString stringWithFormat:@"%@",[infoDic JSONString]];
    NSString *post = [NSString stringWithFormat:@"%@",[newDic JSONString]];
    NSLog(@"post ==== %@",post);
    
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //定义NSMutableURLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    //设置提交目的url
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.11:8201/api/order/addorder"];
    [request setURL:[NSURL URLWithString:urlString]];
    //设置提交方式为 POST
    [request setHTTPMethod:@"POST"];
    //设置需要post提交的内容
    [request setHTTPBody:postData];
    //定义
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型。
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"responseData ==== %@",responseData);
    //将NSData类型的返回值转换成NSString类型
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"result ==== %@",result);
    //    NSLog(@"user login check result:  %@",result);
    
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSLog(@"tempDic  == %@",tempDic);
    if ([[tempDic objectForKey:@"status"] isEqualToString:@"1"]) {
        //        [BaseUtil toast:@"预订成功"];
        CMCPaymentDetailsVC *paymentDetailVC = [[CMCPaymentDetailsVC alloc] init];
        paymentDetailVC.tempDic = tempDic;
        paymentDetailVC.numberCount = array.count;
        
        [self.navigationController pushViewController:paymentDetailVC animated:YES];
    } else{
        
        //        [BaseUtil toast:@"预订失败"];
    }
    
    
    
    //    } else {
    //
    //        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
    //        [self.navigationController pushViewController:loginVC animated:YES];
    //
    //    }
    




}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.goods_nameArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMCShoppingCarTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CMCShoppingCarTableViewCell" owner:self options:0] lastObject];
    }
    cell.delegate = self;
    cell.nameLabel.text = [self.goods_nameArr objectAtIndex:indexPath.row];
    cell.nameLabel.textColor = [UIColor colorWithHexString:@"5b5b5b"];
    cell.contentTextView.text = [self.discripArr objectAtIndex:indexPath.row];
    cell.contentTextView.textColor = [UIColor colorWithHexString:@"898989"];
    cell.contentTextView.userInteractionEnabled = NO;
    cell.priceLable.text = [NSString stringWithFormat:@"￥%@",[self.priceArr objectAtIndex:indexPath.row]];
    cell.priceLable.font = [UIFont fontWithName:nil size:17.0];
    cell.numberLabel.text = [self.quantityArr objectAtIndex:indexPath.row];
    [cell.photoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kAPI_image,[self.default_imageArr objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"log"]];
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
  return self.shop_nameStr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30;

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
