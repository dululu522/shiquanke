//
//  CMCCommunityBanksVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-23.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCommunityBanksVC.h"

@interface CMCCommunityBanksVC ()<UIWebViewDelegate>

@end

@implementation CMCCommunityBanksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://bank.ecitic.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}



#pragma mark end
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
