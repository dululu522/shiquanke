//
//  CMCFirstServiceEvaluationVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-7.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCFirstServiceEvaluationVC.h"
#import "StarView.h"

@interface CMCFirstServiceEvaluationVC ()
{
    UITextView *_textView;
    NetWorkRequest *_request;

}
@property (nonatomic, strong) UILabel *severNumberlabel;
@property (nonatomic, strong) UILabel *tasteNumberlabel;
@property (nonatomic, strong) UILabel *speedNumberlabel;
@end

@implementation CMCFirstServiceEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评价";
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    

    __weak typeof(self) wself = self;

    StarView *tasteStaView = [[StarView alloc] initWithFrame:CGRectMake(50, 20, 130, 30)];
    tasteStaView.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
    [self.view addSubview:tasteStaView];
    UILabel *tasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 30)];
    tasteLabel.text = @"口味";
    //    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tasteLabel];
    _tasteNumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(tasteStaView.frame.size.width +tasteStaView.frame.origin.x + 10, 20, 50, 30)];
    _tasteNumberlabel.text = @"0分";
    [self.view addSubview:_tasteNumberlabel];
    //改变分值
    [tasteStaView setButtonBlock:^(NSInteger number) {
        wself.tasteNumberlabel.text = [NSString stringWithFormat:@"%ld分",(long)number];
    }];
    //*******************速度


    //改变速度分值
    StarView *speedStaView = [[StarView alloc] initWithFrame:CGRectMake(50, tasteLabel.frame.size.height +tasteLabel.frame.origin.y+10, 130, 30)];
    speedStaView.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
    [self.view addSubview:speedStaView];
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, tasteLabel.frame.size.height +tasteLabel.frame.origin.y+10, 50, 30)];
    speedLabel.text = @"速度";
    [self.view addSubview:speedLabel];
    _speedNumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(speedStaView.frame.size.width +speedStaView.frame.origin.x + 10, speedLabel.frame.origin.y, 50, 30)];
    _speedNumberlabel.text = @"0分";
    [self.view addSubview:_speedNumberlabel];
    [speedStaView setButtonBlock:^(NSInteger number) {
        wself.speedNumberlabel.text = [NSString stringWithFormat:@"%ld分",(long)number];
    }];
    

    //*******************服务
    

    //改变服务分值
    StarView *severStaView = [[StarView alloc] initWithFrame:CGRectMake(50, speedLabel.frame.size.height +speedLabel.frame.origin.y+10, 130, 30)];
    severStaView.backgroundColor = [UIColor colorWithHexString:@"F5F4F4"];
    [self.view addSubview:severStaView];
    UILabel *severLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, speedLabel.frame.size.height +speedLabel.frame.origin.y+10, 50, 30)];
    severLabel.text = @"服务";
    [self.view addSubview:severLabel];
    _severNumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(severStaView.frame.size.width +severStaView.frame.origin.x + 10, severLabel.frame.origin.y, 50, 30)];
    _severNumberlabel.text = @"0分";
    [self.view addSubview:_severNumberlabel];
    
    [severStaView setButtonBlock:^(NSInteger number) {
        wself.severNumberlabel.text = [NSString stringWithFormat:@"%ld分",(long)number];
    }];
    

    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, severLabel.frame.size.height + severLabel.frame.origin.y + 10, self.view.bounds.size.width - 20, 120)];
//    textField.backgroundColor = [UIColor whiteColor];
////    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.placeholder = @"可输入评价内容";
//    [self.view addSubview:textField];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, severLabel.frame.size.height + severLabel.frame.origin.y + 10, self.view.bounds.size.width - 20, 120)];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-75, self.view.frame.size.height - 120, 150,40)];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    

    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;

}
-(void)didClickSubmitButton:(UIButton *)button
{
    NSLog(@"改变分值 ======%@",self.tasteNumberlabel.text);
    NSLog(@"改变分值 ======%@",self.speedNumberlabel.text);
    NSLog(@"改变分值 ======%@",self.severNumberlabel.text);
    NSLog(@"改变分值 ======%@",_textView.text);



    NSString *timestamp = kAPI_timestamp;
    NSDictionary *postDic = @{@"channel":kAPI_channel,@"token":[CMCUserManager shareManager].token,@"order_id":self.order_id,@"evaluate_content":_textView.text,@"evaluate_taste":self.tasteNumberlabel.text,@"evaluate_speed":self.speedNumberlabel.text,@"evaluate_serve":self.severNumberlabel.text,@"timestamp":timestamp};
    NSLog(@"%@",postDic);
    NSString *sig = [BaseUtil getSigWithArray:postDic];
    NSString *requestStr = kAPI_getMyorderUsereva(timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig], self.order_id, _textView.text, self.tasteNumberlabel.text, self.speedNumberlabel.text, self.severNumberlabel.text);
    NSLog(@"requestStr ======%@",requestStr);
    [_request loadDataWithURLString:requestStr];



}
#pragma mark-
#pragma mark- NetWorkRequesDelegate
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"评价dic===========%@",dic);


}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{


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
