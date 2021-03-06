//
//  CMCDomesticServiceVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-9.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCDomesticServiceVC.h"
#import "CustomTextField.h"
#import "CMCOrderMakeSureCell.h"
#import "CMCAddressItem.h"
//#import "AddAddressViewController.h"
#import "CMCFoodReservationTimeVC.h"
#import "MAddressViewController.h"
#import "CustomTextField.h"
#import "CMCOrderSucesssViewController.h"
#import "CMCConvenientLifeDetailVC.h"


@interface CMCDomesticServiceVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *payMethodV;
    CustomTextField *nameTF;
    CustomTextField *phoneTF;
    CustomTextField *beizhuTF;
    UITextField *textF;
    UIView *infoV;
    UILabel *timeL;
    
    UILabel *_nameL;
    UILabel *_placeL;
    
}
@property (nonatomic,strong)UITableView *orderTableView;
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *infoScrollView;
@property (nonatomic,strong)NSMutableArray *orderArr;
@property (nonatomic,strong)NSString *payment;
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic,strong)NSMutableArray *textFieldArray;
@end

@implementation CMCDomesticServiceVC

- (NSMutableArray *)textFieldArray{
    if (_textFieldArray == nil) {
        self.textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}

- (NSMutableArray *)orderArr{
    if (_orderArr == nil) {
        self.orderArr = [NSMutableArray array];
    }
    return _orderArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] isKindOfClass:[NSDictionary class]]) {
        NSLog(@"将用户选择的地址存储到本地 %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"]);
        NSString *name = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"name"];
        NSString *phone = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"phone"];
        NSString *address = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"address"];
        _nameL.text = [NSString stringWithFormat:@"%@  %@",name,phone];
        _placeL.text = address;
    }
    
    
}
- (void)viewDidLoad {
    
    NSLog(@"^^^^^^^^^订单确认 %@",self.serviceArr);
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
    self.datasArray = [[NSMutableArray alloc] init];
    self.title = @"订单确认";
    // Do any additional setup after loading the view.
    self.payment = @"1";
    [self dataDealWith];//数据处理
    //我的地址
    [self loadUserInformation];
    
    [self createSubViews];
    //添加通知，得到取件时间
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addData:) name:@"addData" object:nil];
}

- (void)addData:(NSNotification *)sender{
    NSString *time = sender.object;
    NSLog(@"time ======= %@",sender.object);
    timeL.text = time;
    
}




#pragma mark - 数据处理 -

- (void)dataDealWith{
    NSArray *valueArr = self.orderDic.allValues;
    NSArray *keyArr = self.orderDic.allKeys;
    for (int i = 0; i < keyArr.count; i++) {
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:keyArr[i]];
        [tmpArr addObject:valueArr[i]];
        [self.orderArr addObject:tmpArr];
    }
    NSLog(@"self.orderArr = %@",self.orderArr);
}



#pragma mark - 创建子视图 -
- (void)createSubViews{
    [self setupTableView];//tableview
    [self setupScrollView];//底部scrollview
     [self setupInfoScrollView];
    //具体信息
    
    //购物车之类
    [self creatBottomView];
    
}



- (void)setupTableView{
    
    _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,200) style:UITableViewStyleGrouped];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_orderTableView];
}


- (void)setupScrollView{
    _infoScrollView = [[TPKeyboardAvoidingScrollView alloc]init];
    _infoScrollView.frame = CGRectMake(0, _orderTableView.bottom, self.view.width, self.view.height - _orderTableView.bottom - 70 - 49);
    _infoScrollView.backgroundColor = k_color(@"f5f4f4");
//    _infoScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_infoScrollView];
}

