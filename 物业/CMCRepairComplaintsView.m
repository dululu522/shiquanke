//
//  CMCRepairComplaintsView.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-22.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCRepairComplaintsView.h"
#import "CMCResidentialAddressTVC.h"
@implementation CMCRepairComplaintsView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)creatViewMap:(NSString *)mapAddress communityText:(NSString *)communityText typeText:(NSString *)typeText
{
    UIView *mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    mapView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mapView];
    
    UIImageView *mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 10, 13)];
    mapImageView.image = [UIImage imageNamed:@"地_03"];
    [mapView addSubview:mapImageView];
    _mapLabelTextField = [[UITextField alloc] initWithFrame:CGRectMake(mapImageView.frame.size.width + mapImageView.frame.origin.x + 6, 5, 250, 30)];
    //    _mapLabelTextField.delegate = self;
    _mapLabelTextField.text = [CMCUserManager shareManager].currentAddress;
    _mapLabelTextField.userInteractionEnabled = NO;
    
    [mapView addSubview:_mapLabelTextField];
    //小区
    UIView *seconView = [[UIView alloc] initWithFrame:CGRectMake(0, mapView.frame.size.height + mapView.frame.origin.y + 15, self.bounds.size.width, 90)];
    seconView.backgroundColor = [UIColor whiteColor];
    [self addSubview:seconView];
    
    UIImageView *middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, self.bounds.size.width - 20, 1)];
    middleImageView.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];

    [seconView addSubview:middleImageView];
    
    _communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 100, 45)];
    _communityLabel.font = [UIFont systemFontOfSize:14.0];
//    _communityLabel.text = communityText;
    _communityLabel.text = [CMCUserManager shareManager].wuye_address;
    [seconView addSubview:_communityLabel];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 10, 15, 15)];
//    searchImageView.image = [UIImage imageNamed:@"search"];
    [seconView addSubview:searchImageView];
    
//    UIButton *communityButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 45)];
//    communityButton.userInteractionEnabled = YES;
////    [communityButton addTarget:self action:@selector(didClickcommunityButton:) forControlEvents:UIControlEventTouchUpInside];
//    [communityButton setTitle:[CMCUserManager shareManager].wuye_address forState:UIControlStateNormal];
//    [seconView addSubview:communityButton];
    
    //报修类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45 , self.bounds.size.width - 100, 45)];
    if ([CMCUserManager shareManager].communityType) {
        _typeLabel.text = [CMCUserManager shareManager].communityType;

    } else {
    
    _typeLabel.text = @"环境";
    }
    _typeLabel.font = [UIFont systemFontOfSize:14.0];
    
    [seconView addSubview:_typeLabel];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 45 + 17, 10, 15)];
    [seconView addSubview:arrowImageView];
    arrowImageView.image = [UIImage imageNamed:@"展开"];
    UIButton *typeButton = [[UIButton alloc] initWithFrame:_typeLabel.frame];
    [typeButton addTarget:self action:@selector(didClickTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [seconView addSubview:typeButton];
    

    //投诉内容
    
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, seconView.bottom + 15, self.bounds.size.width, 60)];
    NSLog(@"^^^^^^^^^^%@",_contentView);
    _contentView.delegate = self;
    _contentView.hidden = NO;
    //    _contentView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_contentView];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    _contentLabel.enabled = YES;
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.text = @"请描述投诉内容";
    _contentLabel.font = k_font(13.0);
    _contentView.font = k_font(13.0);
    [_contentView addSubview:_contentLabel];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, _contentView.frame.size.height + _contentView.frame.origin.y + 110, 120, 40)];
    
    submitButton.userInteractionEnabled = YES;
    [submitButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickSubmitButton2) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];
    
}
- (void)didClickPhotoButton:(UIButton *)button
{
    [self.delegate didClickButton:button.tag];
}
#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //    [_contentView resignFirstResponder];
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (_contentView.text.length == 0) {
        _contentLabel.text = @"请描述投诉内容";
        
        
    } else{
        
        _contentLabel.text = @"";
    }
    _contentView.text = textView.text;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_mapLabelTextField resignFirstResponder];
    return YES;
    
}
////小区地址
//- (void)didClickcommunityButton:(UIButton *)button
//{
//    [self.delegate didClickCommunity];
//    
//}
//报修类型
- (void)didClickTypeButton:(UIButton *)button
{
    
    [self.delegate didClickType];
    
}

//提交
- (void)didClickSubmitButton2
{
    NSLog(@"nkcfkavklkvndkl;anv;b vbnmm,");
    NSLog(@"%@  %@",_typeLabel.text ,_contentView.text);
    if (_typeLabel.text.length&&_contentView.text.length){
        NSLog(@"self.type ========%@",self.type);
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"zid":self.zid,@"type":self.type,@"genre":_typeLabel.text,@"content":_contentView.text,@"timestamp":timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSLog(@"dic    %@",dic);
        NSString *requestUrl = KAPI_propertyComplain([CMCUserManager shareManager].token, self.zid, self.type, _typeLabel.text, _contentView.text, timestamp,[BaseUtil md5:sig]);
        NSLog(@"投诉报修 %@",requestUrl);
        [BaseUtil get:requestUrl success:^(id respondObject) {
            NSLog(@"投诉报修 %@",respondObject);
            [MBProgressHUD showHUDAddedTo:self animated:YES];
            
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
//                    [BaseUtil toast:@"提交成功"];
                    [MBProgressHUD hideAllHUDsForView:self animated:YES];
                    [self.delegate returnSucessful];
                    //                [self.delegate didClickSubmitButton];
                } else {
                    [MBProgressHUD hideAllHUDsForView:self animated:YES];
                    
                    [BaseUtil toast:@"提交失败,请重新提交"];
                }
                
            }else {
                [BaseUtil toast:@"提交失败,请重试"];
                [MBProgressHUD hideAllHUDsForView:self animated:YES];
                
            }
        } failure:^(NSError *error) {
            
        }];
    
    }else {
        [BaseUtil toast:@"请把内容填写完整"];
    }

    
}
- (void)didClickEditButton:(UIButton *)button
{
    _mapLabelTextField.userInteractionEnabled = YES;
    
    
}

@end
