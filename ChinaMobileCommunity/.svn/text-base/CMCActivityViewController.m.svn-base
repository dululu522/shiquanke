//
//  CMCCMCActivityViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCActivityViewController.h"
#import "CMCActivityTableViewCell.h"
//#import "CMCMyScrollView.h"
//#import "CycleScrollView.h"
#import "CMCQScrollView.h"
#import "CMCCommunityActivitiesVC.h"
#import "CMCConvenientLifeListTVCell.h"
#import "CMCActivitiesDetailVC.h"
#import "CMCActivityNewlyOpened.h"
#import "CMCFood.h"
#import "CMCButtonViewController.h"
#import "CMCShopDetailViewController.h"
#import "CMCActivityLowest.h"
#import "CMCConvenientLifeListTVCell.h"
#import "CMCActivityNewlyOpenTVC.h"
#import "CMCConvenientLifeDetailVC.h"

@interface CMCActivityViewController ()
{

}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic ,strong) CMCQScrollView* focusScorllView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIView* backView;
//@property (nonatomic, strong) CMCMyScrollView *mainScorllView;
@property (nonatomic, strong) NSMutableArray *firstImageArr;


@property (nonatomic, strong) NSMutableArray* focusImageArray;//banner上的图片数组
@property (nonatomic, strong) NSMutableArray *activityArr;
@property (nonatomic, strong) NSMutableArray *newlyOpenedArr;
@property (nonatomic, strong) NSMutableArray *lowestPriceArr;

@property (nonatomic, strong) NSMutableDictionary *lowsDic;
@property (nonatomic, strong) NSMutableDictionary *newsDic;




@end

@implementation CMCActivityViewController
- (instancetype)init
{
   self = [super init];
    if (self) {
        self.title = @"活动";
                self.tabBarItem.image = [UIImage imageNamed:@"activity"];
                self.tabBarItem.selectedImage = [UIImage imageNamed:@"activity_select"];
    }

    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.focusScorllView stopScorllView];
    


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstImageArr = [[NSMutableArray alloc] init];
    self.focusImageArray = [[NSMutableArray alloc] init];
    self.activityArr = [[NSMutableArray alloc] init];
    self.lowsDic = [[NSMutableDictionary alloc] init];
    self.newsDic = [[NSMutableDictionary alloc] init];
    self.newlyOpenedArr = [[NSMutableArray alloc] init];
    self.lowestPriceArr = [[NSMutableArray alloc] init];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    self.backView.backgroundColor = [UIColor clearColor];
    
    
    self.focusScorllView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    //    self.focusScorllView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    //    _qScrollView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    //    //    self.myTableview.tableHeaderView = _qScrollView;
    //    [_backScrollView addSubview:_qScrollView];
    
    [self.backView addSubview:self.focusScorllView];
    
    if ([CMCUserManager shareManager].zbanner) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:[CMCUserManager shareManager].zbanner type:@"32" number:@"2"];
        UIImageView *bananaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
        [self.focusScorllView addSubview:bananaImageView];
        
        [bananaImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
        
    }

//    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.userInteractionEnabled = NO;
//    _pageControl.backgroundColor = [UIColor clearColor];
//    _pageControl.frame = CGRectMake(0, 155, self.view.frame.size.width, 25);//0, 0, 320, 25
//    _pageControl.currentPage = 0;
//    [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
//    [self.backView addSubview:_pageControl];
    
    [self creatTabelView];
    self.tableView.tableHeaderView = self.focusScorllView;
    
    self.sectionArr = [[NSArray alloc] initWithObjects:@"小区活动",@"本周新开张",@"本周最低", nil];
    //    [self refreshFocusView];
    [self loadData];
    //    [self loadNewlyOpenedData];
    //    [self loadLowestPriceData];


}

