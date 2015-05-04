//
//  CustomTextField.h
//  AddressBook
//
//  Created by 
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property(nonatomic,retain)UIToolbar *accessoryToolBar;
@property(nonatomic,assign)id target;//代理对象
@property(nonatomic,assign)SEL switchPageAction;//下一页上一页的响应事件
@property(nonatomic,assign)SEL doneAction;//完成事件

+ (id)textFieldWithFrame:(CGRect)frame
                delegate:(id)delegate;

- (void)setupInputAccessoryView;//给键盘上面添加辅助功能

@end
