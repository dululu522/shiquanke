//
//  CMCMyActivityDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyActivityDetailVC.h"
#import "CycleScrollView.h"
#import "CMCActivitiesDetailTableViewCell.h"
#import "CMCTalkKidsViewController.h"
#import "CMCActivityDetail.h"
#import "CMCQScrollView.h"
#import "CMCNickNameVC.h"

#import "CMCMyActivityCommentVC.h"
@interface CMCMyActivityDetailVC ()
{
    UIButton *_signUpButton;//报名
    UITextView *_talkTextView;
    NetWorkRequest *_request;
    NetWorkRequest *_talkRequest;
    NSInteger _page;
    
}
@property (nonatomic ,strong) CMCQScrollView* focusScorllView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) UIView *headerview;
@property (nonatomic, strong) NSMutableArray *focusImageArray;
@property (nonatomic, strong) NSMutableArray *myActivityArr;

@property (nonatomic, strong) NSMutableArray *descriptionArr;//评价详情
@property (nonatomic, strong) NSMutableArray *user_nameArr;//用户名
@property (nonatomic, strong) NSMutableArray *rec_timeArr;//时间
//@property (nonatomic, strong) CMCQScrollView *scrollView;




@end

@implementation CMCMyActivityDetailVC
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.focusScorllView stopScorllView];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    self.title = @"活动详情";
    self.descriptionArr = [[NSMutableArray alloc] init];
    self.user_nameArr = [[NSMutableArray alloc] init];
    self.rec_timeArr = [[NSMutableArray alloc] init];
    
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    _talkRequest = [[NetWorkRequest alloc] init];
    _talkRequest.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.focusImageArray = [[NSMutableArray alloc] init];
    self.myActivityArr = [[NSMutableArray alloc] init];
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    self.focusScorllView = [[CMCQScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 115) ];
    self.headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)];
    self.headerview.backgroundColor = [UIColor clearColor];
    //    self.focusScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    self.tableView.tableHeaderView = self.headerview;
    [self.headerview addSubview:self.focusScorllView];
    [self loadData];
    //    [self loadMyTalkData];
    
}
- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    if ([CMCUserManager shareManager].token) {
        if ([CMCUserManager shareManager].token && self.id) {
            NSDictionary *dic= @{@"channel":KAPI_NewChannel,@"zid":@"1",@"id":self.id,@"timestamp":timestamp,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token};
            NSLog(@"%@",dic);
            NSString *sig = [BaseUtil getSigWithArray:dic];
            
            NSString *requestStr = kAPI_actiinfo(@"1", self.id, timestamp, [BaseUtil md5:sig],[CMCUserManager shareManager].token);
            NSLog(@"活动详情 %@",requestStr);
            [BaseUtil get:requestStr success:^(id respondObject) {
                NSLog(@"%@",respondObject);
                NSDictionary *infoDic = [respondObject objectForKey:@"info"];
                
                
                [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
                [BaseUtil errorMesssage:respondObject];
                
                if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                    if ([respondObject objectForKey:@"data"]) {
                        NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                        CMCActivityDetail *activityDetail = [[CMCActivityDetail alloc] initWithActivityDetail:dataDic];
                        [self.myActivityArr addObject:activityDetail];
                        //                    [self refreshFocusView];
                        //                    [self creatToSignUp:[dataDic objectForKey:@"state"]];
                        //给banner上得数组赋值
                        
                        if ([[dataDic objectForKey:@"images"] count]) {
                            for (NSString *imagesStr in [dataDic objectForKey:@"images"]) {
                                NSURL *url = [BaseUtil systemRandomlyGenerated:imagesStr type:@"32" number:@"1"];
                                if (url) {
                                    [self.focusImageArray addObject:url];
                                }
                            }
                        }
                        
                        self.focusScorllView.imageArr = [NSMutableArray arrayWithArray:self.focusImageArray];
                        [self.focusScorllView creatWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130) cout:self.focusScorllView.imageArr.count];
                        self.tableView.hidden = NO;
                        
                        [self.tableView reloadData];
                    }else {
                        [BaseUtil toast:@"暂无数据"];
                    }
                }else{
                    
                    [BaseUtil toast:@"服务端返回数据错误"];
                    
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            } failure:^(NSError *error) {
                
            }];
        }
        
    }
    
    //    [_request loadDataWithURLString:requestStr];
}

