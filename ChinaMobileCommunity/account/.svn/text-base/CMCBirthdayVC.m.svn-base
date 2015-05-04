//
//  CMCBirthdayVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//
#define currentMonth [currentMonthString integerValue]

#import "CMCBirthdayVC.h"

@interface CMCBirthdayVC ()
{
    
    NSString *currentMonthString;
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NetWorkRequest *_request;
    
    BOOL firstTimeLoad;
}
@property (weak, nonatomic) IBOutlet UIPickerView *customPickView;

@end

@implementation CMCBirthdayVC

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
    // Do any additional setup after loading the view from its nib.
    _request = [[NetWorkRequest alloc] init];
    _request.delegate = self;

    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"完成" forState:UIControlStateNormal];
    [saveButton setTintColor:[UIColor whiteColor]];
     [saveButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame = CGRectMake(self.view.bounds.size.width - 50, 20, 50, 40);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    
    
    NSDate *date = [NSDate date];
    // Get Current Year
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%d",[[formatter stringFromDate:date] integerValue]];
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    DaysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    // PickerView - Default Selection as per current Date
    
    [self.customPickView selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    
    [self.customPickView selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    
    [self.customPickView selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
    
}

- (void)clickSaveButton
{
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@",[yearArray objectAtIndex:[self.customPickView selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPickView selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPickView selectedRowInComponent:2]]];
//    NSString *sig = KAPI_GetMyModelSig([CMCUserManager shareManager].token,@"birthday",str);
//    NSString *requestStr = KAPI_getModelUserinfo([BaseUtil md5:sig], [CMCUserManager shareManager].token, @"birthday", str);
//    [_request loadDataWithURLString:requestStr];
    NSString *requestStr = [BaseUtil getRequestUrlByType:@"birthday" AndValue:str];
    [BaseUtil get:requestStr success:^(id respondObject) {
        NSLog(@"生日 =======%@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
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
//请求数据成功之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
   didFinishing:(NSData *)data
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"生日  +++++++%@",dic);
    NSDictionary *infoDic = [dic objectForKey:@"info"];
    if ([[infoDic objectForKey:@"result"] intValue] == 0) {
        [BaseUtil toast:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } else {
        [BaseUtil toast:@"修改失败"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        return;
    
    }


}

//请求数据失败之后执行代理方法
- (void)request:(NetWorkRequest *)netWorkRequest
didFailWithError:(NSError *)error
{





}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
        if (firstTimeLoad)
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
            }
            else
            {
                return 30;
            }
            
        }
        else
        {
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
            
        }
        
        
    }
    else if (component == 3)
    { // hour
        
        return 12;
        
    }
    else if (component == 4)
    { // min
        return 60;
    }
    else
    { // am/pm
        return 2;
        
    }
    
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPickView reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPickView reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPickView reloadAllComponents];
        
    }
    
}
#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }

    
    return pickerLabel;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
