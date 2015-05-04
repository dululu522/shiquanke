//
//  CMCVillageNoticeDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCVillageNoticeDetailVC.h"

@interface CMCVillageNoticeDetailVC ()
{
    UIScrollView *_backView;
}
@property (nonatomic, strong) NSString *newscontent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *newstitle;
@property (nonatomic, strong) NSString *requesttime;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLable;
@property (nonatomic, strong) UILabel *signlabel ;
@property (nonatomic, strong) UILabel *timelabel ;



@end

@implementation CMCVillageNoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    self.title = @"通知详情";
    _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width - 10, self.view.bounds.size.height - 20)];
    _backView.contentSize = CGSizeMake( self.view.bounds.size.width - 10, 800);
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _backView.frame.size.width, 30)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:_nameLabel];
    
    _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, self.view.frame.size.width, 50)];
    [_contentLable setNumberOfLines:0];
    _contentLable.font = [UIFont fontWithName:nil size:14.0];

    [_backView addSubview:_contentLable];
    [self loadData];
    




    
}
- (void)loadData
{
    NSString *timestamp= kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"notice_id":self.notice_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *requestUrl = kAPI_setNewsStatus([CMCUserManager shareManager].token, self.notice_id, timestamp,sig);
    NSLog(@"requestUrl    ========%@",requestUrl);
    [BaseUtil get:requestUrl success:^(id respondObject) {
        
        NSLog(@"小区respondObject ==========%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([[respondObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                
                            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                            self.newscontent = [dataDic objectForKey:@"content"];
//                            self.name = [dataDic objectForKey:@"name"];
                           self.nameLabel.text = [dataDic objectForKey:@"name"];
                            self.requesttime = [BaseUtil becomeNormalWithString:[dataDic objectForKey:@"create_time"]];
                            self.newstitle = [dataDic objectForKey:@"title"];
                        UIFont *font = [UIFont fontWithName:nil size:14.0];
                        CGSize size = CGSizeMake(_backView.frame.size.width, 20000);
                        //    boundingRectWithSize:options:attributes:context:
                        CGSize labelSize = [self.newscontent sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
                        [_contentLable setFrame:CGRectMake(0, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, self.view.frame.size.width, labelSize.height)];
                        NSLog(@"_contentLable  %@",_contentLable);
                        self.contentLable.text = [NSString stringWithFormat:@" %@",self.newscontent];
                //
                        self.signlabel = [[UILabel alloc] initWithFrame:CGRectMake(_backView.frame.size.width-100, _contentLable.frame.size.height+_contentLable.frame.origin.y, 100, 20)];
                        self.signlabel.textAlignment = NSTextAlignmentCenter;
                        [_backView addSubview:self.signlabel];
                        self.timelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.signlabel.frame.size.height+ self.signlabel.frame.origin.y+5, self.view.frame.size.width- 20, 20)];
                        self.timelabel.textAlignment = NSTextAlignmentRight;
                self.timelabel.font = [UIFont systemFontOfSize:14.0];
                //        [_backView addSubview:self.timelabel];
                        self.signlabel.text = self.name;
                self.signlabel.font = [UIFont systemFontOfSize:14.0];
                        self.timelabel.text = self.requesttime;
                [_backView addSubview:self.timelabel];
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            } else {
                [BaseUtil toast:@"暂无数据"];
                [MBProgressHUD hideHUDForView:self.view  animated:YES];

            }
        } else if ([[infoDic objectForKey:@"result"] intValue] == 3){
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            loginVC.hidesBottomBarWhenPushed = YES;
        
        } else {
        
            [BaseUtil toast:@"服务端数据错误"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
    } failure:^(NSError *error) {
        
    }];

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
