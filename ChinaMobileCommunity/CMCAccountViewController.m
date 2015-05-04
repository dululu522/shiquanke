//
//  CMCAccountViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCAccountViewController.h"
#import "CMCLoginViewController.h"
#import "CMCRegisterViewController.h"

#import "CMCPersonInformationTableVC.h"
#import "CMCOrderTableVC.h"
#import "CMCReserveTableVC.h"
#import "CMCQuanViewController.h"
#import "CMCMyShoppingCartVC.h"
#import "CMCAccountTableViewCell.h"
#import "CMCPersonalInformation.h"
#import "CMCMyActivityVC.h"
#import "CMCPacketVC.h"
#import "MAddressViewController.h"

#import "CMCSetTableVC.h"
#import "CMCAboutUsTVC.h"
#import "UMSocial.h"//0319

@interface CMCAccountViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate>
{

    UILabel *_loginAccountLabel;
    NSString *_personaltextStr;
    NSString *_nicknameStr;
    UILabel *_mottoLabel;
    NetWorkRequest *_request;
    UIView *_backView;
    UIView *_topView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *sectionOneArr;
@property (nonatomic, strong) NSArray *sectionTwoArr;
@property (nonatomic, strong) NSArray *sectionThreeArr;

@property (nonatomic, strong) UIImageView *photoImageView;





@end

@implementation CMCAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"我的";
//        self.navigationController.navigationBar.translucent = NO;
        self.view.backgroundColor = k_color(@"F5F4F4");
        self.tabBarItem.image = [UIImage imageNamed:@"my"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"my_select"];

        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([CMCUserManager shareManager].token) {
        [self loadData];
        [self loadPictureData];

    } else {
//        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
//        loginVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVC animated:YES];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //topView也是tableview的headview
//    self.view.backgroundColor = [UIColor whiteColor];
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_backView];
//    _backView.backgroundColor = [UIColor whiteColor];
    

    
    [self creatTopMyInfomation];
    

    
    
    [self loadPictureData];
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 108) ];
//    self.tableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = _topView;
    self.tableView.separatorColor = [UIColor whiteColor];
    
    self.sectionOneArr = @[@"我的订单",@"我的券包"];
    self.sectionTwoArr = @[@"我的红包",@"我的活动",@"收货地址",@"关于我们"];
    
    self.sectionThreeArr = @[@"下载分享",@"清空缓存",@"我的设置"];
    
    
    
}
//tableview headView的信息
- (void)creatTopMyInfomation
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 115)];

    _topView.backgroundColor = [UIColor whiteColor];
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 60, 60)];
    _photoImageView.backgroundColor = [UIColor grayColor];
    _photoImageView.userInteractionEnabled = YES;
//    _photoImageView.image = [UIImage imageNamed:@"log"];
    _photoImageView.clipsToBounds = YES;
    _photoImageView.layer.cornerRadius = 30;
    [_topView addSubview:_photoImageView];


        //账户名称
        _loginAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 200, 25)];
        _loginAccountLabel.font = [UIFont fontWithName:nil size:14.0];
//        [backImageView addSubview:_loginAccountLabel];
        _loginAccountLabel.text = [NSString stringWithFormat:@"%@",k_phone];
        [_topView addSubview:_loginAccountLabel];
    
        //昵称 姓名 个性签名
        _mottoLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, _loginAccountLabel.frame.size.height + _loginAccountLabel.frame.origin.y + 5, 200, 25)];
//        _mottoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",]
        _mottoLabel.font = [UIFont fontWithName:nil size:14.0];
    
        [_topView addSubview:_mottoLabel];


}
- (void)loadData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic= @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestUrl = KAPI_getuserinfo(timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        NSLog(@"我的设置respondObject ==========%@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];

        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            

            NSString *gender;
            if ([[dataDic objectForKey:@"gender"] isEqualToString:@"S"]) {
                gender = @"保密";
                
            } else if ([[dataDic objectForKey:@"gender"] isEqualToString:@"F"]){
                            gender = @"女";
            } else{
               gender = @"男";
            
            }
            
            
            NSString *nickname;
            if (![[dataDic objectForKey:@"nickname"] isKindOfClass:[NSNull class]]) {
                nickname = [dataDic objectForKey:@"nickname"];
            } else {
            
            nickname = @"";
            }
            NSString *intro;
            if (![[dataDic objectForKey:@"intro"] isKindOfClass:[NSNull class]]) {
                intro = [dataDic objectForKey:@"intro"];
            } else {
            
            intro = @"";
            }
            _mottoLabel.text = [NSString stringWithFormat:@"%@  %@  %@",nickname,gender,intro];
            
        } else if([[infoDic objectForKey:@"result"] intValue] == 3) {
        
            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            loginVC.hidesBottomBarWhenPushed = YES;
        
        }else{
            
            [BaseUtil toast:@"数据加载失败,请重新加载"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } failure:^(NSError *error) {
        
    }];
   
    
    

}
//加载图片的链接
- (void)loadPictureData
{
    //用户id的前两位
    if ([CMCUserManager shareManager].token) {
        NSString *user = [BaseUtil md5:[CMCUserManager shareManager].uid];
        NSString *urlStr = [NSString stringWithFormat:@"%@1/%@/%@_1.jpg",[CMCUserManager shareManager].file_url,[user substringWithRange:NSMakeRange(0, 2)],[user lowercaseString]];
        
        NSURL *url = [NSURL URLWithString:urlStr];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
        self.photoImageView.image = image;
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [BaseUtil toast:@"你还没有登录哦"];
    }
}



