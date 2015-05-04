//
//  CMCXieYiViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-29.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCXieYiViewController.h"

@interface CMCXieYiViewController ()

@end

@implementation CMCXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"十全客使用协议";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://www.cnsqk.com/notice.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