- (void)changePage:(UIPageControl *)pageControl
{
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        if (self.myActivityArr.count) {
            return 4;
        }
    }
    if (section == 2) {
        return self.rec_timeArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *str = @"CMCActivitiesDetailTableViewCell";
    CMCActivitiesDetailTableViewCell *cell = [[CMCActivitiesDetailTableViewCell alloc] init];
    //    if (cell == nil) {
    //        cell = [[CMCActivitiesDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    //    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (self.myActivityArr.count) {
            CMCActivityDetail *activityDetail = [self.myActivityArr objectAtIndex:0];
            
            if (indexPath.row == 0) {
                if (activityDetail.start_time.length && activityDetail.over_time.length) {
                    NSString *start_time = [BaseUtil becomeNormalWithString:activityDetail.start_time];
                    NSString *over_time = [BaseUtil becomeNormalWithString:activityDetail.over_time];
                    [cell creatTheNameOfEvent:@"activity_host" activeContent:[NSString stringWithFormat:@"活动时间:%@~%@",start_time,over_time]];
                }
                
            }
            if (indexPath.row == 1) {
                if (activityDetail.nums.length) {
                    [cell creatTheNameOfEvent:@"activity_number" activeContent:[NSString stringWithFormat:@"报名人数:%@",activityDetail.nums]];
                }else {
                    [cell creatTheNameOfEvent:@"activity_number" activeContent:[NSString stringWithFormat:@"报名人数:"]];
                    
                }
                
                
            }
            if (indexPath.row == 2) {
                if (activityDetail.address) {
                    [cell creatTheNameOfEvent:@"activity_site" activeContent:[NSString stringWithFormat:@"活动地点:%@",activityDetail.address]];
                } else {
                    [cell creatTheNameOfEvent:@"activity_site" activeContent:[NSString stringWithFormat:@"活动地点:"]];
                    
                }
                
                
            }
            if (indexPath.row == 3) {
                if (activityDetail.promoters.length) {
                    [cell creatTheNameOfEvent:@"activity_host" activeContent:[NSString stringWithFormat:@"活动举办方:%@",activityDetail.promoters]];
                } else {
                    [cell creatTheNameOfEvent:@"activity_host" activeContent:[NSString stringWithFormat:@"活动举办方:"]];
                }
                
            }
        }
    }
    
    if (indexPath.section == 1) {
        if (self.myActivityArr.count) {
            CMCActivityDetail *activityDetail = [self.myActivityArr objectAtIndex:0];
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 48)];
            if (activityDetail.description.length) {
                textView.text = [NSString stringWithFormat:@"  %@",activityDetail.description];
            }
            textView.textColor = [UIColor colorWithHexString:@"555555"];
            textView.font = [UIFont systemFontOfSize:10];
            [cell addSubview:textView];
            textView.userInteractionEnabled = NO;
            if (activityDetail.intro != nil) {
                textView.text = activityDetail.intro;

            }
            [cell addSubview:textView];
        }
        
        
    }
    if (indexPath.section == 2) {
        //            [cell creatMyActivityDetail];
        [cell creatMyActivityDetailNameText:[self.user_nameArr objectAtIndex:indexPath.row] timeText:[self.rec_timeArr objectAtIndex:indexPath.row] contentText:[self.descriptionArr objectAtIndex:indexPath.row]];
        
        
        
    }
    return cell;
}
+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont:textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    float fHeight = size.height + 16.0;
    
    return fHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 22;
        
    }
    if (indexPath.section == 1) {
        return 48;
    }
    if (indexPath.section == 2) {
        return 90;
    }
    return 0;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.text = @"活动名称:欢聚晚会";
//        titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
//        titleLabel.font = [UIFont systemFontOfSize:13.0];
//
//        return titleLabel.text;
//    }
//    if (section == 1) {
//        UILabel *titleLabel1 = [[UILabel alloc] init];
//        titleLabel1.text = @"活动介绍";
//        titleLabel1.textColor = [UIColor colorWithHexString:@"3f3f3f"];
//        titleLabel1.font = [UIFont systemFontOfSize:13.0];
//        return titleLabel1.text;
//    }
//
//    return nil;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.myActivityArr.count) {
        CMCActivityDetail *activityDetail = [self.myActivityArr objectAtIndex:0];
        
        
        if (section == 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
            titleLabel.text = [NSString stringWithFormat:@" 活动名称:%@",activityDetail.name];
            
            titleLabel.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
            titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];         titleLabel.font = [UIFont systemFontOfSize:13.0];
            
            return titleLabel;
        }
        if (section == 1) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
            titleLabel.text = @" 活动介绍";
            titleLabel.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
            titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
            titleLabel.font = [UIFont systemFontOfSize:13.0];
            
            return titleLabel;
        }
        if (section == 2) {
            //七嘴八舌
            UIView *talkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
            talkView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
            UIImage *image = [UIImage imageNamed:@"my_detailComment"];
            UIButton *commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            commentsBtn.frame = CGRectMake(self.view.frame.size.width - 40 -image.size.width  , 7, image.size.width, image.size.height);
            [commentsBtn setBackgroundImage:image forState:UIControlStateNormal];
            [talkView addSubview:commentsBtn];
            talkView.userInteractionEnabled = YES;
            commentsBtn.userInteractionEnabled = YES;
            [commentsBtn addTarget:self action:@selector(didClickCommentsBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, 10, 35, image.size.height)];
            label.text = @"评论";
            label.font = [UIFont systemFontOfSize:13.0];
            [talkView addSubview:label];
            
            [talkView addSubview:commentsBtn];
//
//            
            UIButton *btm = [UIButton buttonWithType:UIButtonTypeCustom];
            btm.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 50);
            [btm addTarget:self action:@selector(didClickCommentsBtn:) forControlEvents:UIControlEventTouchUpInside];
            [talkView addSubview:btm];
            
            
            return talkView;
        }
        
    }
    
    return nil;
}
- (void)didClickCommentsBtn:(UIButton *)button
{
    //    CMCMyActivityCommentVC *activityCommentVC = [[CMCMyActivityCommentVC alloc] init];
    //    activityCommentVC.hidesBottomBarWhenPushed = YES;
    //
    //    [self.navigationController pushViewController:activityCommentVC animated:YES];
    CMCActivityDetail *activityDetail = [self.myActivityArr objectAtIndex:0];
    //发表评论
    CMCNickNameVC *nameVC = [[CMCNickNameVC alloc] init];
    nameVC.category = self.title;
    nameVC.activity_id = activityDetail.id;
    nameVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nameVC animated:YES];
    
}
- (void)didClickImageButton
{
    CMCActivityDetail *activityDetailVC = [self.myActivityArr objectAtIndex:0];
    CMCTalkKidsViewController *talkKidsVC = [[CMCTalkKidsViewController alloc] init];
    talkKidsVC.idStr = activityDetailVC.id;
    talkKidsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:talkKidsVC animated:YES];
    
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (section == 2) {
    //        return 70;
    //    }
    return 35;
    
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