//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{


}


#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sectionOneArr.count;
    }
    if (section == 1) {
        return self.sectionTwoArr.count;
    }
    if (section == 2) {
        return self.sectionThreeArr.count;
    }

    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *str = @"reUsed";
    CMCAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CMCAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }

    if (indexPath.section == 0) {
        [cell creatCellImage:[self.sectionOneArr objectAtIndex:indexPath.row] title:[self.sectionOneArr objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 1) {

        [cell creatCellImage:[self.sectionTwoArr objectAtIndex:indexPath.row] title:[self.sectionTwoArr objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 2) {
        
        [cell creatCellImage:[self.sectionThreeArr objectAtIndex:indexPath.row] title:[self.sectionThreeArr objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//    cell.backgroundColor = [UIColor whiteColor];
    return cell;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 0;
//    }
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![CMCUserManager shareManager].token) {
        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }

   [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                CMCOrderTableVC *order = [[CMCOrderTableVC alloc] init];
                order.title = @"我的订单";
                order.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:order animated:YES];
            }
            if (indexPath.row == 1) {
                //我的券包
                CMCQuanViewController *quanVC = [[CMCQuanViewController alloc] init];
                quanVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:quanVC animated:YES];
            }

         }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                    //我的红包
                    
                    CMCPacketVC *packVC = [[CMCPacketVC alloc] init];
                    packVC.hidesBottomBarWhenPushed = YES;

                    [self.navigationController pushViewController:packVC animated:YES];

                }
                    break;
                case 1:
                {
                    //我的活动
                    CMCMyActivityVC *myActivityVC = [[CMCMyActivityVC alloc] init];
                    myActivityVC.title = @"我的活动";
                    myActivityVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:myActivityVC animated:YES];
                }
                    break;
                case 2:
                {
                    //收货地址
                    MAddressViewController* u = [[MAddressViewController alloc]init];
//                    u.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:u animated:YES];
                }
                    break;
                case 3:
                    
                {
                    //关于我们
                    
                    CMCAboutUsTVC *aboutUsVC = [[CMCAboutUsTVC alloc] init];
                    aboutUsVC.hidesBottomBarWhenPushed = YES;
                    aboutUsVC.title = @"关于我们";
                    [self.navigationController pushViewController:aboutUsVC animated:YES];

                
                }
                    
                default:
                    break;
            }
        }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            [self didClickShareButton];//0319
            NSLog(@"下载分享");
            
        }
        if (indexPath.row == 1) {
            NSLog(@"清除缓存");
            [self clearDemo];
        }
        if (indexPath.row == 2) {
            //我的设置
//            CMCSetTableVC *setTabeleVC = [[CMCSetTableVC alloc] init];
//            setTabeleVC.title = @"我的设置";
//            setTabeleVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:setTabeleVC animated:YES];
                if ([CMCUserManager shareManager].token) {
                    //我的设置
                    CMCPersonInformationTableVC *perInformationVC = [[CMCPersonInformationTableVC alloc] init];
//                    perInformationVC.hidesBottomBarWhenPushed = YES; 
                    [self.navigationController pushViewController:perInformationVC animated:YES];
                    
                }
            
        }

        
    }
}
- (void)clearDemo
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%ld",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
    
    
    
}
-(void)clearCacheSuccess
{
    [BaseUtil toast:@"清理成功"];
    NSLog(@"清理成功");
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    sectionView.backgroundColor = k_color(@"F5F4F4");
    return sectionView;


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 10;
//    }
//    if (section == 1) {
//            return 10;
//    }

    return 10;

}


- (void)didClickShareButton
{
    //0319
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"54b79007fd98c58b73000ebd"
                                      shareText:[NSString stringWithFormat:@"http://www.cnsqk.com/wap/"]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
                                       delegate:self];
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
