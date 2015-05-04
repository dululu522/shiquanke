//
//  CMCOnlineBookingVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-26.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOnlineBookingVC.h"

#import "CMCReservationTimeVC.h"
#import "CMCFoodReservationTimeVC.h"

#define font_size [UIFont systemFontOfSize:12.0]
#define font_kolor [UIColor colorWithHexString:@"676767"]
#define left_clearance  20
#define k_width  60
@interface CMCOnlineBookingVC ()
{

    UIButton *_yuDingBtn;
    UIImageView *_womanImageView;
    UIImageView *_roomsImageView;
    UIImageView *_hashTableImageView;
    UIImageView *_manImageView;
    UITextField *_noteLabel; //备注
    UITextField *_numberTF;
    UITextField *_phoneTF;
    UITextField *_userTF;
    UILabel *_timeLabel1;
    UITableView *_myTableView;
    UITextField *_desk;
    NetWorkRequest *_request;
    TPKeyboardAvoidingScrollView *_scrollView;
}
@property (nonatomic, assign)  BOOL type;
@property (nonatomic, assign)  BOOL sex;



@end

@implementation CMCOnlineBookingVC
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    _yuDingBtn.hidden = YES;
//
//
//}
- (void)viewWillAppear:(BOOL)animated
{


    [super viewWillAppear:animated];
    if ([CMCUserManager shareManager].yuDingTime) {
        _timeLabel1.text = [CMCUserManager shareManager].yuDingTime;

    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"在线预订";

    // Do any additional setup after loading the view.
    
//    UIView *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
//    [self.view addSubview:shopLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor whiteColor];
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;
    _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    NSArray *imageArr = [[NSArray alloc] initWithObjects:@"yuding_long",@"yuding_short",@"yuding_short",@"yuding_long", nil];
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 + 35*i, self.view.bounds.size.width, 35)];
        imageView.image = [UIImage imageNamed:[imageArr objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    
    UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
//    shopImageView.backgroundColor = [UIColor greenColor];
    shopImageView.image = [UIImage imageNamed:@"shangjia"];
    [_scrollView addSubview:shopImageView];
    
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopImageView.frame.size.width + shopImageView.frame.origin.x+5, 10, 200, 35)];
    shopNameLabel.text = self.merchant_name;
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [_scrollView addSubview:shopNameLabel];
//    shopNameLabel.backgroundColor = [UIColor orangeColor];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, shopNameLabel.frame.size.height + shopNameLabel.frame.origin.y, 60, 35)];
    typeLabel.textColor = font_kolor;
    typeLabel.font = [UIFont systemFontOfSize:12.0];
    typeLabel.text = @"预订类型:";
    [_scrollView addSubview:typeLabel];
    
    //散桌
    
    _hashTableImageView = [[UIImageView alloc] init];
    _hashTableImageView.frame = CGRectMake(typeLabel.frame.size.width + typeLabel.frame.origin.x+ 5, typeLabel.frame.origin.y + 13, 10, 10);
//    hashTableImageView.backgroundColor = [UIColor blackColor];
    _hashTableImageView.userInteractionEnabled = YES;
    _hashTableImageView.image = [UIImage imageNamed:@"未选_25"];
    [_scrollView addSubview:_hashTableImageView];
    
    UILabel *hashTableLabel = [[UILabel alloc] initWithFrame:CGRectMake(_hashTableImageView.frame.size.width + _hashTableImageView.frame.origin.x+5, typeLabel.frame.origin.y, 40, 35)];
    hashTableLabel.text = @"散桌";
    hashTableLabel.font = font_size;
    hashTableLabel.textColor = font_kolor;

    [_scrollView addSubview:hashTableLabel];
    
    UIButton *hashTableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hashTableButton.frame = CGRectMake(_hashTableImageView.frame.origin.x, hashTableLabel.frame.origin.y, 20+5+40, 35);
