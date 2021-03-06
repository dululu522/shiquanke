//
//  CMCSignViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCSignViewController.h"

@interface CMCSignViewController ()<UITextFieldDelegate>
{
    NetWorkRequest *_request;

}
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation CMCSignViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"完成" forState:UIControlStateNormal];
//    saveButton.backgroundColor = [UIColor grayColor];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame = CGRectMake(self.view.bounds.size.width - 45, 20, 40, 40);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 70, self.view.bounds.size.width- 10, 100)];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:18.0];
    
    [self.view addSubview:_textField];
    
    


    
    
    
    
}
- (void)clickSaveButton
{

    NSString *requestStr = [BaseUtil getRequestUrlByType:@"intro" AndValue:self.textField.text];
    NSLog(@"个性签名: requestStr ===============%@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"个性签名: %@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                [BaseUtil toast:@"修改成功"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [BaseUtil toast:@"修改失败,请重试"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
        } else {
            
            [BaseUtil toast:@"服务端返回数据错误"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
        }
    } failure:^(NSError *error) {
        
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.textField.text.length >15) {
        return NO;
    }

    return YES;
}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"=========== %@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        [BaseUtil toast:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
    } else {
        [BaseUtil toast:@"修改失败"];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

        return;
    }

}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
