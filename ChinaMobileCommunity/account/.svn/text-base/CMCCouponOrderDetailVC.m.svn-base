//
//  CMCCouponOrderDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCouponOrderDetailVC.h"
#define k_textColor [UIColor colorWithHexString:@"999999"]

@interface CMCCouponOrderDetailVC ()
{
    NSInteger count;
    UIButton *_leftBtn;

}
@property (nonatomic, strong)  UITableView *tabelView;
@property (nonatomic, strong) UILabel *middleLabel;
@end

@implementation CMCCouponOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    self.tabelView.separatorColor = [UIColor colorWithHexString:@"ededed"];
    [BaseUtil setExtraCellLineHidden:self.tabelView];
    [self.view addSubview:self.tabelView];
    
    count = 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"重庆火锅店";
        cell.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"676767"];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    }
    if (indexPath.row == 1) {

        [self creatLeftLabel:@"单价" detailLabelText:@"￥268.00" cell:cell];

    }
    if (indexPath.row == 2) {
        [self creatNumberLabel:cell];
    }
    if (indexPath.row == 3) {

        [self creatLeftLabel:@"总价" detailLabelText:@"￥268.00" cell:cell];
    }
    if (indexPath.row == 4) {
        cell.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    }
    if (indexPath.row == 5) {
        [self creatInstructionsCell:cell];
    }
    if (indexPath.row == 6) {
        [self creatPaymentButton:cell];
        cell.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)creatPaymentButton:(UITableViewCell *)cell
{
    UIButton *paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentButton.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 40);
    paymentButton.userInteractionEnabled = YES;
    [paymentButton setTitle:@"付款" forState:UIControlStateNormal];
    paymentButton.backgroundColor = kAPI_AllMainColor;
    paymentButton.layer.cornerRadius = 10;
    [paymentButton addTarget:self action:@selector(didClickPaymentButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:paymentButton];


}
- (void)didClickPaymentButton:(UIButton *)button
{




}
- (void)creatLeftLabel:(NSString *)leftText detailLabelText:(NSString *)detrailText cell:(UITableViewCell *)cell
{
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 48)];
    leftLabel.textColor = k_textColor;
    leftLabel.font = [UIFont systemFontOfSize:15.0];
    [cell addSubview:leftLabel];
    leftLabel.text = leftText;
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 80, 48)];
    rightLabel.text = detrailText;
    if ([leftLabel.text isEqualToString:@"总价"]) {
        rightLabel.textColor = kAPI_AllMainColor;
    }
    rightLabel.font = [UIFont systemFontOfSize:12.0];
    [cell addSubview:rightLabel];




}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 50;
    }
    if (indexPath.row == 4) {
        return 44;
    }
    if (indexPath.row == 6) {
        return 300;
    }
    return 48;
}
- (void)creatInstructionsCell:(UITableViewCell *)cell
{
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 18, 11, 11)];
    //    leftImageView.backgroundColor = [UIColor greenColor];
    leftImageView.image = [UIImage imageNamed:@"对号_13"];
    [cell addSubview:leftImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.size.width + 15, 0, 100, 40)];
    [cell addSubview:leftLabel];
    leftLabel.text = @"支持随时退款";
    leftLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
    leftLabel.font = [UIFont systemFontOfSize:12.0];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.frame.size.width+ leftLabel.frame.origin.x + 20, leftImageView.frame.origin.y, 11, 11)];
    rightImageView.image = [UIImage imageNamed:@"对号_13"];
    
    //    rightImageView.backgroundColor = [UIColor greenColor];
    [cell addSubview:rightImageView];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightImageView.frame.size.width+ rightImageView.frame.origin.x + 5, 0, 100, 40)];
    rightLabel.text = @"过期自动退款";
    rightLabel.textColor = [UIColor colorWithHexString:@"39cd00"];
    rightLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:rightLabel];
    
    
    
}

- (void)creatNumberLabel:(UITableViewCell *)cell
{
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 48)];
    [cell addSubview:numberLabel];
    numberLabel.text = @"数量";
    numberLabel.textColor = k_textColor;
    //减一
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(self.view.frame.size.width - 120, 9, 31, 31);
    if (count == 1) {
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"sub_noClick"] forState:UIControlStateNormal];
    } else {
    
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];
    
    }

    [_leftBtn addTarget:self action:@selector(didClickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.userInteractionEnabled = YES;
    [cell addSubview:_leftBtn];
    //
    _middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftBtn.frame.size.width+_leftBtn.frame.origin.x, 9, 31, 31)];
    _middleLabel.textAlignment = NSTextAlignmentCenter;
    _middleLabel.textColor = k_textColor;
    _middleLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    [cell addSubview:_middleLabel];
    //加
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(_middleLabel.frame.size.width+_middleLabel.frame.origin.x, 9, 31, 31);
    [rightBtn addTarget:self action:@selector(didClickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    rightBtn.userInteractionEnabled = YES;
    [cell addSubview:rightBtn];
}
//减一
- (void)didClickLeftBtn:(UIButton *)button
{
    if (count == 1) {
        [_leftBtn setImage:[UIImage imageNamed:@"sub_noClick"] forState:UIControlStateNormal];
        
    }else {
        --count;

        _middleLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        if (count == 1) {
        [_leftBtn setImage:[UIImage imageNamed:@"sub_noClick"] forState:UIControlStateNormal];
        } else {
            [_leftBtn setImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];

        }

    }
}
//加一
- (void)didClickRightBtn:(UIButton *)button
{
    ++count;
    _middleLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
     [_leftBtn setImage:[UIImage imageNamed:@"sub_new"] forState:UIControlStateNormal];

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