- (void)loadUserInformation
{
    
    [self.datasArray removeAllObjects];
    //获取我的地址数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    ;
    if ([CMCUserManager shareManager].token) {
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"timestamp":timestamp};
        //        NSLog(@"我的地址:%@",dic);
        NSString *sig= [BaseUtil getSigWithArray:dic];
        
        NSString *requestStr = KAPI_Myaddress(timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig]);
        [BaseUtil get:requestStr success:^(id respondObject) {
            NSLog(@"我的地址 %@",respondObject);
            
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSArray *dataArr = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataArr) {
                        [self.datasArray addObject:[CMCAddressItem fromDict:tempDic]];
                        
                    }
                    CMCAddressItem *addressItem = [self.datasArray lastObject];
                    _nameL.text = [NSString stringWithFormat:@"%@  %@",addressItem.name,addressItem.phone];
                    _placeL.text = addressItem.address;
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    //                    [self.tableView reloadData];
                } else {
                    [BaseUtil toast:@"暂无收货地址"];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    return;
                    
                }
            } else {
                
                [BaseUtil toast:@"数据加载失败,请重新加载"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                return;
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
    } else {
        
        [BaseUtil toast:@"请登录后再试"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//0319
        
    }
    //    [_request loadDataWithURLString:requestStr];
    
    
}


//外卖

//0318
- (void)setupInfoScrollView{

    NSLog(@"--------%@",self.category);
    //备注
    UIView *beizhuV = [self createVWithFrame:CGRectMake(0,0, self.view.width, 41)];
    UILabel *beizhuL = [self createLWithFrame:CGRectMake(19, 15, 30, 13) font:13 textColor:@"7f7f7f" superView:beizhuV];
        beizhuL.text = @"备注:";
//    [beizhuV addSubview:beizhuL];
    textF = [[UITextField alloc]init];
    textF.frame = CGRectMake(beizhuL.right, beizhuL.top, self.view.width - beizhuL.right-19, 13);
    textF.delegate = self;
    textF.font = k_font(13);
    textF.textColor = k_color(@"7f7f7f");
    [beizhuV addSubview:textF];
    
    [_infoScrollView addSubview:beizhuV];
    
    //取件时间
    UIView *takesV = [self createVWithFrame:CGRectMake(0, beizhuV.bottom+6, self.view.width, 41)];
//            botm = takesV.bottom + 6;

    UILabel *titleL = [self createLWithFrame:CGRectMake(19, 15,65, 13) font:13 textColor:@"7f7f7f" superView:takesV];
    titleL.text = @"服务时间:";


    timeL = [self createLWithFrame:CGRectMake(titleL.right, 15, self.view.width - titleL.right, 15) font:13 textColor:@"7f7f7f" superView:takesV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeAction:)];
    [takesV addGestureRecognizer:tap];
    [_infoScrollView addSubview:takesV];
    
    //具体信息
    infoV = [self createVWithFrame:CGRectMake(0, takesV.bottom + 6, self.view.width, 84)];
    
    _nameL = [self createLWithFrame:CGRectMake(19, 18, 230, 13) font:13 textColor:@"7f7f7f" superView:infoV];
    
    _placeL = [self createLWithFrame:CGRectMake(19, _nameL.bottom + 24, 230, 13) font:13 textColor:@"7f7f7f" superView:infoV];

    UIButton *addBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtt.frame =CGRectMake(self.view.width - 69, 0, 69, 84);
    [addBtt setImage:[UIImage imageNamed:@"convenience_addAddress"] forState:UIControlStateNormal];
    [addBtt addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [infoV addSubview:addBtt];
    
    [_infoScrollView addSubview:infoV];
    
    _infoScrollView.contentSize = CGSizeMake(self.view.width, infoV.bottom + 20);
    
    [self loadUserInformation];

}

#pragma mark - 选择收货地址
//增加地址
- (void)addAddressAction:(UIButton *)sender{
    NSLog(@"增加地址");
    MAddressViewController* add = [[MAddressViewController alloc]init];
    add.titleStr = self.title;
    [self.navigationController pushViewController:add animated:YES];
    
    
}


- (void)timeAction:(UITapGestureRecognizer *)sender{
    
    NSLog(@"-----------time");
    CMCFoodReservationTimeVC *foodReservationVC = [[CMCFoodReservationTimeVC alloc] init];
    foodReservationVC.title = @"选择时间";
    [self.navigationController pushViewController:foodReservationVC animated:YES];
    
}
- (void)creatBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 120, self.view.frame.size.width, 70)];
    [self.view addSubview:bottomView];


    //付款
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 10, self.view.frame.size.width - 40, 40);
    submitButton.layer.cornerRadius = 5;

    [bottomView addSubview:submitButton];
    submitButton.backgroundColor = kAPI_AllMainColor;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickPayButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

