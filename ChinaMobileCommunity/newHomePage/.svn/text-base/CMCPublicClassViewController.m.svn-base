//
//  TCPublicClassViewController.m
//  TelecomCommunity
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"

@interface CMCPublicClassViewController ()
{

    UILabel *_middleLabel;
    UIView *_backView;
}

@end

@implementation CMCPublicClassViewController
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self creatBackButton];
        
    }
    return self;


}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_middleLabel removeFromSuperview];

}

- (void)creatMiddleTitleLabel:(NSString *)title
{
   _middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 20, 120, 44)];
    _middleLabel.text = title;
    [self.navigationController.view addSubview:_middleLabel];
    
    
}
- (void)creatBackButton
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 100, 44);
    [backBtn setImage:[UIImage imageNamed:@"后退_03"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 0, 80)];
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    

}
- (void)didClickBackBtn:(UIButton *)btn
{

 [self.navigationController popViewControllerAnimated:YES];
}
//- (void)didClickBackBtn:(UITapGestureRecognizer *)tap
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

- (void)creat_NOOrder
{
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(33, 31, 85, 100)];
    imageView.image = [UIImage imageNamed:@"no_order"];
    [backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + 33+12, 66+ 43, 200, 30)];
    label.text = @"您暂时还没有订单哦";
    [backView addSubview:label];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
