//
//  CMCMyVoucherOrderDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyVoucherOrderDetailVC.h"

@interface CMCMyVoucherOrderDetailVC ()

@end

@implementation CMCMyVoucherOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(10,11, 25, 16);
    imgView.image = [UIImage imageNamed:@"icon_shop_new"];
    [backView addSubview:imgView];
    
    //名字
    UILabel *nameL = [self createLWithFrame:CGRectMake(imgView.right + 5, 12, 200, 15) font:15 textColor:@"444444" superView:backView];
    
    UILabel *voucherL = [self createLWithFrame:CGRectMake(nameL.left, nameL.bottom + 5, 40, 15) font:15 textColor:@"444444" superView:backView];
    voucherL.text = @"代金券:";
    //现在的价格
    UILabel *usePriceL = [[UILabel alloc] initWithFrame:CGRectMake(voucherL.right + 5, nameL.top, 100, 15)];
    usePriceL.textColor = [UIColor redColor];
    [backView addSubview:usePriceL];
    //优惠前的价格
    UILabel *oldPriceL = [[UILabel alloc] initWithFrame:CGRectMake(usePriceL.right + 5, nameL.top, 100, 15)];
    oldPriceL.textColor = k_color(@"acacac");
    [backView addSubview:oldPriceL];
    [BaseUtil setCenterLineView:oldPriceL];
    
    //购买日期
    UILabel *buyDataL = [self createLWithFrame:CGRectMake(nameL.left, voucherL.bottom + 20, 40, 15) font:15 textColor:@"444444" superView:backView];
    //退款日期
        UILabel *refundDataL = [self createLWithFrame:CGRectMake(nameL.left, buyDataL.bottom + 5, 40, 15) font:15 textColor:@"444444" superView:backView];
    //退款总金额
        UILabel *totalL = [self createLWithFrame:CGRectMake(nameL.left, refundDataL.bottom + 5, 40, 15) font:15 textColor:@"444444" superView:backView];
    //退款原因
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(nameL.left, totalL.bottom + 20, self.view.bounds.size.width - 30, 80)];
    [backView addSubview:textView];
    
    UIButton *sumbitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sumbitBtn.frame = CGRectMake(nameL.left, textView.bottom + 10, self.view.frame.size.width - 2*nameL.left, 40);
    [sumbitBtn addTarget:self action:@selector(didClickSumbitBtn:) forControlEvents:UIControlEventTouchUpInside];
    sumbitBtn.titleLabel.textColor = kAPI_AllMainColor;
    [sumbitBtn setTitle:@"提交退款" forState:UIControlStateNormal];
    [backView addSubview:sumbitBtn];

}
- (void)didClickSumbitBtn:(UIButton *)button
{


}
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
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