//付款

#pragma mark - 提交订单
- (void)didClickPayButton:(UIButton *)sender{
    
    NSString *nameStr;
    NSString *phoneStr;
    NSString *addressStr;
    NSString *commentStr;

        if (beizhuTF.text.length == 0) {
            beizhuTF.text = @"";
        }
    if (timeL.text.length == 0) {
        [BaseUtil toast:@"请选择服务时间"];
        return;

    }
        //电话之类的
        nameStr = nameTF.text;
        phoneStr = phoneTF.text;
        addressStr = @"";
        commentStr = beizhuTF.text;
        
    NSLog(@"self.datasArray      %@",self.datasArray);
    
            if (self.datasArray.count == 0) {
                [BaseUtil toast:@"添加一个地址"];
                return;
            }else{

                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] isKindOfClass:[NSDictionary class]]) {
                    nameStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"name"];
                    phoneStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"phone"];
                    addressStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"id"];
                } else {
                    CMCAddressItem *addressItem = [self.datasArray lastObject];
                    //电话之类的
                    nameStr = addressItem.name;
                    phoneStr = addressItem.phone;
                    addressStr = addressItem.id;
                    
                }
            }
    
    
    
                if (textF.text.length == 0) {
                    commentStr = @"";
                }else{
                    commentStr = [NSString stringWithFormat:@"%@",textF.text];
                }

    if (nameStr.length == 0 |addressStr.length==0 |phoneStr.length == 0) {
        [BaseUtil toast:@"请选择地址"];
        return;
    }
    if ([CMCUserManager shareManager].token) {
            NSString *timestamp = kAPI_timestamp;
                    NSString *priceStr = [[self.serviceArr objectAtIndex:0] objectForKey:@"price"];
        NSString *content = [NSString stringWithFormat:@"%@,1",[[self.serviceArr objectAtIndex:0] objectForKey:@"id"]];
        
        NSLog(@"=========%@ %@",self.mid, self.service_id);
            NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.mid,@"service_id":self.service_id,@"money":priceStr,@"express_money":@"0",@"content":content,@"payment":@"0",@"comment":commentStr,@"timestamp":timestamp,@"name":nameStr,@"address_id":addressStr,@"phone":phoneStr,@"user_time":timeL.text};
        
            NSString *sig = KAPI_GetSig(dic);
            NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.mid,@"service_id":self.service_id,@"money":priceStr,@"express_money":@"0",@"content":content,@"payment":@"0",@"comment":commentStr,@"timestamp":timestamp,@"name":nameStr,@"address_id":addressStr,@"phone":phoneStr,@"sig":sig,@"user_time":timeL.text};
        NSLog(@"tmpDic  %@",tmpDic);
            NSString *url = KAPI_UserNewOrder;
            [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
                NSLog(@"------------%@",responseObj);
                if ([[[responseObj objectForKey:@"info"] objectForKey:@"result"] intValue] == 0) {
//                    NSString *order_id = [[responseObj objectForKey:@"data"] objectForKey:@"order_id"];
//                    NSLog(@"----------%@",order_id);
                    if ([responseObj objectForKey:@"data"]) {
                         NSString *order_id = [[responseObj objectForKey:@"data"] objectForKey:@"order_id"];
                        if (order_id) {
                           //下单成功
                            [self creatOrderSucess];
                        }
                    }
                    
        
                    //支付订单
//                    [self  orderPayWithOrder_id:order_id];
        
                }
                
            } ailure:^(NSError *error) {
                
            }];

    }
    
