//
//  CMCSwitchPropertyAddressTVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-25.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCSwitchPropertyAddressTVC.h"
#import "CMCSwitchPropertyAddress.h"

@interface CMCSwitchPropertyAddressTVC ()
@property (nonatomic, strong) NSMutableArray *propertyAddrArr;
@property (nonatomic, strong) NSMutableArray *addressDicArr; //储存字典的数组

@end

@implementation CMCSwitchPropertyAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.propertyAddrArr = [[NSMutableArray alloc] init];
    self.addressDicArr = [[NSMutableArray alloc] init];
    if ([kAPI_Property count]) {
        NSArray *propertyAddressArr = kAPI_Property;
        NSLog(@"propertyAddressArr ======%@",propertyAddressArr);
        for (NSDictionary *tempDic in propertyAddressArr) {
            CMCSwitchPropertyAddress *address = [[CMCSwitchPropertyAddress alloc] initWithSwitchPropertyAddressDic:tempDic];
            [self.propertyAddrArr addObject:address];
            [self.addressDicArr addObject:tempDic];
        }
        [self.tableView reloadData];
    }
    

    [BaseUtil setExtraCellLineHidden:self.tableView];
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
    return self.propertyAddrArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *str = @"reuseIdentfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    // Configure the cell...
    CMCSwitchPropertyAddress *address = [self.propertyAddrArr objectAtIndex:indexPath.row];
    cell.textLabel.text = address.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中的物业地址缓存到本地,下一次读取还是这个地址
        [[NSUserDefaults standardUserDefaults] setObject:@""  forKey:@"propertyAddress"];
    [[NSUserDefaults standardUserDefaults] setObject:[self.addressDicArr objectAtIndex:indexPath.row] forKey:@"propertyAddress"];
    NSLog(@"========%@",[self.addressDicArr objectAtIndex:indexPath.row]);
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
