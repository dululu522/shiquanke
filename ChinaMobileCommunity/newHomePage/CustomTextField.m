//
//  CustomTextField.m
//  AddressBook
//
//  Created by  on.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

+ (id)textFieldWithFrame:(CGRect)frame delegate:(id)delegate{
    CustomTextField *textField = [[CustomTextField alloc]initWithFrame:frame];
    textField.delegate = delegate;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont systemFontOfSize: 14];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
    
}

//给键盘上添加辅助视图
- (void)setupInputAccessoryView{
    self.accessoryToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 33)];
    UIBarButtonItem *prePageItem = [[UIBarButtonItem alloc]initWithTitle:@"上一项" style:UIBarButtonItemStylePlain target:self.target action:self.switchPageAction];
    UIBarButtonItem *nextPageItem = [[UIBarButtonItem alloc]initWithTitle:@"下一项" style:UIBarButtonItemStylePlain target:self.target action:self.switchPageAction];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.target action:self.doneAction];
    
    self.accessoryToolBar.items = @[prePageItem,nextPageItem,space,doneItem];
    //为文本输入框添加输入辅助视图
    self.inputAccessoryView = self.accessoryToolBar;
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