//    if ([self.category isEqualToString:@"外卖"]| [self.category isEqualToString:@"洗衣"] |[self.category isEqualToString:@"修鞋"]) {
//        if (self.datasArray.count == 0) {
//            [BaseUtil toast:@"添加一个地址"];
//        }else{
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"]) {
//                nameStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"name"];
//                phoneStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"phone"];
//                addressStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectAddress"] objectForKey:@"id"];
//            } else {
//                CMCAddressItem *addressItem = [self.datasArray lastObject];
//                //电话之类的
//                nameStr = addressItem.name;
//                phoneStr = addressItem.phone;
//                addressStr = addressItem.id;
//                
//            }
//            
//            if (textF.text.length == 0) {
//                commentStr = @"";
//            }else{
//                commentStr = textF.text;
//            }
//        }
//    }
//    
//    
//    if (![CMCUserManager shareManager].token) {
//        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//        return;
//    }
//    
//    //点菜内容
//    NSMutableString *content = [NSMutableString string];
//    for (int i = 0; i < self.orderArr.count; i++) {
//        NSArray *arr = self.orderArr[i];
//        NSString *tmpStr = [NSString stringWithFormat:@"%@,%@",arr[3],arr[4]];
//        [content appendString:tmpStr];
//        NSLog(@"self.orderArr = %@",self.orderArr);
//        [content appendString:@"|"];
//        
//    }
//    [content deleteCharactersInRange:NSMakeRange(content.length - 1, 1)];
//    
//    NSLog(@"contet ======= %@",content);
//    NSLog(@"self.sec === %@",k_zid);
//    NSString *timestamp = kAPI_timestamp;
//    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":self.service_id,@"money":self.price,@"express_money":@"0",@"content":content,@"payment":self.payment,@"comment":commentStr,@"timestamp":timestamp,@"name":nameStr,@"address_id":addressStr,@"phone":phoneStr};
//    
//    NSLog(@"fukuan^^^^^^^ %@",dic);
//    NSString *sig = KAPI_GetSig(dic);
//    NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":self.service_id,@"money":self.price,@"express_money":@"0",@"content":content,@"payment":self.payment,@"comment":commentStr,@"timestamp":timestamp,@"name":nameStr,@"address_id":addressStr,@"phone":phoneStr,@"sig":sig};
//    
//    NSLog(@"------%@",tmpDic);
//    NSString *url = KAPI_UserNewOrder;
//    [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
//        NSLog(@"------------%@",responseObj);
//        if ([[[responseObj objectForKey:@"info"] objectForKey:@"result"] intValue] == 0) {
//            NSString *order_id = [[responseObj objectForKey:@"data"] objectForKey:@"order_id"];
//            NSLog(@"----------%@",order_id);
//            
//            //支付订单
//            [self  orderPayWithOrder_id:order_id];
//            
//        }
//        
//    } ailure:^(NSError *error) {
//        
//    }];
//    
//    NSLog(@"付款");
//    
}
#pragma mark - 下单成功
- (void)creatOrderSucess
{

    CMCOrderSucesssViewController *sucessVC = [[CMCOrderSucesssViewController alloc] init];
    sucessVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sucessVC animated:YES];



}

