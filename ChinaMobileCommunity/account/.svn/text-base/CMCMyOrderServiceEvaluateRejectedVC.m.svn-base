//
//  CMCMyOrderServiceEvaluateRejectedVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyOrderServiceEvaluateRejectedVC.h"
#import "CMCMyOrderEvaluateVC.h"
#import "CMCMyOrderDetailTableViewCell.h"
#import "CMCMyOrderEvaluateCell.h"
@interface CMCMyOrderServiceEvaluateRejectedVC ()
{
    UIView *_backView;
}
@property (nonatomic, strong) UITableView *finishedTabelView;
@end

@implementation CMCMyOrderServiceEvaluateRejectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_backView];
    [self creatTableView];
    
}


- (void)creatTableView
{
    self.finishedTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 64)];
    self.finishedTabelView.delegate = self;
    self.finishedTabelView.dataSource = self;
    self.finishedTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [BaseUtil setExtraCellLineHidden:self.finishedTabelView];
    [_backView addSubview:self.finishedTabelView];
    
    
}

- (void)didClickMakeSureBtn:(UIButton *)button
{
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
        if (section == 3) {
            return 1;
        }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *str = @"reused";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
//            [cell creatMyOrderDetailCellStatus:@"已拒单" type:@"服务项目"];
            [cell creatMyOrderDetailCellStatus:@"已拒单" type:@"服务项目" name:@"" time:@""];
            
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"拒单原因:春节员工回家,人员不够.";
            cell.textLabel.textColor = k_color(@"585858");
            cell.textLabel.font = k_font(14.0);
        }
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *str = @"re";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatName:@"服务时间:2015-01-27" phone:@"备注:我需要2个小时日常保洁"];
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *str = @"CMCMyOrderDetailTableViewCell";
        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell creatMyOrderDetailCopyLabelText:nil priceText:nil onlinePay:nil note:nil];
        [cell creatName:@"姓名:石头" phone:@"手机号:15509845678" address:@"地址:苹果园通景大厦702室"];
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *str = @"CMCMyOrderEvaluateCell";
        CMCMyOrderEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCMyOrderEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        [cell creatMyOrderEvaluateCell];
        return cell;
    }
    //    if (indexPath.section == 3) {
    //        static NSString *str = @"re";
    //        CMCMyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    //        if (cell == nil) {
    //            cell = [[CMCMyOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    //        }
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        [cell creatName:@"姓名:natural" phone:@"手机号:13263446196"];
    //        return cell;
    //    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 136;
            
        }
        return 44;
    }
    if (indexPath.section == 1) {
        return 60;
    }
        if (indexPath.section == 3) {
            return 50;
        }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 17;
    }
    if (section == 2) {
        return 17;
    }
    if (section == 3) {
        return 17;
    }
    return 0;
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