//    hashTableButton.backgroundColor = [UIColor greenColor];
    [hashTableButton addTarget:self action:@selector(didClickHashTabelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:hashTableButton];
    
    //包间
    
    _roomsImageView = [[UIImageView alloc] init];
    _roomsImageView.image = [UIImage imageNamed:@"未选_25"];
    _roomsImageView.userInteractionEnabled = YES;
    _roomsImageView.frame = CGRectMake(hashTableLabel.frame.size.width + hashTableLabel.frame.origin.x + 10, typeLabel.frame.origin.y + 13, 10, 10);
//    _roomsImageView.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:_roomsImageView];
    
    UILabel *roomsLabel = [[UILabel alloc] initWithFrame:CGRectMake(_roomsImageView.frame.size.width + _roomsImageView.frame.origin.x+5, typeLabel.frame.origin.y, 40, 35)];
    roomsLabel.text = @"包间";
    roomsLabel.textColor = font_kolor;
    roomsLabel.font = font_size;

    [_scrollView addSubview:roomsLabel];
    
    UIButton *roomsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    roomsButton.frame = CGRectMake(_roomsImageView.frame.origin.x, roomsLabel.frame.origin.y, 20+5+40, 35);
    [roomsButton addTarget:self action:@selector(didClickRoomsButton:) forControlEvents:UIControlEventTouchUpInside];
//    roomsButton.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:roomsButton];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, typeLabel.frame.size.height + typeLabel.frame.origin.y, k_width, 35)];
    numberLabel.text = @"预订人数:";
    numberLabel.textColor = font_kolor;
    numberLabel.font = font_size;

    [_scrollView addSubview:numberLabel];
    _numberTF = [[UITextField alloc] initWithFrame:CGRectMake(numberLabel.frame.size.width + numberLabel.frame.origin.x, numberLabel.frame.origin.y, 80, 35)];
    _numberTF.textColor = [UIColor colorWithHexString:@"666666"];

    _numberTF.placeholder = @"点击输入人数";
    _numberTF.keyboardType = UIKeyboardTypeNumberPad;
    _numberTF.font = [UIFont systemFontOfSize:10.0];
    _numberTF.delegate = self;
    [_scrollView addSubview:_numberTF];
    
    
    //桌数
    
    UILabel *deskNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numberTF.frame.size.width + _numberTF.frame.origin.x + 10, numberLabel.frame.origin.y, 40, 35)];
    deskNumberLabel.text = @"桌数:";
    deskNumberLabel.font = font_size;
    deskNumberLabel.textColor =font_kolor;

    [_scrollView addSubview:deskNumberLabel];
    
    _desk = [[UITextField alloc] initWithFrame:CGRectMake(deskNumberLabel.frame.size.width + deskNumberLabel.frame.origin.x+5, numberLabel.frame.origin.y, 100, 35)];
    _desk.delegate = self;
    _desk.textColor = [UIColor colorWithHexString:@"666666"];
    _desk.textAlignment = NSTextAlignmentLeft;
    _desk.placeholder = @"桌数";
    _desk.keyboardType = UIKeyboardTypeNumberPad;
    _desk.font = [UIFont systemFontOfSize:10.0];
//    _desk.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:_desk];
    
