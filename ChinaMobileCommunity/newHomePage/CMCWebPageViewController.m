//
//  CMCWebPageViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCWebPageViewController.h"

@interface CMCWebPageViewController ()

@end

@implementation CMCWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView =[[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:self.urlStr];
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
