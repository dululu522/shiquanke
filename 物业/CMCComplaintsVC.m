//
//  CMCComplaintsVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCComplaintsVC.h"
#import "CMCResidentialAddressTVC.h"
#import "CMCRepairComplaintsView.h"
#import "CMCCommunityTypeTableVC.h"

@interface CMCComplaintsVC ()<UITextViewDelegate>
{
    UITextField *_mapLabelTextField;
    UILabel *_label;
    UITextView *_contentView;
    UILabel *_contentLabel;
    
}
@end

@implementation CMCComplaintsVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatRepairComplaintView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [self creatNavigationBackButton];
}
- (void)creatRepairComplaintView
{
    CMCRepairComplaintsView *repairComplaintView = [[CMCRepairComplaintsView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:repairComplaintView];
    repairComplaintView.type = @"0";
    repairComplaintView.delegate = self;
    [repairComplaintView creatViewMap:[CMCUserManager shareManager].address communityText:[CMCUserManager shareManager].residentialAddressStr typeText:[CMCUserManager shareManager].communityType];
    
}
//小区名称
- (void)didClickCommunity
{
    CMCResidentialAddressTVC *residentialAddressVC = [[CMCResidentialAddressTVC alloc] init];
    [self.navigationController pushViewController:residentialAddressVC animated:YES];
    
}
//小区类型
- (void)didClickType
{
    CMCCommunityTypeTableVC *communityTableVC = [[CMCCommunityTypeTableVC alloc] init];
    [self.navigationController pushViewController:communityTableVC animated:YES];
    
}
//小区地址
- (void)didClickcommunityButton:(UIButton *)button
{
    CMCResidentialAddressTVC *residentialAddressVC = [[CMCResidentialAddressTVC alloc] init];
    
    [self.navigationController pushViewController:residentialAddressVC animated:YES];
    
}
- (void)didClickSubmitButton
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)creatNavigationBackButton
{
    UIButton *billButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 10, 20)];
    [billButton setBackgroundImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [billButton addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [billButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:billButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
}
#pragma mark-
#pragma mark- 返回按钮
- (void)didClickBackBtn:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //    [_contentView resignFirstResponder];
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (_contentView.text.length == 0) {
        _contentLabel.text = @"请描述投诉内容";
        
        
    } else{
        
        _contentLabel.text = @"";
    }
    _contentView.text = textView.text;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_mapLabelTextField resignFirstResponder];
    return YES;
    
}

- (void)didClickEditButton:(UIButton *)button
{
    _mapLabelTextField.userInteractionEnabled = YES;
    
    
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