//    UIImageView *deskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_desk.frame.size.width + _desk.frame.origin.x, numberLabel.frame.origin.y, 20, 35)];
////    deskImageView.backgroundColor = [UIColor orangeColor];
//    deskImageView.userInteractionEnabled = YES;
//    [_scrollView addSubview:deskImageView];
//    UIButton *deskButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    deskButton.frame = CGRectMake(_desk.frame.origin.x, numberLabel.frame.origin.y, 30+20, 35);
//    [deskButton setBackgroundImage:[UIImage imageNamed:@"座次_06"] forState:UIControlStateNormal];
//    deskButton.alpha = 0.5;
////    deskButton.imageEdgeInsets =  UIEdgeInsetsMake(20, 0, 0, 0);
//    [deskButton addTarget:self action:@selector(didClickDeskButton:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:deskButton];
//    
//    UILabel *deskLabel = [[UILabel alloc] initWithFrame:CGRectMake(deskNumberLabel.frame.size.width + deskNumberLabel.frame.origin.x, 0, 80, 35)];
//    deskLabel.textColor = [UIColor colorWithHexString:@"666666"];
//
//    [_scrollView addSubview:deskLabel];

    
    //预订时间
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, deskNumberLabel.frame.origin.y + deskNumberLabel.frame.size.height, k_width, 35)];
    timeLabel.text = @"预订时间:";
    timeLabel.font = font_size;
    timeLabel.textColor = font_kolor;

    [_scrollView addSubview:timeLabel];
    _timeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.frame.size.width + timeLabel.frame.origin.x, deskNumberLabel.frame.origin.y + deskNumberLabel.frame.size.height, 200, 35)];
    _timeLabel1.text = [CMCUserManager shareManager].yuDingTime;
    _timeLabel1.textColor = font_kolor;
    _timeLabel1.font = [UIFont systemFontOfSize:10];

    [_scrollView addSubview:_timeLabel1];
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake(0, deskNumberLabel.frame.origin.y + deskNumberLabel.frame.size.height, 400, 35);
    [timeButton addTarget:self action:@selector(didClickTimeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeButton];
    
    NSArray *imageArr2 = [[NSArray alloc] initWithObjects:@"yuding_short",@"yuding_short", @"yuding_long",nil];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, timeLabel.frame.origin.y + timeLabel.frame.size.height + 10 + 35*i, self.view.bounds.size.width, 35)];
        imageView.image = [UIImage imageNamed:[imageArr2 objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, timeLabel.frame.origin.y + timeLabel.frame.size.height + 10, 40, 35)];
    userNameLabel.text = @"姓名:";
    userNameLabel.font = font_size;
    userNameLabel.textColor = font_kolor;

    [_scrollView addSubview:userNameLabel];
    _userTF = [[UITextField alloc] initWithFrame:CGRectMake(userNameLabel.frame.size.width + userNameLabel.frame.origin.x, userNameLabel.frame.origin.y, 100, 35)];
    _userTF.delegate = self;
    _userTF.font = font_size;
    _userTF.textColor = font_kolor;

//    _userTF.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:_userTF];
    
   //性别
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, userNameLabel.frame.size.height + userNameLabel.frame.origin.y, 40, 35)];
    sexLabel.text = @"性别:";
    sexLabel.textColor = font_kolor;
    sexLabel.font = font_size;

    [_scrollView addSubview:sexLabel];
    
    //男
    
   _manImageView = [[UIImageView alloc] init];
    _manImageView.frame = CGRectMake(sexLabel.frame.size.width + sexLabel.frame.origin.x+ 6, sexLabel.frame.origin.y + 13, 10, 10);
//    manImageView.backgroundColor = [UIColor blackColor];
    _manImageView.image = [UIImage imageNamed:@"未选_25"];
    _manImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_manImageView];
    
    UILabel *manTableLabel = [[UILabel alloc] initWithFrame:CGRectMake(_manImageView.frame.size.width + _manImageView.frame.origin.x+5, sexLabel.frame.origin.y, 40, 35)];
    manTableLabel.text = @"男";

    manTableLabel.textColor = font_kolor;
    manTableLabel.font = font_size;

    [_scrollView addSubview:manTableLabel];
    
    UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [manButton addTarget:self action:@selector(didClickManButton:) forControlEvents:UIControlEventTouchUpInside];
    manButton.frame = CGRectMake(_manImageView.frame.origin.x, sexLabel.frame.origin.y, 20+5+40, 35);
//    manButton.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:manButton];
    
    //女
   _womanImageView = [[UIImageView alloc] init];
    _womanImageView.frame = CGRectMake(manTableLabel.frame.size.width + hashTableLabel.frame.origin.x + 10, sexLabel.frame.origin.y+13, 10, 10);
