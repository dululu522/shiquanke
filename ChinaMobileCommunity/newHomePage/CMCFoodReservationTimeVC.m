//
//  CMCFoodReservationTimeVCViewController.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-10.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//
#define currentMonth [currentMonthString integerValue]

#import "CMCFoodReservationTimeVC.h"

@interface CMCFoodReservationTimeVC ()
{
    
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NSArray *amPmArray;
    NSArray *hoursArray;
    NSMutableArray *minutesArray;
    
    NSString *currentMonthString;
    
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    
    BOOL firstTimeLoad;
    
}
@property (nonatomic, strong) UITextField *textFieldEnterDate;
@property (nonatomic, strong) UIToolbar *toolbarCancelDone;
@property (nonatomic, strong)  UIPickerView *customPicker;
@end

@implementation CMCFoodReservationTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textFieldEnterDate = [[UITextField alloc] init];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    doneButton.backgroundColor = [UIColor orangeColor];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(didClickdoneButton:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(230, 0, 40, 30);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    firstTimeLoad = YES;
    //    self.customPicker.hidden = YES;
    //    self.toolbarCancelDone.hidden = YES;
    self.customPicker = [[UIPickerView alloc] init];
    //    self.customPicker.frame = CGRectMake(10,200, self.view.bounds.size.width-10, 200);
    
    self.customPicker.delegate = self;
    self.customPicker.dataSource = self;
    [self.view addSubview:self.customPicker];
    
    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    NSLog(@"当前年=======%@",currentyearString);
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    //    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // Get Current  Hour
    [formatter setDateFormat:@"hh"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  Minutes
    [formatter setDateFormat:@"mm"];
    NSString *currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  AM PM
    
    [formatter setDateFormat:@"a"];
    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = [currentyearString intValue]; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    
    
    hoursArray = @[@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
    
    
    // PickerView -  Hours data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 60; i++)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    
    
    // PickerView -  AM PM data
    
    //    amPmArray = @[@"AM",@"PM"];
    
    
    
    // PickerView -  days data
    
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView - Default Selection as per current Date
    
    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    
    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    
    //    [self.customPicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
    //
    //    [self.customPicker selectRow:[hoursArray indexOfObject:currentHourString] inComponent:3 animated:YES];
    //
    //    [self.customPicker selectRow:[minutesArray indexOfObject:currentMinutesString] inComponent:4 animated:YES];
    
    //    [self.customPicker selectRow:[amPmArray indexOfObject:currentTimeAMPMString] inComponent:5 animated:YES];
}
- (void)didClickdoneButton:(UIButton *)button
{
    self.textFieldEnterDate.text = [NSString stringWithFormat:@"%@-%@-%@  %@ : %@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]],[hoursArray objectAtIndex:[self.customPicker selectedRowInComponent:3]],[minutesArray objectAtIndex:[self.customPicker selectedRowInComponent:4]]];
    NSLog(@"self.textFieldEnterDate.text  %@",self.textFieldEnterDate.text);
    [CMCUserManager shareManager].yuDingTime = self.textFieldEnterDate.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addData" object:self.textFieldEnterDate.text];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
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
        pickerLabel.text =  [NSString stringWithFormat:@"%@",[yearArray objectAtIndex:row]]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    else if (component == 3)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 4)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
    else
    {
        //        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;
    
}

// returns the # of rows in each component..
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
        
        return hoursArray.count;
        
    }
    else if (component == 4)
    { // min
        return 60;
    }
    else
    { // am/pm
        return 0;
        
    }
    
    
    
}

- (IBAction)actionCancel:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = NO;
                         self.toolbarCancelDone.hidden = NO;
                         self.textFieldEnterDate.text = @"";
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    self.textFieldEnterDate.text = @"";
    
    
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return  YES;
    
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
