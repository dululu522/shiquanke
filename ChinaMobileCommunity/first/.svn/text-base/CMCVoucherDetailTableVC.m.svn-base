//
//  CMCVoucherDetailTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVoucherDetailTableVC.h"

@interface CMCVoucherDetailTableVC ()

@end

@implementation CMCVoucherDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    imageView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = imageView;
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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 100;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{


return @"现价";

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 80;


}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        backView.backgroundColor = [UIColor redColor];
        [self.view addSubview:backView];
        UILabel *presentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 30)];
        presentLabel.text = @"现价:";
        [backView addSubview:presentLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentLabel.frame.size.width + presentLabel.frame.origin.x, 30, 80, 30)];
        priceLabel.text = @"￥ 105";
        priceLabel.font = [UIFont fontWithName:nil size:14.0];
        [backView addSubview:priceLabel];
        
        UILabel *origPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x, priceLabel.frame.size.height + priceLabel.frame.origin.y - 10, 80, 30)];
        origPriceLabel.text = @"220";
        [backView addSubview:origPriceLabel];
        
        
        UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 105, 5, 100, 50)];
        [payButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [payButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [backView addSubview:payButton];
        
        return backView;
    }
    return nil;
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