//    womanImageView.backgroundColor = [UIColor blackColor];
    _womanImageView.image = [UIImage imageNamed:@"未选_25"];
    _womanImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_womanImageView];
    
    UILabel *womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(_womanImageView.frame.size.width + _womanImageView.frame.origin.x+5, sexLabel.frame.origin.y, 40, 35)];
    womanLabel.text = @"女";
    womanLabel.textColor = font_kolor;
    womanLabel.font = font_size;

    [_scrollView addSubview:womanLabel];
    
    UIButton *womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    womanButton.frame = CGRectMake(_womanImageView.frame.origin.x,sexLabel.frame.origin.y , 20 + 5+ 40, 35);
//    womanButton.backgroundColor = [UIColor redColor];
    [womanButton addTarget:self action:@selector(didClickWomanButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:womanButton];
    
    //预订电话
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_clearance, sexLabel.frame.origin.y+sexLabel.frame.size.height, k_width, 35)];
    phoneLabel.text = @"预订电话:";
    phoneLabel.font = font_size;
    phoneLabel.textColor = font_kolor;
    [_scrollView addSubview:phoneLabel];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.frame.size.width + phoneLabel.frame.origin.x, phoneLabel.frame.origin.y, 250, 35)];
    _phoneTF.textColor = font_kolor;
    _phoneTF.delegate = self;
    _phoneTF.font = font_size;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.placeholder = @"点击输入";
    [_scrollView addSubview:_phoneTF];
    
    
    _noteLabel = [[UITextField alloc] initWithFrame:CGRectMake(0, phoneLabel.frame.size.height + phoneLabel.frame.origin.y + 10, self.view.bounds.size.width , 70)];
    _noteLabel.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    _noteLabel.placeholder = @" 备注:";
    _noteLabel.font = font_size;
    
    _noteLabel.delegate = self;
    [_scrollView addSubview:_noteLabel];
    
    
        _yuDingBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.frame.size.height - 64 - 49 ,200,40)];
    
        [_yuDingBtn setTitle:@"预订" forState:UIControlStateNormal];
        //        _yuDingBtn.backgroundColor = kAPI_color;
        [_yuDingBtn setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        [_yuDingBtn addTarget:self action:@selector(didClickYuDingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_yuDingBtn];
    


    

 
    [self didClickHashTabelButton:nil];
    [self didClickManButton:nil];
    
}
- (void)tap:(UIGestureRecognizer *)tap
{

//    UITextField *_noteLabel; //备注
//    UITextField *_numberTF;
//    UITextField *_phoneTF;
//    UITextField *_userTF;
//    [_noteLabel resignFirstResponder];
//    [_numberTF resignFirstResponder];
//    [_phoneTF resignFirstResponder];
//    [_userTF resignFirstResponder];
    [self textFieldShouldReturn:nil];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *str = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.textLabel.font = font_size;
    cell.textLabel.textColor = font_kolor;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    _desk.text = cell.textLabel.text;
    
    _myTableView.hidden = YES;



}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 30;

}
#pragma mark -
#pragma mark - 桌数
- (void)didClickDeskButton:(UIButton *)button
{
    if (_myTableView == nil) {
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y + button.frame.size.height, 50, 80)];
    }
    _myTableView.hidden = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
