//
//  CMCAboutUsTVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAboutUsTVC.h"
#import "CMCAboutUSTableViewCell.h"

@interface CMCAboutUsTVC ()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UILabel *_aboutUsLabel;
}
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *webtitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *web;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSMutableArray *dataArr;





@end

@implementation CMCAboutUsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataArr = [[NSMutableArray alloc] init];
//    self.tableView.userInteractionEnabled = NO;
//    UIView *topView = [[UIView alloc]
//                       initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
////    [self.view addSubview:topView];
//    self.tableView.tableHeaderView = topView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 30, 30, 60, 60)];
    imageView.layer.cornerRadius = 20;
    imageView.image = [UIImage imageNamed:@"login_photo"];
    [self.view addSubview:imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height + imageView.frame.origin.y, self.view.bounds.size.width, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:12.0];
    _titleLabel.text = @"十全客";
    [self.view addSubview:_titleLabel];
    
    _aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, self.view.bounds.size.width, 20)];
    _aboutUsLabel.textAlignment = NSTextAlignmentCenter;
    _aboutUsLabel.numberOfLines = 0;
    _aboutUsLabel.font = [UIFont systemFontOfSize:12.0];

    _aboutUsLabel.text = [NSString stringWithFormat:@"当前版本号:%@",APPVersion];
    [self.view addSubview:_aboutUsLabel];
    
    
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,_aboutUsLabel.bottom + 10, self.view.bounds.size.width, 100)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = @"  十全客将打通O2O行业上游的配送环节,中游的商家管理及用户管理环节,下游的社区物流体系,实现交易、服务的双重闭环模式,最终实现一个平台解决用户的所有生活服务需求的目标.";
    _contentLabel.textColor = [UIColor colorWithHexString:@"888888"];
    _contentLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:_contentLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.view.bounds.size.height - 130, 80, 44)];
    phoneLabel.text = @"客服电话:";
    phoneLabel.textColor = [UIColor colorWithHexString:@"676666"];
    [self.view addSubview:phoneLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(phoneLabel.frame.size.width+ 5, self.view.bounds.size.height - 130, 200, 44);
    [button setTitle:@"0512-66902021" forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button setTitleColor:kAPI_AllMainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
//    [self loadData];
}
- (void)didClickButton
{

//    [BaseUtil phoneWithNumber:@"114"];
    [self callPhone:@"0512-66902021"];

}
- (void)callPhone:(NSString *)phone
{
    
    UIAlertView *arlerView = [[UIAlertView alloc]initWithTitle:@"是否拨打商家电话？" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话： %@",phone],@"取消", nil];
    arlerView.delegate = self;
    [arlerView show];
    
    
}
#pragma mark - UIAlertViewDelegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //        NSString *number = [alertView buttonTitleAtIndex:0];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://114"]]];
        
    }
    
}
//- (void)loadData
//{
//
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [BaseUtil get:kAPI_aboutUs success:^(AFHTTPRequestOperation *operation, id jsonObject) {
//        NSLog(@"关于我们  %@",kAPI_aboutUs);
//        if ([[jsonObject objectForKey:@"status"] intValue] == 1) {
//            NSDictionary *infoDic = [jsonObject objectForKey:@"info"];
//    
//                self.title = [infoDic objectForKey:@"title"];
//                self.webtitle = [infoDic objectForKey:@"webtitle"];
//                self.content = [infoDic objectForKey:@"content"];
//                self.web = [infoDic objectForKey:@"web"];
//                self.phone = [infoDic objectForKey:@"phone"];
//                self.qq = [infoDic objectForKey:@"qq"];
//                [self.dataArr addObject:self.webtitle];
//                [self.dataArr addObject:self.phone];
//                [self.dataArr addObject:self.qq];
//
//  
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self.tableView reloadData];
////            NSLog(@"%@",self.title);
//            
////            [NSString stringWithFormat:@"%@/\%@",self.title,self.webtitle];
//            _titleLabel.text = [self.title stringByAppendingFormat:@"\n%@",self.webtitle];
//            _contentLabel.text = self.content;
//          
//            
//        } else {
//            
//            [BaseUtil toast:@"暂无数据"];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//        }
//        
//    } faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//        
//    }];
//
//
//
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return self.dataArr.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 150;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *str = @"reused";
//    CMCAboutUSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
//    if (cell == nil) {
//        cell = [[CMCAboutUSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    // Configure the cell...
//    if (self.webtitle == nil) {
//        self.webtitle = @"";
//    }
//    if (self.phone == nil) {
//        self.phone = @"";
//    }
//    if (self.qq == nil) {
//        self.qq = @"";
//    }
//    if (indexPath.row == 0) {
//        [cell creatLabel:@"网站:" dataLabel:self.webtitle];
//
//    }
//    
//    if (indexPath.row == 1) {
//        [cell creatLabel:@"客服电话:" dataLabel:self.phone];
//
//    }
//    
//    if (indexPath.row == 2) {
//        [cell creatLabel:@"企业QQ:" dataLabel:self.qq];
//    }
//    
//    return cell;
//}



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
