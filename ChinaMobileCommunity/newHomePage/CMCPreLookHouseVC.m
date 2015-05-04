//
//  CMCPreLookHouseVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-7.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPreLookHouseVC.h"
#import "CMCFoodReservationTimeVC.h"

@interface CMCPreLookHouseVC ()<UITextFieldDelegate>
{
    UILabel *timeL;
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *beizhuTF;
}

@property (nonatomic,strong)TPKeyboardAvoidingScrollView *btmScrollView;


@end

@implementation CMCPreLookHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"预约看房";
    // Do any additional setup after loading the view.
    [self createSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addData:) name:@"addData" object:nil];
}

- (void)addData:(NSNotification *)sender{
    NSString *time = sender.object;
    timeL.text = time;
    
}

#pragma mark - 创建子视图- 

- (void)createSubViews{
    [self setupBtmScrolV];
    [self setupOtherSubViews];
    
}

- (void)setupBtmScrolV{
    _btmScrollView = [[TPKeyboardAvoidingScrollView alloc]init];
    _btmScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
    _btmScrollView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.view addSubview:_btmScrollView];
    
}

- (void)setupOtherSubViews{
    NSLog(@"预约看房  %@",self.preDic);
    //第一分区
    UIView *btmV = [[UIView alloc]init];
    btmV.frame = CGRectMake(0, 0, self.view.width, 200);
    btmV.backgroundColor = [UIColor whiteColor];
    [_btmScrollView addSubview:btmV];
    
    //名字
    UILabel *nameL = [self returnLWithFrame:CGRectMake(10, 15, self.view.width - 20, 15) font:15 textColor:[UIColor colorWithHexString:@"444444"] superView:btmV];
    nameL.text = [self.preDic objectForKey:@"name"];
    [btmV addSubview:nameL];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,nameL.bottom + 10, self.view.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [btmV addSubview:sepeV];
    
    UILabel *textView = [[UILabel alloc] init];
//    textView.backgroundColor = [UIColor redColor];
    textView.text = [self.preDic objectForKey:@"intro"];
    textView.userInteractionEnabled = NO;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = [UIColor colorWithHexString:@"666666"];
     CGRect rect = [BaseUtil returnHeightWithContent:[self.preDic objectForKey:@"intro"] WithFont:14 width:232 height:0];
    CGFloat heigt = rect.size.height;
    textView.frame = CGRectMake(10, sepeV.bottom , self.view.frame.size.width - 20, heigt);
    [btmV addSubview:textView];
    btmV.frame = CGRectMake(0, 0, self.view.width, textView.bottom + 10);

//    //规格
//    UILabel *standardL = [self returnLWithFrame:CGRectMake(10, sepeV.bottom + 14, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:btmV];
//    standardL.text = @"规格：";
//    
//    CGFloat heigt = [BaseUtil returnHeightWithContent:@"3室一厅一卫  精装修  70m2  普通住宅 朝南朝北    5/10层" WithFont:13 width:232 height:0];
//    UILabel *standardCL = [self returnLWithFrame:CGRectMake(standardL.right, standardL.top, 232, heigt) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:btmV];
//    standardCL.numberOfLines = 0;
//    standardCL.text = @"3室一厅一卫  精装修  70m2  普通住宅 朝南朝北    5/10层";
    
//    //地址
//    UILabel *placeL = [self returnLWithFrame:CGRectMake(10, standardCL.bottom + 10, 70, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:btmV];
//    placeL.text = @"地址：";
//    placeL.adjustsLetterSpacingToFitWidth = YES;
//    
//    UILabel *placeCL = [self returnLWithFrame:CGRectMake(placeL.right, placeL.top, 232, 13) font:13 textColor:[UIColor colorWithHexString:@"555555"] superView:btmV];
//    placeCL.text = @"石景山苹果园路痛经大厦702室";
    
    //底部坐标
//    btmV.frame = CGRectMake(0, 0, self.view.width, placeL.bottom + 15);
    
    //第二分区
    
    //服务时间
    UIView *takesV = [[UIView alloc]init];
    takesV.frame = CGRectMake(0, btmV.bottom + 15, self.view.width, 45);
    takesV.backgroundColor = [UIColor whiteColor];
    [_btmScrollView addSubview:takesV];
    
    
    UILabel *titleL = [self returnLWithFrame:CGRectMake(10, 15,65, 13) font:13 textColor:[UIColor colorWithHexString:@"7f7f7f"] superView:takesV];
    titleL.text = @"看房时间：";
    
    timeL = [self returnLWithFrame:CGRectMake(titleL.right, 15, self.view.width - titleL.right, 15) font:13 textColor:[UIColor colorWithHexString:@"7f7f7f"] superView:takesV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeAction:)];
    [takesV addGestureRecognizer:tap];
    
    
    //第三分区
    UIView *thirdV = [[UIView alloc]init];
    thirdV.frame = CGRectMake(0, takesV.bottom + 15, self.view.width, 0);
    thirdV.backgroundColor = [UIColor whiteColor];
    
    beizhuTF = [self createTLWithFrame:CGRectMake(10, 15, 30, 11) category:@"备注:" superView:thirdV];
    
    nameTF = [self createTLWithFrame:CGRectMake(10, 48, 30, 11) category:@"姓名:" superView:thirdV];
    phoneTF = [self createTLWithFrame:CGRectMake(10, 81, 30, 11) category:@"电话:" superView:thirdV];
    
    thirdV.frame = CGRectMake(0, takesV.bottom + 15, self.view.width, phoneTF.bottom + 15);
    [_btmScrollView addSubview:thirdV];
    
    UIButton *sureBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtt.frame = CGRectMake(10, thirdV.bottom + 30, self.view.width - 20, 43);
    [sureBtt setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [sureBtt setTitle:@"确定下单" forState:UIControlStateNormal];
    [sureBtt addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btmScrollView addSubview:sureBtt];
    _btmScrollView.contentSize = CGSizeMake(self.view.width,  sureBtt.bottom + 20);
    
    
    
}
//选择时间
- (void)timeAction:(UITapGestureRecognizer *)sender{
    
    CMCFoodReservationTimeVC *foodReservationVC = [[CMCFoodReservationTimeVC alloc] init];
    foodReservationVC.title = @"选择时间";
    [self.navigationController pushViewController:foodReservationVC animated:YES];
    
}

