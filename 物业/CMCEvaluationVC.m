//
//  CMCEvaluationVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCEvaluationVC.h"
#import "CMCEvaluationTableViewCell.h"
#import "StarView.h"
#import "ReslutView.h"

@interface CMCEvaluationVC ()

@end

@implementation CMCEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 20)];
    self.title = @"服务评价";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, self.view.bounds.size.width,49)];
//    view.backgroundColor = [UIColor grayColor];
    [self.navigationController.view addSubview:view];
    
    UIButton *submitButton= [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 80, 5, 160, 40)];
    [submitButton addTarget:self action:@selector(didClickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [view addSubview:submitButton];
    
    
    
    
}
//提交
- (void)didClickSubmitButton:(UIButton *)button
{





}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 200;
    } else{
        return 70;

    
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *str = @"reused";
    CMCEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCEvaluationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell creatLabelText:@"1.你对物业服务的整体感觉是否满意?" number:5];

    }
    if (indexPath.row == 1) {
        [cell creatLabelText:@"2.你对小区的公共维修服务是否满意?" number:5];

    }
    if (indexPath.row == 2) {
        [cell creatLabelText:@"3.你对小区的公共环境是否满意?" number:5];
        
    }
    if (indexPath.row == 3) {
        [cell creatLabelText:@"4.你对小区的保安服务是否满意?" number:5];
        
    }
    if (indexPath.row == 4) {
        [cell creatLabelText:@"5.你对小区的公共设施是否满意?" number:5];
        
    }

    if(indexPath.row == 5){
    
        [cell creatLabel];
    
    }     return cell;

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
