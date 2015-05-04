//
//  CMCButtonView.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCButtonViewDelegate <NSObject>


- (void)tapNumber:(NSInteger)tapNumber;

@end


@interface CMCButtonView : UIView


@property (nonatomic, assign) id<CMCButtonViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentTag;

//    totalNumber:总个数 count:一行有几个 imageArr 图片数组 textArr:文字数组
- (void)creatButtonNumber:(NSInteger)totalNumber count:(NSInteger)count imageArr:(NSArray *)imageArr textArr:(NSArray *)textArr ScrollView:(UIView *)scrollView;


- (void)creatButtonNumber:(NSInteger)totalNumber count:(NSInteger)count imageArr:(NSArray *)imageArr textArr:(NSArray *)textArr ScrollView:(UIView *)scrollView tag:(NSInteger)tag;

@end