- (void)orderPayWithOrder_id:(NSString *)order_id{
    
    NSString *timestamp = kAPI_timestamp;
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"order_id":order_id,@"timestamp":timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_orderPay(order_id, timestamp, sig);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"----------resopObject === %@",respondObject);
        if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"0"]) {
            NSDictionary *dataDic = [respondObject objectForKey:@"data"];
            NSString *money = [dataDic objectForKey:@"money"];
            NSString *order_id = [dataDic objectForKey:@"order_id"];
            NSString *payment_type = [dataDic objectForKey:@"payment_type"];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


#pragma mark - tableviewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.serviceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 44);
    view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.frame = CGRectMake(10, 9, 14, 14);
//    imageView.image = [UIImage imageNamed:@"shangjia"];
//    [view addSubview:imageView];
    
    UILabel *nameL = [[UILabel alloc]init];
    nameL.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 44);
    if (self.serviceArr.count) {
        nameL.text = [[self.serviceArr objectAtIndex:0] objectForKey:@"name"];
    }
    nameL.textColor = k_color(@"a2a2a2");
    nameL.font = k_font(14);
    [view addSubview:nameL];
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.frame = CGRectMake(10,44 - 0.5, self.view.frame.size.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [view addSubview:sepeV];
    
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]init];
    }

    if (self.serviceArr.count) {
        NSString *priceStr = [[self.serviceArr objectAtIndex:0] objectForKey:@"price"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 44)];
        [cell addSubview:label];
        label.font = k_font(14);
        label.text = [NSString stringWithFormat:@"收费标准:￥%@",priceStr];
        label.textColor = [UIColor colorWithHexString:@"5b5b5b"];
    }
    return cell;
    
}


#pragma mark - textFieldDelete -

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        _infoScrollView.frame = CGRectMake(0, _orderTableView.bottom, self.view.width, self.view.height - _orderTableView.bottom - 49);
        
    }];
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == nameTF) {
        [[[[nameTF accessoryToolBar] items]objectAtIndex:0]setEnabled:NO];
    }
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        _infoScrollView.frame = CGRectMake(0, 0, self.view.width,_infoScrollView.contentSize.height);
    }];
    [self.view bringSubviewToFront:_infoScrollView];
    return YES;
    
}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//        [UIView animateWithDuration:0.5 animations:^{
//            _infoScrollView.frame = CGRectMake(0, _orderTableView.bottom, self.view.width, self.view.height - _orderTableView.bottom - 49);
//        }];
//
//    return YES;
//}




#pragma mark -  公共方法 －


//创建label
- (CustomTextField *)createTLWithFrame:(CGRect)frame
                              category:(NSString *)category
                             superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = category;
    label.font = [UIFont systemFontOfSize:11.0];
    label.textColor = k_color(@"808080");
    [superView addSubview:label];
    
    CustomTextField *tf = [CustomTextField textFieldWithFrame:CGRectMake(label.right, label.top, 200, label.height) delegate:self];
    tf.target = self;
    tf.delegate = self;
    tf.switchPageAction = @selector(handleSwitchPageAction:);
    tf.doneAction = @selector(handleDoneAction:);
    [tf setupInputAccessoryView];
    
    tf.font = [UIFont systemFontOfSize:11];
    tf.textColor = k_color(@"808080");
    [superView addSubview:tf];
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    if ([category isEqualToString:@"备注:"]) {
        sepeV.frame = CGRectMake(0,label.bottom + 10, self.view.width, 0.5);
        sepeV.backgroundColor = k_color(@"dadada");
    }else{
        sepeV.frame = CGRectMake(10,label.bottom + 10, self.view.width - 20, 0.5);
        sepeV.backgroundColor = k_color(@"ededed");
    }
    
    [superView addSubview:sepeV];
    
    return tf;
}

