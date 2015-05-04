//
//  CMCBestPayModel.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-23.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCBestPayModel.h"
#import "MD5.h"


@interface CMCBestPayModel ()
@property (nonatomic, strong) NSString * timeStr;
@property (nonatomic, strong) NSString *orderID; //订单id


@property (nonatomic, strong)   NSMutableData           *receiveData;
@property (nonatomic, copy)   NSString                *encodeOrderStr;
@property (nonatomic, copy) NSString *price;
@end

@implementation CMCBestPayModel
- (void)bestWithOrder_id:(NSString *)order_id money:(NSString *)money
{
    
    self.orderID = order_id;
    self.price = money;
    
    _timeStr = [self getOrderTime];
    self.receiveData = [NSMutableData data];
    //    NSURL *url = [NSURL URLWithString:@"http://wapchargewg.bestpay.com.cn/order.action"];
    NSURL *url = [NSURL URLWithString:@"https://webpaywg.bestpay.com.cn/order.action"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSString* signOrigStr = [NSString stringWithFormat:@"MERCHANTID=%@&ORDERSEQ=%@&ORDERREQTRANSEQ=%@&ORDERREQTIME=%@&KEY=%@", MERCHANTID, order_id, [self getOrderTrSeq],_timeStr, KEY];
    NSLog(@"下单签名源串 singOrigStr = %@", signOrigStr);
    NSString *signMac = [self md5:signOrigStr];
    
    NSString *str = [NSString stringWithFormat:@"MERCHANTID=%@&SUBMERCHANTID=%@&ORDERSEQ=%@&ORDERAMT=%@&ORDERREQTRANSEQ=%@&ORDERREQTIME=%@&MAC=%@&TRANSCODE=%@",
                     MERCHANTID,
                     @"",
                     order_id,
                     money,
                     [self getOrderTrSeq],
                     _timeStr,
                     signMac,
                     @"01"];
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    
    
    
}
//获取当前时间
- (NSString *)getOrderTime
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *  locationString = [dateformatter stringFromDate:senddate];
    return locationString;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    //    self.receiveData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    NSLog(@"aaaaaaaaaaaaaaaaa");
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    if([[receiveStr substringToIndex:2] isEqualToString:@"00"]) {
        //获取订单信息
        NSString *orderStr = [self orderInfos];
        
        
        NSLog(@"跳转支付页面带入信息：%@", orderStr);
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *urls = [dic objectForKey:@"CFBundleURLTypes"];
        
        
        
        //跳转至支付页面
        [bestpay launchWithType:launchTypePay
                          order:orderStr
                         scheme:[[[urls firstObject] objectForKey:@"CFBundleURLSchemes"] firstObject]
                        seletor:nil
                         target:self];
        
    }
    else {
        
        
        NSLog(@"下单失败：%@", receiveStr);
        
        [self showAlert:@"下单失败，请稍后再试"];
    }
    
    //    [self.loadingView stopAnimating];
}
#pragma mark -
#pragma mark  Private Methods
-(NSString *)orderInfos
{
    
    NSMutableString * orderDes = [NSMutableString string];
    //商户号
    [orderDes appendFormat:@"MERCHANTID=%@", MERCHANTID];
    //子商户号
    [orderDes appendFormat:@"&SUBMERCHANTID=%@", @""];
    //商户密码 由翼支付网关平台统一分配给各接入商户
    [orderDes appendFormat:@"&MERCHANTPWD=%@", PSWD];
    
    //订单号
    [orderDes appendFormat:@"&ORDERSEQ=%@", self.orderID];
    //订单请求流水号，唯一
    [orderDes appendFormat:@"&ORDERREQTRNSEQ=%@",[self getOrderTrSeq]];
    //金额限制：1-30元整数 单位为元 如2.00
    //请求扣减积分值
    NSString *money = self.price;
    [orderDes appendFormat:@"&ORDERAMOUNT=%@", [NSString stringWithFormat:@"%.2f",[money floatValue]]];
    NSLog(@"邱特  %@",[NSString stringWithFormat:@"%.2f",[money floatValue]]);
    //订单请求时间 格式：yyyyMMddHHmmss
    //    [orderDes appendFormat:@"&ORDERTIME=%d", [kAPI_timestamp intValue]+60 * 1000 * 60 * 24 ];
    [orderDes appendFormat:@"&ORDERTIME=%@", _timeStr];
    
    //产品描述 optional
    [orderDes appendFormat:@"&PRODUCTDESC=%@", @"maidan"];
    //附加信息 optional
    [orderDes appendFormat:@"&ATTACH=%@", @""];
    //支付结果通知地址 翼支付网关平台将支付结果通知到该地址，详见支付结果通知接口
    [orderDes appendFormat:@"&BACKMERCHANTURL=%@", kAPI_WingPayNotifyURL];
    //产品金额
    [orderDes appendFormat:@"&PRODUCTAMOUNT=%@", [NSString stringWithFormat:@"%.2f",[money floatValue]]];
    //附加金额 单位元，小数点后2位
    [orderDes appendFormat:@"&ATTACHAMOUNT=%@",@"0.00"];
    //币种, 默认RMB
    [orderDes appendFormat:@"&CURTYPE=%@", @"RMB"];
    
    //业务标识 optional
    [orderDes appendFormat:@"&PRODUCTID=%@", @"01"];
    //分账描述 optional
    [orderDes appendFormat:@"&DIVDETAILS=%@", @""];
    //订单有效截至日期
    [orderDes appendFormat:@"&ORDERVALIDITYTIME=%@", @""];
    //客户标识 在商户系统的登录名 optional
    [orderDes appendFormat:@"&CUSTOMERID=%@", @"30414820"];
    //用户IP 主要作为风控参数 optional
    [orderDes appendFormat:@"&USERIP=%@", @"58.53.199.98"];
    
    
    self.encodeOrderStr = [NSString stringWithFormat:@"MERCHANTID=%@&ORDERSEQ=%@&ORDERREQTRNSEQ=%@&ORDERTIME=%@&KEY=%@", MERCHANTID, self.orderID, [self getOrderTrSeq], _timeStr, KEY];
    NSString *signStr = [MD5 signString:self.encodeOrderStr];
    
    NSLog(@"跳转支付时签名信息源串：%@",self.encodeOrderStr);
    
    //MAC验证信息 采用MD5加密
    [orderDes appendFormat:@"&MAC=%@", signStr];
    //资金源控制标识
    [orderDes appendFormat:@"&BUSITYPE=%@", @"01"];
    
    return orderDes;
    
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败%@",[error localizedDescription]);
    //    [self.loadingView stopAnimating];
//    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}


//MD5编码处理
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//获取当前时间戳
- (NSString *)getOrderTrSeq
{
    NSDate *  senddate=[NSDate date];
    NSString *  locationString = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    //    locationString = [locationString stringByAppendingString:@"00001"];
    return locationString;
}

@end
