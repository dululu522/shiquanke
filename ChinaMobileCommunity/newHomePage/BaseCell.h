//
//  BaseCell.h
//  CMCYouHuiVC
//
//  Created by 武鹏 on 14-11-11.
//  Copyright (c) 2014年 堵路路. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (nonatomic,strong)UIImageView *myImageView;
@property (nonatomic,strong)UILabel *titleLabel;//标题
@property (nonatomic,strong)UILabel *detailLabel;//详情介绍
@property (nonatomic,strong)UIButton *button;//点击按钮

@end