//    [_scrollView addSubview:_myTableView];
    [self.view addSubview:_myTableView];




}
#pragma mark -
#pragma mark - 时间
- (void)didClickTimeButton:(UIButton *)button
{

//    CMCReservationTimeVC *reserVationVC = [[CMCReservationTimeVC alloc] init];
//    [self.navigationController pushViewController:reserVationVC animated:YES];

    CMCFoodReservationTimeVC *foodReservationVC = [[CMCFoodReservationTimeVC alloc] init];
    foodReservationVC.title = @"预定时间";
    foodReservationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:foodReservationVC animated:YES];

}
#pragma mark -
#pragma mark - 散桌
- (void)didClickHashTabelButton:(UIButton *)button
{
    self.type = 1;
    _hashTableImageView.image = [UIImage imageNamed:@"选_25"];
    _roomsImageView.image = [UIImage imageNamed:@"未选_25"];
}
#pragma mark -
#pragma mark - 包间
- (void)didClickRoomsButton:(UIButton *)button
{

    self.type = 0;
    _roomsImageView.image = [UIImage imageNamed:@"选_25"];
    _hashTableImageView.image = [UIImage imageNamed:@"未选_25"];



}
#pragma mark -
#pragma mark - 男
- (void)didClickManButton:(UIButton *)button
{
    self.sex = 1;
    _manImageView.image = [UIImage imageNamed:@"选_25"];
    _womanImageView.image = [UIImage imageNamed:@"未选_25"];


}
#pragma mark -
#pragma mark - 女
- (void)didClickWomanButton:(UIButton *)button
{
    self.sex = 0;
    _manImageView.image = [UIImage imageNamed:@"未选_25"];

    _womanImageView.image = [UIImage imageNamed:@"选_25"];



}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_numberTF resignFirstResponder];
    [_noteLabel resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_userTF resignFirstResponder];
    [_desk resignFirstResponder];
    return YES;


}
#pragma mark -
#pragma mark - 预订
- (void)didClickYuDingBtn:(UIButton *)button
{
//    UITextField *_noteLabel; //备注
//    UITextField *_numberTF;
//    UITextField *_phoneTF;
//    UITextField *_userTF;
    
    //用post进行数据提交
    // 1 散桌 2 包间
    //0 女 1男
    // store_id 是shop_id category_id美食里的就是1
    if (![BaseUtil validateMobile:_phoneTF.text]) {
        [BaseUtil toast:@"请输入正确的手机号"];
        return;
    }
    if (_noteLabel.text.length&&_desk.text.length&&_numberTF.text.length&&_phoneTF.text.length&&_timeLabel1.text.length&&_userTF.text.length&&_noteLabel.text.length&&_desk.text.length) {
        NSLog(@"%@ , %@",_userTF.text, _noteLabel.text);
        if ([CMCUserManager shareManager].token) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *sexStr = [NSString stringWithFormat:@"%d",self.sex];
            NSString *typeStr = [NSString stringWithFormat:@"%d",self.type];
            NSLog(@"---------time = %@",_timeLabel1.text);
            NSString *content = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",typeStr,_numberTF.text,_desk.text,_timeLabel1.text,sexStr,_noteLabel.text];
            
            NSString *timestamp = kAPI_timestamp;
            
            NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":@"4",@"money":@"0",@"express_money":@"0",@"content":content,@"name":_userTF.text,@"phone":_phoneTF.text,@"address_id":@"0",@"comment":_noteLabel.text,@"timestamp":timestamp};
            
            
            
            NSLog(@"dic ======= %@",dic);
            NSString *sig = KAPI_GetSig(dic);
            NSDictionary *tmpDic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"zid":k_zid,@"mid":self.merchant_id,@"service_id":@"4",@"money":@"0",@"express_money":@"0",@"content":content,@"name":_userTF.text,@"phone":_phoneTF.text,@"address_id":@"0",@"comment":_noteLabel.text,@"timestamp":timestamp,@"sig":sig};
            NSString *url = KAPI_UserNewOrder;
            [BaseUtil post:url postBody:tmpDic success:^(id responseObj) {
                NSLog(@"response ====== %@",responseObj);
                if ([[[[responseObj objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
                    [BaseUtil toast:@"预定成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            } ailure:^(NSError *error) {
                [BaseUtil toast:@"预定失败"];
                NSLog(@"error ====== %@",error);
            }];
            
        } else {
            CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    } else {
        [BaseUtil toast:@"请将预订内容填写完整"];
        
    }
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
