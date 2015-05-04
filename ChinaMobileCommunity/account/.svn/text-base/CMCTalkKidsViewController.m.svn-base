//
//  CMCTalkKidsViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCTalkKidsViewController.h"
@interface CMCTalkKidsViewController ()
{
    UITextView *_talkTextView;
    NetWorkRequest *_request;

}

@end

@implementation CMCTalkKidsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    TPKeyboardAvoidingScrollView *talkView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    talkView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    [self.view addSubview:talkView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 150, 13)];
    titleLabel.text = @"我也说一句";
    titleLabel.font = [UIFont systemFontOfSize:13.0];
    titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
    [_talkTextView addSubview:titleLabel];
    _talkTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, titleLabel.frame.size.height + titleLabel.frame.origin.y +10, self.view.frame.size.width - 20, 200)];
    _talkTextView.backgroundColor = [UIColor whiteColor];
            _talkTextView.delegate = self;
            [talkView addSubview:_talkTextView];
            //发送按钮
            UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
            talkButton.frame = CGRectMake(self.view.frame.size.width/2 - 100, _talkTextView.frame.size.height+_talkTextView.frame.origin.y+20, 200, 40);
    talkButton.layer.cornerRadius = 5;
    [talkButton addTarget:self action:@selector(didClickTalkButton:) forControlEvents:UIControlEventTouchUpInside];
    
            talkButton.backgroundColor = kAPI_AllMainColor;
            [talkButton setTitle:@"发送" forState:UIControlStateNormal];
            [talkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [talkView addSubview:talkButton];
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}
- (void)didClickTalkButton:(UIButton *)button
{
//    NSString *timestamp = kAPI_timestamp;
//    if (_talkTextView.text.length) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
////        if ([CMCUserManager shareManager].suid) {
////            NSDictionary *dic = @{@"channel":kAPI_channel,@"suid":[CMCUserManager shareManager].suid,@"id":self.idStr,@"description":_talkTextView.text,@"timestamp":timestamp};
////            NSString *sig = [BaseUtil getSigWithArray:dic];
////            NSString *requestStr = kAPI_upevaluate(timestamp, [CMCUserManager shareManager].suid, self.idStr, [BaseUtil md5:sig], _talkTextView.text);
////            [_request loadDataWithURLString:requestStr];
//        }
//
//    } else {
//    
//        [BaseUtil toast:@"请填入你想评价的内容"];
//    }
//    



}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"评价 %@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        [BaseUtil toast:@"发送成功"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [BaseUtil toast:@"发送失败,请重试"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }

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
