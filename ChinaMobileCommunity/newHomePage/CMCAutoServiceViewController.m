//
//  CMCAutoServiceViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCAutoServiceViewController.h"
#import "CMCMovieWebViewController.h"
#import "CMCFood.h"
#import "CMCConvenientLifeListTVCell.h"
#import "CMCConvenientLifeDetailVC.h"

@interface CMCAutoServiceViewController ()
{
     NSInteger _page;
}
@property (nonatomic, strong) NSMutableArray *foodArr;
@end

@implementation CMCAutoServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _page = 0;
    [self createHeaderView];
    [self showRefreshHeader:YES];
    self.foodArr = [[NSMutableArray alloc] init];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [BaseUtil setExtraCellLineHidden:tableView];
    [self.view addSubview:tableView];
    [self loadDataType];
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
    
    [self loadDataType];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.foodArr.count) {
        return self.foodArr.count+1;
    }
    return 1;
}

- (void)loadDataType
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *timeStamp = kAPI_timestamp;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":[NSString stringWithFormat:@"%@",APPVersion],@"zid":[CMCUserManager shareManager].zid,@"trade_id":self.merchant_type,@"page":pageStr,@"nums":@"8",@"timestamp":timeStamp};
    
    NSString *sig = KAPI_GetSig(dic);
    NSString *urlStr = KAPI_MerchantList([CMCUserManager shareManager].zid, self.merchant_type,pageStr, @"8", sig);
     NSLog(@"urlStr ==== %@",urlStr);
    if (_page == 0) {
        [self.foodArr removeAllObjects];
    }
    
    [BaseUtil get:urlStr success:^(id respondObject) {
        NSLog(@"resoponobje = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                
                for (NSDictionary *tempDic in dataArr) {
                    
                    CMCFood *merchantList = [[CMCFood alloc] initWithFood:tempDic];
                    [self.foodArr addObject:merchantList];
                }
                [self.tableView reloadData];
                [self finishReloadingData];
                [self setFooterView];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } else {
                [BaseUtil toast:@"没有更多的数据了"];
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self removeHeaderView];
                
            }
        } else {
            
            [BaseUtil toast:@"加载数据失败"];
            return;
        }
    } failure:^(NSError *error) {
        
    }];
    
    
   
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    CMCConvenientLifeListTVCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCConvenientLifeListTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (indexPath.row == 0) {
                UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 106, 73)];
        photoImageView.image = [UIImage imageNamed:@"kuantuqiche"];
                [cell addSubview:photoImageView];
                //超市名称
                UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, 14, 100, 25)];
                //    shopNameLabel.backgroundColor = [UIColor grayColor];
                shopNameLabel.text = @"宽途汽车";
                shopNameLabel.font = [UIFont systemFontOfSize:14];
                shopNameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
                [cell addSubview:shopNameLabel];
                UIImageView *preferentialImagView = [[UIImageView alloc] initWithFrame:CGRectMake(shopNameLabel.frame.size.width + shopNameLabel.frame.origin.x + 5, 14, 25, 25)];
                preferentialImagView.contentMode = UIViewContentModeScaleAspectFit;
                //    preferentialImagView.image = [UIImage imageNamed:@"preferential"];
                [cell addSubview:preferentialImagView];
                //时间
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, shopNameLabel.frame.size.height + shopNameLabel.frame.origin.y, 200, 24)];
                timeLabel.font = [UIFont systemFontOfSize:11];
                timeLabel.text = [NSString stringWithFormat:@"营业时间:18:00-22:20"];
                timeLabel.textColor = [UIColor colorWithHexString:@"606060"];
                [cell addSubview:timeLabel];
        
    } else if (self.foodArr.count) {
        CMCFood *merchantList = [self.foodArr objectAtIndex:indexPath.row - 1];
        [cell creatCell:merchantList];
    }
    
    
    return cell;
    
    //    }
    
    //    if ([self.title isEqualToString:@"汽车服务"]) {
    //        UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 106, 73)];
    //        NSString *str1 = @"http://img5.gewara.com/cw150h200/images/movie/201412/s3b73bbf_14a3d8473e5__7cd1.jpg";
    //        NSURL *url = [NSURL URLWithString:str1];
    //
    //        [photoImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    //        [cell addSubview:photoImageView];
    //        //超市名称
    //        UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, 14, 100, 25)];
    //        //    shopNameLabel.backgroundColor = [UIColor grayColor];
    //        shopNameLabel.text = @"宽途汽车";
    //        shopNameLabel.font = [UIFont systemFontOfSize:14];
    //        shopNameLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    //        [cell addSubview:shopNameLabel];
    //        UIImageView *preferentialImagView = [[UIImageView alloc] initWithFrame:CGRectMake(shopNameLabel.frame.size.width + shopNameLabel.frame.origin.x + 5, 14, 25, 25)];
    //        preferentialImagView.contentMode = UIViewContentModeScaleAspectFit;
    //        //    preferentialImagView.image = [UIImage imageNamed:@"preferential"];
    //        [cell addSubview:preferentialImagView];
    //        //时间
    //        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5, shopNameLabel.frame.size.height + shopNameLabel.frame.origin.y, 200, 24)];
    //        timeLabel.font = [UIFont systemFontOfSize:11];
    //        timeLabel.text = [NSString stringWithFormat:@"营业时间:18:00-22:20"];
    //        timeLabel.textColor = [UIColor colorWithHexString:@"606060"];
    //        //    timeLabel.backgroundColor = [UIColor redColor];
    //        [cell addSubview:timeLabel];
    //    }
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        return 100;
    //    }
    //    if (self.foodArr.count) {
    //        return 100;
    //    }
    return 100;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CMCMovieWebViewController *movieWebVC = [[CMCMovieWebViewController alloc] init];
        movieWebVC.hidesBottomBarWhenPushed = YES;
        movieWebVC.title = @"宽途汽车";
        [self.navigationController pushViewController:movieWebVC animated:YES];
    }
    else {
    
        CMCConvenientLifeDetailVC *detailVC = [[CMCConvenientLifeDetailVC alloc] init];
        CMCFood *food = [self.foodArr objectAtIndex:indexPath.row - 1];
        detailVC.mid = food.mid;
        detailVC.title = self.title;
        [self.navigationController pushViewController:detailVC animated:YES];
    
    }
    
    
    
    
    
}
- (void)creatCell
{
    
    
    
    
    //    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(preferentialImagView.frame.size.width + preferentialImagView.frame.origin.x + 5, 14, 60, 25)];
    //    distanceLabel.textAlignment = NSTextAlignmentRight;
    //    float n =  [BaseUtil distanceBetweenOrderBy:[CMCUserManager shareManager].latitude:[food.latitude floatValue] :[CMCUserManager shareManager].longitude :[food.longitude floatValue]];
    //    distanceLabel.text = [NSString stringWithFormat:@"%.0fm",n];
    //    distanceLabel.font = [UIFont systemFontOfSize:12.0];
    //    [self.contentView addSubview:distanceLabel];
    
    
    
    
    //    //地图
    //    UILabel *mapLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.size.width + photoImageView.frame.origin.x + 5 , timeLabel.frame.size.height + timeLabel.frame.origin.y, self.frame.size.width - 117, 24)];
    //    mapLabel.textColor = [UIColor colorWithHexString:@"606060"];
    //    mapLabel.font = [UIFont systemFontOfSize:11];
    //    mapLabel.text = food.merchant_addr;
    //    //    mapLabel.backgroundColor = [UIColor orangeColor];
    //    [self.contentView addSubview:mapLabel];
    
    
    
    
    
    
}
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