- (void)creatTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [BaseUtil setExtraCellLineHidden:self.tableView];


}
- (void)loadData
{
    NSString *timestamp = kAPI_timestamp;
    [self.lowestPriceArr removeAllObjects];
    [self.newlyOpenedArr removeAllObjects];
    [self.activityArr removeAllObjects];
    if ([CMCUserManager shareManager].token && k_city_id) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":k_zid,@"timestamp":timestamp,@"city_id":k_city_id};
        NSLog(@"dic %@",dic);
        NSString *sig= [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = kAPI_actindex([CMCUserManager shareManager].token,k_zid, timestamp,[BaseUtil md5:sig],k_city_id);
        NSLog(@"requestUrl %@",requestUrl);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"zone %@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                    //小区活动
                    if ([[dataDic objectForKey:@"acts"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *actsDic = [dataDic objectForKey:@"acts"];
                        CMCActivity *activity = [[CMCActivity alloc] initWithActivityDic:actsDic];
                        [self.activityArr addObject:activity];
                        
                    }
                    //最低
                    if ([[dataDic objectForKey:@"lows"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *lowsDic = [dataDic objectForKey:@"lows"];
                        CMCActivityLowest *lowest = [[CMCActivityLowest alloc] initWithActivityLowestDic:lowsDic];
                        [self.lowestPriceArr addObject:lowest];
                        
                    }
                    //banner图上的数据
                    if ([[dataDic objectForKey:@"images"] isKindOfClass:[NSArray class]]) {
                        NSArray *imagesArr = [dataDic objectForKey:@"images"];
                        if (imagesArr.count) {
//                            [self.focusImageArray addObjectsFromArray:imagesArr];
                            for (NSString *imageStr in imagesArr) {
                                NSURL *url = [BaseUtil systemRandomlyGenerated:imageStr type:@"31" number:@"1"];
                                [self.focusImageArray addObject:url];
                            }
                        }
                        //给banner上得数组赋值
                        self.focusScorllView.imageArr = [NSMutableArray arrayWithArray:self.focusImageArray];
//                        _qScrollView.imageArr = [NSMutableArray arrayWithArray:innerBannerArr];
                        [self.focusScorllView creatWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130) cout:self.focusScorllView.imageArr.count];
                    }
                    //最新
                    
                    if ([[dataDic objectForKey:@"news"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *newsDic = [dataDic objectForKey:@"news"];
                        CMCActivityNewlyOpened *activityNewlyOpened = [[CMCActivityNewlyOpened alloc] initWithActivityNewlyOpened:newsDic];
                        [self.newlyOpenedArr addObject:activityNewlyOpened];
                        
                    }
                    [self.tableView reloadData];
                    
                }
            }
        } failure:^(NSError *error) {
            
        }];

    }else {
        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    
    
    }

    
    
}
- (void)changePage:(UIPageControl *)pageControl
{



}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.sectionArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.activityArr.count) {
            return 1;
        }
        
    }
    if (section == 1) {
        if (self.newlyOpenedArr.count) {
            return 1;
        }
    }
    if (section == 2) {
        if (self.lowestPriceArr.count) {
            return 1;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        static NSString *str = @"CMCActivityTableViewCell";
        CMCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sectionName = @"小区活动";
        if (self.activityArr.count) {
            CMCActivity *activity = [self.activityArr objectAtIndex:0];
            [cell creatCommunityActivitiesCell:activity];
            
        }
       
        return cell;
    }
    if (indexPath.section ==1) {
        static NSString *str = @"CMCActivityTableViewCell2";
        CMCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sectionName = @"本周新开张";
        if (self.newlyOpenedArr.count) {
            CMCActivityNewlyOpened *newlyOpened = [self.newlyOpenedArr objectAtIndex:0];
            //        [cell creatThisWeekOpenedCell:nil];
            [cell creatNewlyopenedCell:newlyOpened];
        }

        return cell;
    }

    if (indexPath.section == 2) {
//        [cell creatThisWeekTheLowestCell];
        static NSString *reused = @"CMCConvenientLifeListTVCell";
        CMCConvenientLifeListTVCell *cell = [tableView dequeueReusableCellWithIdentifier:reused];
        if (cell == nil) {
            cell = [[CMCConvenientLifeListTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reused];
        }
        CMCActivityLowest *lowest = [self.lowestPriceArr objectAtIndex:0];
//        [cell creatNewlyopenedCell:lowest];
        [cell creatActivityLowest:lowest];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

//    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (self.activityArr.count) {
            return 94;
        }
        
    }
    if (indexPath.section == 1) {
        if (self.newlyOpenedArr.count) {
            return 94;
        }
    }
    if (indexPath.section == 2) {
        if (self.lowestPriceArr.count) {
            return 94;
        }
    }
    return 0;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [self.sectionArr objectAtIndex:section];

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
            sectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
            
            UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 150, 15)];
            leftLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
            leftLabel.font = [UIFont systemFontOfSize:15.0];
            leftLabel.text = [self.sectionArr objectAtIndex:section];
            [sectionView addSubview:leftLabel];
            
            UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            moreButton.frame = CGRectMake(self.view.frame.size.width - 70, 16,60, 12);
            [sectionView addSubview:moreButton];
            moreButton.tag = 2000+section;
    if (section == 0) {
        if (self.activityArr.count) {
            [moreButton setTitle:@"更多" forState:UIControlStateNormal];
            [moreButton addTarget:self action:@selector(didClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
            [moreButton setTitleColor:[UIColor colorWithHexString:@"595959"] forState:UIControlStateNormal];
            [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            moreButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [moreButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
            [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
            moreButton.userInteractionEnabled = YES;
            return sectionView;
            
        }
    }
    if (section == 1) {
        if (self.newlyOpenedArr.count) {
            [moreButton setTitle:@"更多" forState:UIControlStateNormal];
            [moreButton addTarget:self action:@selector(didClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
            [moreButton setTitleColor:[UIColor colorWithHexString:@"595959"] forState:UIControlStateNormal];
            [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            moreButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [moreButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
            [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
            moreButton.userInteractionEnabled = YES;
            return sectionView;
        }
    }
    if (section == 2) {
        if (self.lowestPriceArr.count) {
            return sectionView;
        }
    }

    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.activityArr.count) {
            return 35;
        }
        
    }
    if (section == 1) {
        if (self.newlyOpenedArr.count) {
            return 35;
        }
    }
    if (section == 2) {
        if (self.lowestPriceArr.count) {
            return 35;
        }
    }
    return 0;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CMCActivity *activity = [self.activityArr objectAtIndex:indexPath.row];
        CMCActivitiesDetailVC *activityVC = [[CMCActivitiesDetailVC alloc] init];
        activityVC.title = @"活动详情";
        activityVC.hidesBottomBarWhenPushed = YES;
        activityVC.id = activity.id;
        [self.navigationController pushViewController:activityVC animated:YES];

    }
    if (indexPath.section == 1) {
        CMCActivityNewlyOpened *activityNewlyOpened = [self.newlyOpenedArr objectAtIndex:0];
        CMCConvenientLifeDetailVC *detailVC = [[CMCConvenientLifeDetailVC alloc] init];
//        CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
        detailVC.mid = activityNewlyOpened.mid;
//        detailVC.title = food.name;
//        detailVC.category = self.merchant_name;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
    if (indexPath.section == 2) {
        CMCActivityLowest *lowest = [self.lowestPriceArr  objectAtIndex:0];
        CMCShopDetailViewController *shopDetailVC = [[CMCShopDetailViewController alloc] init];
        shopDetailVC.hidesBottomBarWhenPushed = YES;
//        shopDetailVC.merchant_id = activ'ityNewlyOpened.activities_id;
        CMCConvenientLifeDetailVC *detailVC = [[CMCConvenientLifeDetailVC alloc] init];
        //        CMCFood *food = [self.foodArr objectAtIndex:indexPath.row];
        detailVC.mid = lowest.mid;
        //        detailVC.title = food.name;
        //        detailVC.category = self.merchant_name;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }



}
- (void)didClickMoreButton:(UIButton *)button
{
    NSLog(@"button.tag %ld",button.tag);
//    if ((button.tag == 2001) | (button.tag = 2002)) {
//        if (self.activityArr.count) {

        if (button.tag == 2000) {
        CMCCommunityActivitiesVC *communityActivitiesVC = [[CMCCommunityActivitiesVC alloc] init];
            communityActivitiesVC.title = @"小区活动";
            communityActivitiesVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:communityActivitiesVC animated:YES];
        }
        if (button.tag == 2001) {
        CMCActivityNewlyOpenTVC *communityActivitiesVC = [[CMCActivityNewlyOpenTVC alloc] init];
            communityActivitiesVC.title = @"本周新开张";
            communityActivitiesVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:communityActivitiesVC animated:YES];
        }

//        }

        
//    }


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
