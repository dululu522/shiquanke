//
//  bestpay.h
//  bestpay
//
//  Created by Jamie on 14-9-11.
//  Copyright (c) 2014年 Jamie. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum LaunchType
{
    launchTypePay,          //支付跳转
    launchTypeRecharge      //充值跳转
} LaunchType;


@interface bestpay : NSObject

/*
 *  支付&充值混合接口

 *  SELF Version:2.0.0
 *  需求翼支付客户端V2.4.0以上
 
 *  @param type     跳转类型（LaunchType）：支付or充值
 *  @param order    符合文档规范的订单参数信息
 *  @param scheme   商户应用程序scheme
 *  @param seletor  接收结果处理函数，暂时传nil，后续扩展使用
 *  @param target   接收结果target，暂时传nil，后续扩展使用
 */


+ (BOOL)launchWithType:(LaunchType)type
                 order:(NSString *)order
                scheme:(NSString *)scheme
               seletor:(SEL)seletor
                target:(id)target;


@end