//确定下单
- (void)sureAction:(UIButton *)sender{
    NSLog(@"确定下单");
    
    //0319
    if (timeL.text.length == 0) {
        [BaseUtil toast:@"请选择时间看房时间"];
        return;
        
    }
    if (nameTF.text.length == 0) {
        [BaseUtil toast:@"请填写姓名"];
        return;
    }
    if (phoneTF.text.length == 0) {
        [BaseUtil toast:@"请填写电话"];
        return;
    }
    
    
    [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":self.service_id,@"money":@"0",@"express_money":@"0",@"content":[NSString stringWithFormat:@"RH|%@",self.goodsID],@"payment":@"",@"comment":beizhuTF.text,@"timestamp":timestamp,@"name":nameTF.text,@"address_id":@"0",@"phone":phoneTF.text,@"user_time":timeL.text};
    
    NSLog(@"fukuan^^^^^^^ %@",dic);
    
    NSString *sig = KAPI_GetSig(dic);
    NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":self.service_id,@"money":@"0",@"express_money":@"0",@"content":[NSString stringWithFormat:@"RH|%@",self.goodsID],@"payment":@"",@"comment":beizhuTF.text,@"timestamp":timestamp,@"name":nameTF.text,@"address_id":@"0",@"phone":phoneTF.text,@"user_time":timeL.text,@"sig":sig};
    NSString *url = KAPI_UserNewOrder;
    [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
        NSLog(@"---------responseObj ==== %@",responseObj);
        if ([[[[responseObj objectForKey:@"info"] objectForKey:@"result"] stringValue]isEqualToString:@"0"]) {
            
            [BaseUtil toast:@"预约成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } ailure:^(NSError *error) {
        [BaseUtil toast:@"预约失败"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    
    
}

#pragma mark - textFieldDelete -

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}



#pragma mark - 公共方法 －
- (UILabel *)returnLWithFrame:(CGRect)frame
                         font:(CGFloat)font
                    textColor:(UIColor *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentNatural;
    label.adjustsLetterSpacingToFitWidth = YES;
    [superView addSubview:label];
    return label;
    
}

//创建label
- (UITextField *)createTLWithFrame:(CGRect)frame
                          category:(NSString *)category
                         superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = category;
    label.font = [UIFont systemFontOfSize:11.0];
    label.textColor = k_color(@"808080");
    [superView addSubview:label];
    
    UITextField *tf = [[UITextField alloc]init];
    tf.frame = CGRectMake(label.right, label.top, 200, label.height);
    tf.delegate = self;
    tf.font = [UIFont systemFontOfSize:11];
    tf.textColor = k_color(@"808080");
    [superView addSubview:tf];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    if ([category isEqualToString:@"备注:"] | [category isEqualToString:@"姓名:"]) {
        sepeV.frame = CGRectMake(10,label.bottom + 10, self.view.width - 20, 0.5);
        sepeV.backgroundColor = k_color(@"dadada");
    }
    [superView addSubview:sepeV];
    
    return tf;
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
