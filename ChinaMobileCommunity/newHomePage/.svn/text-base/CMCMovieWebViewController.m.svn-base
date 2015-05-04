//
//  CMCMovieWebViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMovieWebViewController.h"

@interface CMCMovieWebViewController ()

@end

@implementation CMCMovieWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    if ([self.title isEqualToString:@"去看电影"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.gewara.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
    if ([self.title isEqualToString:@"宽途汽车"]){
//    http://www.kuanter.com/
    
        NSURL *url = [NSURL URLWithString:@"http://www.kuanter.com/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    
    }

    [self.view addSubview:webView];
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
