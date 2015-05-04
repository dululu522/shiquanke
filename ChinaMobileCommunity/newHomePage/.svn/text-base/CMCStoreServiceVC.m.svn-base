//
//  CMCStoreServiceVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCStoreServiceVC.h"
#import "CMCStoreServiceTableViewCell.h"
# import "CMCOrderMakeSureVC.h"

@interface CMCStoreServiceVC ()
{
    UIView *_backView;
    UILabel *edgeLabel;
    UILabel *priceLabel;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CMCStoreServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_backView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_backView addSubview:self.tableView];
    [self creatBottomView];
}
- (void)creatBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 120, self.view.frame.size.width, 60)];
    //    bottomView.backgroundColor = [UIColor redColor];
    [_backView addSubview:bottomView];
    
    
    //购物车
    UIImage *image = [UIImage imageNamed:@"shopCar_goods"];
    UIImageView *shopCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, image.size.width, image.size.height)];
    shopCarImageView.image = image;
    [bottomView addSubview:shopCarImageView];
    
    //角标
    edgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCarImageView.right -5, 15, 15, 15)];
    edgeLabel.backgroundColor = [UIColor colorWithHexString:@"ff8f21"];
    edgeLabel.layer.cornerRadius = 7.5;
    edgeLabel.layer.masksToBounds = YES;
    edgeLabel.textAlignment = NSTextAlignmentCenter;
    edgeLabel.font = k_font(15);
    edgeLabel.adjustsFontSizeToFitWidth = YES;
    [bottomView addSubview:edgeLabel];
    
    //合计
    UILabel *combinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(edgeLabel.right + 10, 0, 30, 70)];
    combinedLabel.font = [UIFont systemFontOfSize:13.0];
    combinedLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    combinedLabel.text = @"合计:";
    [bottomView addSubview:combinedLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(combinedLabel.right+2, 0, 100, 70)];
    priceLabel.text = @"";
    priceLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    priceLabel.font = [UIFont systemFontOfSize:13.0];
    [bottomView addSubview:priceLabel];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(self.view.frame.size.width- 105, 10, 90, 35);
    submitButton.layer.cornerRadius = 5;
    [bottomView addSubview:submitButton];
    submitButton.backgroundColor = kAPI_AllMainColor;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didClickSubmitButton:(UIButton *)button
{
    CMCOrderMakeSureVC *submitVC = [[CMCOrderMakeSureVC alloc] init];
    submitVC.title = @"提交订单";
    [self.navigationController pushViewController:submitVC animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

 static NSString *str = @"reused";
    CMCStoreServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CMCStoreServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell creatLeftPhoneImageCell:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
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