//给辅助键实现功能
- (void)handleSwitchPageAction:(UIBarButtonItem *)sender{
    NSInteger nextIndex = 0;//保存下一个要成为第一响应者的下标
    NSInteger currentIndex = 0;
    //遍历textFieldArray数组
    for (int i = 0; i < self.textFieldArray.count ; i++) {
        if ([self.textFieldArray[i] isFirstResponder]) {//判断当前下标的textField为第一响应者 把下标赋值给当前坐标变量
            currentIndex = i;
            break;
        }
    }
    
    
    if ([sender.title isEqualToString:@"下一项"]) {
        if (currentIndex <= 2) {//如果当前下标小于等于2 下一项的坐标为当前坐标+1
            nextIndex = currentIndex + 1;
            
        }
        
    }else{
        if (currentIndex >= 1) {//如果下标大于等于1 上一项的坐标为当前坐标-1
            nextIndex = currentIndex - 1;
        }
        
    }
    [self.textFieldArray[nextIndex] becomeFirstResponder];//下一个变为第一响应者
    
    
    if (nextIndex == 2) {//如果是最后一个textField,让下一项变的不可用
        [[[[self.textFieldArray[nextIndex] accessoryToolBar] items]objectAtIndex:1] setEnabled:NO];
    }
    
    if (nextIndex == 0) {//如果是第一textField,让上一项不可用
        [[[[self.textFieldArray[nextIndex] accessoryToolBar] items]objectAtIndex:0]setEnabled:NO];
    }
    
    
}

//完成键的功能实现
- (void)handleDoneAction:(UIBarButtonItem *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        _infoScrollView.frame = CGRectMake(0, _orderTableView.bottom, self.view.width, self.view.height - _orderTableView.bottom - 49);
        
    }];
    
    //释放所有textField的第一响应权
    [self.textFieldArray makeObjectsPerformSelector:@selector(resignFirstResponder)];
    
}



//创建label
- (UILabel *)createLWithFrame:(CGRect)frame
                         font:(float)font
                    textColor:(NSString *)color
                    superView:(UIView *)superView{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    [superView addSubview:label];
    return label;
}


//添加底色
- (UIView *)createVWithFrame:(CGRect)frame{
    UIView *bottomV = [[UIView alloc]init];
    bottomV.frame = frame;
    bottomV.backgroundColor = [UIColor whiteColor];
    [_infoScrollView addSubview:bottomV];
    return bottomV;
}


- (void)createBttWithFrame:(CGRect)frame
                 imageName:(NSString *)imageName
                     title:(NSString *)title
                    action:(SEL)action
                 superView:(UIView *)superView
                       tag:(int)tag{
    UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
    btt.frame = frame;
    [btt setTitle:title forState:UIControlStateNormal];
    [btt addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btt.titleLabel.font = [UIFont systemFontOfSize:13];
    [btt setTitleColor:k_color(@"808080") forState:UIControlStateNormal];
    btt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    btt.tag = tag;
    [btt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [superView addSubview:btt];
    
}


- (NSString *)returnServiceWithCategory:(NSString *)category{
    if ([category isEqualToString:@"点菜"]) {
        return @"1";
    }
    
    if ([category isEqualToString:@"外卖"]) {
        return @"2";
    }
    if ([category isEqualToString:@"买单"]) {
        return @"3";
    }
    if ([category isEqualToString:@"预定"]) {
        return @"4";
    }
    return nil;
    
    
}

//是否加时间
- (BOOL)returnIsHaveTimeL{
    if ([self.category isEqualToString:@"洗衣"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"修鞋"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"到店美容"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"到店美发"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"上门美发"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"上门美容"]) {
        return YES;
    }
    if ([self.category isEqualToString:@"家政服务"]) {
        return YES;
    }
    return NO;
}

//时间名字
- (NSString *)returnTitleName{
    if ([self.category isEqualToString:@"洗衣"]) {
        return @"取件时间：";
    }
    if ([self.category isEqualToString:@"修鞋"]) {
        return @"取件时间：";
    }
    if ([self.category isEqualToString:@"到店美容"]) {
        return @"到店时间：";
    }
    if ([self.category isEqualToString:@"到店美发"]) {
        return @"到店时间：";
    }
    if ([self.category isEqualToString:@"上门美发"]) {
        return @"上门时间：";
    }
    if ([self.category isEqualToString:@"上门美容"]) {
        return @"上门时间：";
    }
    return nil;
    
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
