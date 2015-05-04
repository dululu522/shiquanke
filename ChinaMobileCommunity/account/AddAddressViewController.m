//
//  AddAddressViewController.m
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()
{

NetWorkRequest *_request; //增加地址
    NetWorkRequest *_editRequest;
}
@property (nonatomic, strong) IBOutlet UITextField* nameText;
@property (nonatomic, strong) IBOutlet UITextField* telText;
@property (nonatomic, strong) IBOutlet UITextField* addressText;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIView *backView;

@end

@implementation AddAddressViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:backView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.backView addGestureRecognizer:tapGesture];
    
    self.title = @"添加地址";
    NSString* righttitle = @"保存";
    if (self.isModify) {
        righttitle = @"修改";
        self.title = @"修改地址";
//        self.nameText.text = self.aitem.name;
//        self.telText.text = self.aitem.mobile;
//        self.addressText.text = self.aitem.street;
//修改 ***************************************************
        self.nameText.text = self.aitem.name;
        self.telText.text = self.aitem.phone;
        self.addressText.text = self.aitem.address;
        self.nameText.delegate = self;
        self.telText.delegate = self;
        self.addressText.delegate = self;
    }
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    _editRequest = [[NetWorkRequest alloc] init];
    _editRequest.delegate = self;

    
    [self.nameText becomeFirstResponder];
    [self.saveButton setBackgroundColor:kAPI_AllMainColor];
    self.saveButton.layer.cornerRadius = 5;
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]
;
    [self.saveButton addTarget:self action:@selector(didClickSaveButton:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)didClickCancelButton:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.nameText resignFirstResponder];
    [self.telText resignFirstResponder];
    [self.addressText resignFirstResponder];


}
- (void)didClickSaveButton:(UIButton *)button
{
    NSLog(@"button");
    
    if (self.nameText.text.length == 0) {
        [BaseUtil toast:@"请输入姓名"];
        return;
    }
    if (self.telText.text.length == 0) {
        [BaseUtil toast:@"请输入手机号"];
        return;
    }
    if (![BaseUtil validateMobile:self.telText.text]) {
        [BaseUtil toast:@"请输入有效的手机号"];
        return;
    }
    if (self.addressText.text.length == 0) {
        [BaseUtil toast:@"请输入地址"];
        return;
    }
    [self.nameText resignFirstResponder];
    [self.telText resignFirstResponder];
    [self.addressText resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES]
    ;
    if (self.isModify) {
        //修改信息
        [self loadModifyData];
        
    } else {
        //****************添加地址*********************************
        [self loadAddData];
    }





}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self.nameText resignFirstResponder];
    [self.telText resignFirstResponder];
    [self.addressText resignFirstResponder];

    return YES;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveAddress
{
    if (self.nameText.text.length == 0) {
        [BaseUtil toast:@"请输入姓名"];
        return;
    }
    if (self.telText.text.length == 0) {
        [BaseUtil toast:@"请输入手机号"];
        return;
    }
    if (![BaseUtil validateMobile:self.telText.text]) {
        [BaseUtil toast:@"请输入有效的手机号"];
        return;
    }
    if (self.addressText.text.length == 0) {
        [BaseUtil toast:@"请输入地址"];
        return;
    }
    [self.nameText resignFirstResponder];
    [self.telText resignFirstResponder];
    [self.addressText resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES]
    ;
    if (self.isModify) {
//修改信息
        [self loadModifyData];

    } else {
        //****************添加地址*********************************
        [self loadAddData];
    }

}
//修改地址
- (void)loadModifyData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"address_id":self.aitem.id,@"phone":self.telText.text,@"name":self.nameText.text,@"address":self.addressText.text,@"timestamp":timestamp};
    NSLog(@"修改地址 %@",dic);
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr = KAPI_EditAddress(self.addressText.text, self.aitem.id, self.telText.text, self.nameText.text, [CMCUserManager shareManager].token, [BaseUtil md5:sig]);
    NSLog(@"修改地址:%@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"修改地址:%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [BaseUtil toast:@"修改成功"];
            self.aitem.name = self.nameText.text;
            self.aitem.address = self.addressText.text;
            self.aitem.phone = self.telText.text;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didModifyAddress:)]) {
                [self.delegate didModifyAddress:self.aitem];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [BaseUtil toast:@"服务端数据错误"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
        }
        
        
    } failure:^(NSError *error) {
        
    }];


}
//添加地址
- (void)loadAddData
{
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"phone":self.telText.text,@"name":self.nameText.text,@"address":self.addressText.text,@"timestamp":timestamp};
    NSString *sig = [BaseUtil getSigWithArray:dic];
    NSString *requestStr = KAPI_Addaddress(self.addressText.text, self.telText.text, self.nameText.text, timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig]);
    NSLog(@"添加地址 %@",requestStr);
    [BaseUtil get:requestStr success:^(id respondObject) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                [BaseUtil toast:@"添加地址成功"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
                [self performSelector:@selector(pop) withObject:nil afterDelay:.5f];
            }else {
                [BaseUtil toast:@"添加地址失败,请重试"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
            }
            
        } else {
            [BaseUtil toast:@"添加地址失败,请重试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } failure:^(NSError *error) {
        
    }];
    


}
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{

    if (netWorkRequest == _editRequest) {
        NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *infoDic = [tempDic objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            [BaseUtil toast:@"修改成功"];
            self.aitem.name = self.nameText.text;
            self.aitem.address = self.addressText.text;
            self.aitem.phone = self.telText.text;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didModifyAddress:)]) {
                    [self.delegate didModifyAddress:self.aitem];
            }
            [self.navigationController popViewControllerAnimated:YES];


            
        }
        
        
        
    }

    
    
}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{
    
    
    
}
- (void)pop
{
    CMCAddressItem* item = [[CMCAddressItem alloc]init];
    item.name = self.nameText.text;
    item.address = self.addressText.text;
    item.id = [CMCUserManager shareManager].token;
    item.phone = self.telText.text;

    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddAddress:)]) {
        [self.delegate didAddAddress:item];
    }
}

@end
