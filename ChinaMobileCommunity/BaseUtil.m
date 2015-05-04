
 //
//  BaseUtil.m
//
//  Created by yager on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseUtil.h"
#import "CommonCrypto/CommonDigest.h"
#import "GTMDefines.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SFHFKeychainUtils.h"

@implementation BaseUtil
+ (NSString*)returnDateFrom1970:(NSString*)str
{
    NSTimeInterval timeInterval = [str intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [[date2 description] substringWithRange:NSMakeRange(0, 16)];
}

//验证邮箱格式
+ (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




+ (BOOL)checkString:(NSString*)str hasString:(NSString*)str1
{
    NSRange range = [str rangeOfString:str1];//判断字符串是否包含
    if (range.location ==NSNotFound)//不包含
//    if (range.length >0)//包含
    {
        
        return NO;
        
    }
    else//不包含
    {
        return YES;
    }
//    return NO;
}
+ (void)testFileContent:(const char *) filename
{
    FILE *file = fopen(filename, "r");
    char word[100];
    while (fgets(word, 100, file)) {
        word[strlen(word)-1] = '\0';
        NSLog(@"%s is %zu char_long", word, strlen(word));
    }
    fclose(file);
}
+(void)toast:(NSString *) Msg{
    if ([BaseUtil isEmptyOrNull:Msg]) {
        return;
    }
    [BaseUtil toastAlertWithTitle:@"" msg:Msg];
}
+ (void)alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    [[self class] toast:msg];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:msg 
                                                   delegate:nil 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
    [alert show];

}
+(void)toastAlertWithTitle:(NSString *) title msg:(NSString *) msg
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:msg];
}
+ (BOOL)emptyLocation:(CLLocation *)location
{
    if (!location) {
        return YES;
    }
    
    CLLocationCoordinate2D coord = location.coordinate;
    if (coord.latitude == -180.0 || coord.longitude == -180.0 || coord.latitude == 0.0 || coord.longitude == 0.0){
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isEmpty:(NSString*)str
{
    if (str == nil || [str length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)notEmpty:(NSString*)str
{
    return str != nil && [str length] > 0;
}

+ (BOOL)isEmptyOrNull:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
//    if ([string isEqualToString:@"<null>"]) {
//        return YES;
//    }

    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            return YES;
        }
    }
    
    
    return NO;
}

+ (BOOL)isEmptyLoction:(NSString *)locInfo
{
    if ([BaseUtil isEmpty:locInfo]) {
        return YES;
    }
    
    if ([locInfo intValue] == 0) {
        return YES;
    }
    
    return NO;
}

+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height;
{
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor *highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor *lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer *roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:3.0f];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    //add the rounded rect layer underneath all other layers of the view
    [[view layer] insertSublayer:roundRect atIndex:0];
    
    //set the shadow on the view's layer
    [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[view layer] setShadowOffset:CGSizeMake(0, height)];
    [[view layer] setShadowOpacity:1.0];
    [[view layer] setShadowRadius:3.0];
}

+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height cornerRadius:(CGFloat)radius
{
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor *highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor *lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer *roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:radius];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    //add the rounded rect layer underneath all other layers of the view
    [[view layer] insertSublayer:roundRect atIndex:0];
    
    //set the shadow on the view's layer
    [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[view layer] setShadowOffset:CGSizeMake(0, height)];
    [[view layer] setShadowOpacity:1.0];
    [[view layer] setShadowRadius:radius];
}

+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string {
    if (nil == string) {
        return nil;
    }
    
    NSCharacterSet* validCharacters =
    [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    return [[string componentsSeparatedByCharactersInSet:[validCharacters invertedSet]]
            componentsJoinedByString:@""];
    
}
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber {
    phoneNumber = [self sanitizedPhoneNumberFromString:phoneNumber];
    
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"tel:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

//+ (void)callAndBack:(NSString *)phoneNum { 
////    NSString *phoneNum = @"10086";// 电话号码
//    
//    //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
//    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",phoneNum]; 
//    
//    //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
//    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNum]; 
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//}

+ (void)callAndBackWeb:(NSString *)phoneNum
{
//    NSString *phoneNum = @"10086";// 电话号码

    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    [[UIApplication sharedApplication] openURL:phoneURL];
    
//    UIWebView *phoneCallWebView = nil;
//    if (!phoneCallWebView) {
//        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
//        // 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
//    } 
//    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];    
}

//计算时间间隔
+ (NSString *)intervalSinceNow:(NSString *)theDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *theDate = [dateFormatter dateFromString:theDateStr];
    
    NSTimeInterval theInterval = [theDate timeIntervalSince1970];
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    
    NSString *timeString = @"";
    NSTimeInterval interval = nowInterval - theInterval;
    if (interval/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%.0f分钟前", interval/60];
    }
    if (interval/3600 > 1 && interval/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%.0f小时前", interval/3600];
    }
    if (interval/86400 > 1) {
        timeString = [NSString stringWithFormat:@"%.0f天前", interval/86400];
    }
    
    return timeString;
}
+ (NSString*)get_system_today_time
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:kCFDateFormatterMediumStyle];
    
    [formatter setTimeStyle:kCFDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd-hh-mm-ss"];
    
    
    
    NSString *string_time = [formatter stringFromDate:date];
    
    NSArray *time = [string_time componentsSeparatedByString:@"-"];
    
    
    int value_year = [[time objectAtIndex:0]intValue];
    
    int value_month = [[time objectAtIndex:1]intValue];
    
    int value_day = [[time objectAtIndex:2]intValue];
    
    int value_hour = [[time objectAtIndex:3]intValue];
    
    int value_minute = [[time objectAtIndex:4]intValue];

    int value_second = [[time objectAtIndex:5]intValue];
    
    
    [formatter setDateFormat:@"EEEE"];
    
    NSString *week_day = [formatter stringFromDate:date];
    
    
//    NSString *system_time = [[NSString alloc]initWithFormat:@"{\"year\":\"%d\",\"month\":\"%d\",\"day\":\"%d\",\"hour\":\"%d\",\"minute\":\"%d\",\"second\":\"%d\",\"week_day\":\"%@\"}",value_year,value_month,value_day,value_hour,value_minute,value_second,week_day];
    NSString *system_time = [NSString stringWithFormat:@"%d%d",value_year,value_month];
    NSLog(@"\nsystem time is %@",system_time);


    return system_time;


}

+ (NSString *)setDateTime: (NSDate*)dateValue
{
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:dateValue];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    NSString *dateString = @"";
    if (week == 1) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期日",year,month,day];
    } else if (week == 2) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期一",year,month,day];
    } else if (week == 3) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期二",year,month,day];
    } else if (week == 4) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期三",year,month,day];
    } else if (week == 5) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期四",year,month,day];
    } else if (week == 6) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期五",year,month,day];
    } else if (week == 7) {
        dateString = [NSString stringWithFormat:@"%ld年%ld月%ld日 星期六",year,month,day];
    }
    
    return dateString;
}
+ (NSString*)returnWeek:(NSDate*)datee
{
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:datee];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    if (week == 1) {
        return @"周日";
    } else if (week == 2) {
        return @"周一";
    } else if (week == 3) {
        return @"周二";
    } else if (week == 4) {
        return @"周三";
    } else if (week == 5) {
        return @"周四";
    } else if (week == 6) {
        return @"周五";
    } else if (week == 7) {
        return @"周六";
    }
    return nil;
}


static NSInteger __networkActivityCount = 0;

+ (void)startNetworkActivity
{
    __networkActivityCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)stopNetworkActivity
{
    __networkActivityCount--;
    if (__networkActivityCount == 0)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+(BOOL)isGSIM
{
    AFNetworkReachabilityManager *reachablity = [AFNetworkReachabilityManager sharedManager];
    if (reachablity.isReachableViaWWAN) {

//        [BaseUtil  toastAlertWithTitle:@"提示" msg:@"您在使用手机流量"];
        return YES;
    }
    return NO;//使用WiFi
}

+ (BOOL)post:(NSDictionary *)params urlString:(NSString*)urlstr success:(void (^)(AFHTTPRequestOperation *, id))success faiure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];

    [manger POST:urlstr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"======= %@",manger.baseURL);
        
        success(operation,responseObject);
        NSString * resCode = [responseObject valueForKey:@"resCode"];
        if ([resCode isEqualToString:@"1000"]) {
            resCode = [responseObject valueForKey:@"resMessage"];
            NSLog(@"1000 信息==>>>%@",resCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    return YES;
}

+(BOOL)post:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *, id))success faiure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
//    [BaseUtil isGSIM];
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    manger.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manger POST:API_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(operation,responseObject);
//        NSString * resCode = [responseObject valueForKey:@"resCode"];
//        if ([resCode isEqualToString:@"1000"]) {
//            resCode = [responseObject valueForKey:@"resMessage"];
//            NSLog(@"1000 信息==>>>%@",resCode);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(operation,error);
//    }];
    return YES;
}

+(BOOL)get:(NSString *)apiurl success:( void(^)(AFHTTPRequestOperation *operation, id jsonObject) ) success faiure:( void(^)(AFHTTPRequestOperation *operation, NSError *error) ) failure
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manger POST:apiurl parameters:[NSDictionary dictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSString * resCode = [responseObject valueForKey:@"resCode"];
        if ([resCode isEqualToString:@"1000"]) {
            resCode = [responseObject valueForKey:@"resMessage"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];

    return YES;
}

static BaseUtil* baseutil = nil;
+(BOOL)UMShareOnView:(UIViewController*)vc Text:(NSString*)text image:(UIImage*)image
{
//    if (!baseutil) {
//        baseutil = [[BaseUtil alloc]init];
//    }
//    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
//        [UMSocialSnsService presentSnsIconSheetView:vc
//                                             appKey:UMENG_APPKEY_iPhone
//                                          shareText:text
//                                         shareImage:image
//                                    shareToSnsNames:@[UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToTencent,UMShareToQzone] delegate:baseutil];
//    } else {
//        [UMSocialSnsService presentSnsIconSheetView:vc
//                                             appKey:UMENG_APPKEY_iPad
//                                          shareText:text
//                                         shareImage:image
//                                    shareToSnsNames:@[UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToTencent,UMShareToQzone] delegate:baseutil];
//    }
    return YES;
}

//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    if (response.responseCode == UMSResponseCodeSuccess) {
//        NSLog(@"分享成功");
//        NSDictionary * params = @{@"action": @"taskExecute",
//                                  @"params":@{@"userId":[ApiClient current].system.sessionId,
//                                              @"taskType":@"share"}};
//        [BaseUtil post:params success:^(AFHTTPRequestOperation *operation, id jsonObject) {
//            if ([[jsonObject objectForKey:@"resCode"] isEqualToString:@"200"]) {
//                NSLog(@"分享成功数据已发送给服务器");
//            }
//        } faiure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        }];
//    }
//}

+(UIBarButtonItem *)setNavigCustomBarItem:(NSString *)customImageName controller:(UIViewController *)vc position:(UIBarButtonItemPostion)position selector:(SEL) selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_iPad) {
        [button setBackgroundImage:[UIImage imageNamed: customImageName] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 33);
    }else{
        
    }
    [button addTarget:vc action:selector forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    return bar;
}
+(void)showingLogin
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOGIN_EVENT object:nil];
}


+(NSString *)md5:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
+(NSString *)md5SubString:(NSString *)inPutText
{
    return inPutText;
    NSString* md5 = [BaseUtil md5:inPutText];
    return [md5 substringWithRange:NSMakeRange(8, 16)];
}


+ (void)storeEmailInKeychain:(NSString*)email
{
    [SFHFKeychainUtils storeUsername:@"My_email" andPassword:email
                      forServiceName:@"ServiceName_wanglu" updateExisting:YES error:nil];

}
+ (void)storePasswordInKeychain:(NSString*)psd
{
    [SFHFKeychainUtils storeUsername:@"My_password" andPassword:psd
                      forServiceName:@"ServiceName_wanglu" updateExisting:YES error:nil];

}
+ (NSString*)getEmailFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:@"My_email" andServiceName:@"ServiceName_wanglu" error:nil];
    return key;
}
+ (NSString*)getPasswordFromKeychain
{
    return [SFHFKeychainUtils getPasswordForUsername:@"My_password" andServiceName:@"ServiceName_wanglu" error:nil];
}

//用post进行数据提交

+ (NSDictionary *) postString:(NSString *)postStr postUrlString:(NSString *)postUrlString
{
    
    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //定义NSMutableURLRequest
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    //    //设置提交目的url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    //设置提交目的url
    [request setValue:[NSString stringWithFormat:@"1.0|%@|%.0f",[CMCUserManager shareManager].token,[[NSDate date] timeIntervalSince1970]] forHTTPHeaderField:@"user-agent"];
    NSString *urlString = postUrlString;
    [request setURL:[NSURL URLWithString:urlString]];
    
    //设置提交方式为 POST
    [request setHTTPMethod:@"POST"];
    //设置需要post提交的内容
    [request setHTTPBody:postData];
    //定义
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型。
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //    NSLog(@"responseData ==== %@",responseData);
    //将NSData类型的返回值转换成NSString类型
    
    
    
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    return tempDic;
    
}

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}
+(double)distanceBetweenOrderBy:(double)lat2 :(double)lng2
{
    double dd = M_PI/180;
    double x1=[CMCUserManager shareManager].latitude*dd,x2=lat2*dd;
    double y1=[CMCUserManager shareManager].longitude*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m 
    return   distance;
}
//+ (void)isPointInLine($point,$linePoint1,$linePoint2)
+ (BOOL)isPointInPolygonPoint:(NSString *)location poly:(NSString *)poly
{
    NSArray *coorArr = [location componentsSeparatedByString:@","];
//    (float)longitude latitude:(float)latitude
    float latitude = [[coorArr objectAtIndex:1] floatValue];
    float longitude = [[coorArr objectAtIndex:0] floatValue];
    NSLog(@"经度 %f  纬度%f",latitude, longitude);
    
    // latitude 纬度, longitude 经度
    NSArray *array = [poly componentsSeparatedByString:@","];
    NSMutableArray *allArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count/2; i++) {
        NSMutableArray *addArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < 2; j++) {
            
            [addArr addObject:[array objectAtIndex:i*2+j]];
            
        }
        NSLog(@"addArr === %@",addArr);
        [allArr addObject:addArr];
//        i = i+2;
    }
    NSLog(@"allArr ==== %@",allArr);

    for (int i = 0; i < allArr.count - 1; i++) {
        float longitude1 = [[[allArr objectAtIndex:i] objectAtIndex:0] floatValue];
        float longitude2 = [[[allArr objectAtIndex:i+1] objectAtIndex:0] floatValue];
        float latitude1 = [[[allArr objectAtIndex:i] objectAtIndex:1] floatValue];
        float latitude2 = [[[allArr objectAtIndex:i+1] objectAtIndex:1] floatValue];
        
        float maxlongitude = longitude1 > longitude2 ? longitude1 : longitude2;
        float minlongitude = longitude1 < longitude2 ? longitude1 : longitude2;
        BOOL flag = false;
        if (longitude < maxlongitude && longitude > minlongitude) {
            if (latitude <= (latitude1 +(latitude2 - latitude1)*(longitude - longitude1)/(longitude2 - longitude1))) {
                flag = YES;
                return YES;
            }
        }

    }


    return NO;

}
//封装的sig 按字母顺序排列
+ (NSString *)getSigWithArray:(NSDictionary *)dic
{
    NSArray *keyArr = dic.allKeys;
    NSArray *kArr = [keyArr sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < kArr.count; i++) {
        [str appendString:[NSString stringWithFormat:@"%@=%@",kArr[i],[dic objectForKey:kArr[i]]]];
        
    }
    [str appendString:k_secretkey];
    return str;
}
//按照系统生成随机key访问的图片商品图片
+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image number:(NSString *)number
{
    if ((default_image.length == 0) | [default_image isEqualToString:@"<null>"]) {
        return nil;
    }
    NSArray *arr =[default_image componentsSeparatedByString:@"|"];
    
    NSString *timeStr = [arr objectAtIndex:1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMM"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    NSString *dataStr = [formatter stringFromDate:date];
    
    NSString *string2 = [arr objectAtIndex:2];
    
     NSString *allStr = [NSString stringWithFormat:@"%@11/%@/%@/%@_%@_%@.jpg",[CMCUserManager shareManager].file_url,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString],number];
    NSLog(@"S商品  %@",allStr);
    NSURL *url = [NSURL URLWithString:allStr];
    return url;

}
+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image type:(NSString *)type number:(NSString *)number
{
    NSLog(@"qqqiie  %@",default_image);
    if ([default_image isKindOfClass:[NSNull class] ]) {
        return nil;
    }
    if ((default_image.length == 0) | [default_image isEqualToString:@"<null>"] | [default_image isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSLog(@"default_image  %@",default_image);
//    NSLog(@"default_image  %@",default_image);
    NSArray *arr =[default_image componentsSeparatedByString:@"|"];
//    NSLog(@"arr  %@",arr);
    if ([[arr objectAtIndex:1] length]) {
        NSString *timeStr = [arr objectAtIndex:1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyyMM"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
        NSString *dataStr = [formatter stringFromDate:date];
        
        NSString *string2 = [arr objectAtIndex:2];
        
        NSString *allStr;
        if ([number isEqualToString:@""]) {
            allStr = [NSString stringWithFormat:@"%@%@/%@/%@/%@_%@.jpg",[CMCUserManager shareManager].file_url,arr.firstObject,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString]];
        }else{
            allStr = [NSString stringWithFormat:@"%@%@/%@/%@/%@_%@_%@.jpg",[CMCUserManager shareManager].file_url,arr.firstObject,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString],number];
        }
        
        NSURL *url = [NSURL URLWithString:allStr];
        return url;
    }
    
    return nil;
}

+ (void)reWritePayForGoodsPartnerID:(NSString *)partnerID sellerID:(NSString *)sellerID price:(NSString *)price orderNO:(NSString *)orderNO notifyURL:(NSString *)notifyURL  subject:(NSString *)subject privateKey:(NSString *)privateKey
{
    Order *order = [[Order alloc] init];
    order.partner = partnerID;
    order.seller = sellerID;
    order.tradeNO = orderNO;//订单id
    order.productName = subject; //商品标题
    order.productDescription = subject;//商品描述
    order.amount = price;//商品价格
    NSLog(@"amount ======%@",order.amount);
    order.notifyURL = notifyURL;//回调的url
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    NSString *appScheme = @"com.OneOneFourUser";
    
    NSString *orderSpec = [order description];
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    
    NSString *signedString = [signer signString:orderSpec];
    
    NSString *orderString = nil;
    if (orderString == nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
    }
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"=======%@",resultDic);
        NSString *resultStatusStr = [resultDic objectForKey:@"resultStatus"];
        NSString* msg = @"";
        if ([resultStatusStr isEqualToString:@"6001"]) {
            msg=@"您中途取消支付";
        }
        if ([resultStatusStr isEqualToString:@"9000"]) {
            msg=@"支付宝支付成功";
        }
        if([resultStatusStr isEqualToString:@"4000"]){
            msg = @"支付宝异常,请尝试重新购买";
        }
        [BaseUtil alertWithTitle:@"提示" msg:msg];
        
    }];
}



+ (void)PaymentForGoodsTradeNO:(NSString *)tradeNO productName:(NSString *)productName amount:(NSString *)price
{
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = tradeNO;//订单id
    NSLog(@"*********%@",tradeNO);
    order.productName = productName; //商品标题
    order.productDescription = @"购买的商品";//商品描述
    order.amount = price;//商品价格
    NSLog(@"amount ======%@",order.amount);
    order.notifyURL = kAPI_NotifyURL;//回调的url
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    NSString *appScheme = @"com.OneOneFourUser";
    
    NSString *orderSpec = [order description];
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    
    NSString *signedString = [signer signString:orderSpec];
    
    NSString *orderString = nil;
    if (orderString == nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
    }
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"=======%@",resultDic);
        NSString *resultStatusStr = [resultDic objectForKey:@"resultStatus"];
        NSString* msg = @"";
        if ([resultStatusStr isEqualToString:@"6001"]) {
            msg=@"您中途取消支付";
        }
        if ([resultStatusStr isEqualToString:@"9000"]) {
            msg=@"支付宝支付成功";
        }
        if([resultStatusStr isEqualToString:@"4000"]){
            msg = @"支付宝异常,请尝试重新购买";
        }
        [BaseUtil alertWithTitle:@"提示" msg:msg];
        
    }];
}
+ (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
+ (NSString *)becomeNormalWithString:(NSString *)timeStr{
    NSTimeInterval time=[timeStr doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
//最新的post上传
+ (void)post:(NSString *)urlStr postBody:(NSDictionary *)postDic success:(void (^)(id))success ailure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@",APPVersion,KAPI_NewChannel,kAPI_timestamp] forHTTPHeaderField:@"User-Agent"];
    
    [manager POST:urlStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *data = [NSData dataWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        id tmpDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(tmpDic);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        
    }];
    
}
//翼支付的post请求上传
+ (void)bestPayPost:(NSString *)urlStr postBody:(NSDictionary *)postDic success:(void (^)(id))success ailure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:urlStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *data = [NSData dataWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        id tmpDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(tmpDic);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        
    }];
    
}
- (void)resultDicMessage:(NSDictionary *)dic
{
    switch ([[dic objectForKey:@"info"] intValue]) {
        case 0:
        {
            [BaseUtil toast:@"请求成功"];
        
        
        }
              break;
            case 1:
        {
        
            [BaseUtil toast:@"请求失败"];
        
        
        }
              break;
            case 3:
        {
        
            [BaseUtil toast:@"你还没登陆"];
        
        }
            break;
        case 8:
        {
            
            [BaseUtil toast:@"信息填写不完整"];
            
        }
            break;
        default:
            break;
    }




}
//设置中划线
+ (void)setCenterLineView:(UILabel *)label
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],NSStrikethroughStyleAttributeName, nil];
    label.font = [UIFont fontWithName:nil size:12];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text attributes:dic];
    label.attributedText = str;
}
//get数据请求
+ (void)get:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *data = [NSData dataWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        id response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [operation start];
}



+ (void)getMethod:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@",APPVersion,KAPI_NewChannel,kAPI_timestamp] forHTTPHeaderField:@"User-Agent"];
    NSLog(@"=**********===%@",manager.requestSerializer.HTTPRequestHeaders);
    [manager GET:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    
}


/**
 *  最最新post
 *
 *  @param urlStr  url
 *  @param postDic 参数
 *  @param success 成功之后
 *  @param failure 失败之后
 */
+ (void)postMethod:(NSString *)urlStr postBody:(NSDictionary *)postDic success:(void (^)(id))success ailure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@",APPVersion,KAPI_NewChannel,kAPI_timestamp] forHTTPHeaderField:@"User-Agent"];
    NSLog(@"=======%@",manager.requestSerializer.HTTPRequestHeaders);
    //    NSString *urlString = [NSString stringWithFormat:@"%@%@",[CMCUserManager shareManager].loc_entry,urlStr];
    
    [manager POST:urlStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *data = [NSData dataWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        id tmpDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"======tmpDic = %@",tmpDic);
        success(tmpDic);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---%@",operation.responseString);
        failure(error);
        
    }];
    
    
}

//通过传入type 类型  和修改的value值获取请求的URL
+ (NSString *)getRequestUrlByType:(NSString *)type AndValue:(NSString *)value
{
    NSString *timestamp = kAPI_timestamp;
    if ([CMCUserManager shareManager].token) {
        NSDictionary *dic =@{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"token":[CMCUserManager shareManager].token,@"type":type,@"value":value,@"timestamp":timestamp};
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSString *requestUrl = KAPI_getModelUserinfo(timestamp, [BaseUtil md5:sig], [CMCUserManager shareManager].token, type, value);
        return requestUrl;

    }
    return nil;
}


+ (CGRect)returnHeightWithContent:(NSString *)content
                         WithFont:(CGFloat)font
                            width:(CGFloat)width
                           height:(CGFloat)height{
    
    CGSize size = CGSizeMake(width, height);
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName] context:nil];
    return rect;
    
}




//根据服务ID找到服务对应得名字
+ (NSString *)returnCategoryWithService_id:(NSString *)service_id{
    NSString *process = [NSString string];
    for (NSDictionary *dic in kAPI_Service) {
        NSString *serviceId = [dic objectForKey:@"id"];
        if ([serviceId isEqualToString:service_id]) {
            process = [dic objectForKey:@"name"];
        }
    }
    return process;
}

//根据服务ID找到服务对应得分类
+ (NSString *)returnProcessWithService_id:(NSString *)service_id{
    NSString *process = [NSString string];
    for (NSDictionary *dic in kAPI_Service) {
        NSString *serviceId = [dic objectForKey:@"id"];
        if ([serviceId isEqualToString:service_id]) {
            process = [dic objectForKey:@"process"];
        }
    }
    return process;
}



//根据服务ID和状态得到状态的名字
+ (NSString *)returnCategoryWithService_id:(NSString *)service_id WithState:(NSString *)state{
    NSString *stateStr = [NSString string];
    //根据service_id来找到对应的代号
    NSString *process = [NSString string];
    for (NSDictionary *dic in kAPI_Service) {
        NSString *serviceId = [dic objectForKey:@"id"];
        if ([serviceId isEqualToString:service_id]) {
            process = [dic objectForKey:@"process"];
        }
    }
    //根据代号找到对应的状态
    NSArray *stateArr = [NSArray array];
    NSDictionary *dic = k_order;
    NSArray *keyArr = dic.allKeys;
    for (NSString *str in keyArr) {
        if ([str isEqualToString:process]) {
            stateArr = [k_order objectForKey:str];
        }
    }
    //根据state找到对应的状态信息
    for (NSDictionary *dic in stateArr) {
        if ([state intValue] ==[[dic objectForKey:@"state"] intValue]) {
            stateStr = [dic objectForKey:@"text"];
        }
        
    }
    return stateStr;
}

/** 绘制图片(将图片按照原比例的三分之一压缩) number 为你需要压缩的比例 */
+ (UIImage *)scaleToSize:(UIImage *)img WithNumber:(int)number
{
    NSLog(@"img.size === %@", NSStringFromCGSize(img.size));
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize size = CGSizeMake(img.size.width/number, img.size.height/number);
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    NSLog(@"图片绘制结束!");
    return scaledImage;
}
//根据给的物业地址找出对应的值
+ (NSString *)getPropertyAddressValue:(NSString *)value
{

 return  [k_propertyAddress  objectForKey:value];



    return nil;
}


+ (void)pushToLoginVCWithRespondObj:(NSDictionary *)respond withViewController:(UIViewController *)controll{
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"3"]) {
        CMCLoginViewController *loginVC = [[CMCLoginViewController alloc]init];
        [controll.navigationController pushViewController:loginVC animated:YES];
    }
}

+ (void)errorMesssage:(NSDictionary *)respond
{
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"0"]) {
        //[BaseUtil toast:@"操作成功"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"1"]) {
        [BaseUtil toast:@"操作失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2"]) {
        [BaseUtil toast:@"非法的请求"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"3"]) {
        [BaseUtil toast:@"请登录后再访问"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"4"]) {
        [BaseUtil toast:@"身份验证失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"5"]) {
        [BaseUtil toast:@"没有找到数据"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"6"]) {
        [BaseUtil toast:@"数量不够"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"7"]) {
        [BaseUtil toast:@"请填写完整表单再提交"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"8"]) {
        [BaseUtil toast:@"参数不合法"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"9"]) {
        [BaseUtil toast:@"配置错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"10"]) {
        [BaseUtil toast:@"逻辑错误，技术人员已经在处理"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"11"]) {
        [BaseUtil toast:@"已过期"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"12"]) {
        [BaseUtil toast:@""];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"13"]) {
        [BaseUtil toast:@"渠道错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"14"]) {
        [BaseUtil toast:@"网络连接失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"15"]) {
        [BaseUtil toast:@"网络连接失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"16"]) {
        [BaseUtil toast:@"定位失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"1006"]) {
        [BaseUtil toast:@"渠道用户无效"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2001"]) {
        [BaseUtil toast:@"用户不存在"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2002"]) {
        [BaseUtil toast:@"手机号已存在"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2003"]) {
        [BaseUtil toast:@"电子邮件不存在"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2004"]) {
        [BaseUtil toast:@"电子邮件不存在"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2005"]) {
        [BaseUtil toast:@"密码不允许为空"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2006"]) {
        [BaseUtil toast:@"密码错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2007"]) {
        [BaseUtil toast:@"登录失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2008"]) {
        [BaseUtil toast:@"登录会话失败"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2009"]) {
        [BaseUtil toast:@"手机系统不匹配"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2010"]) {
        [BaseUtil toast:@"设备号获取错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2011"]) {
        [BaseUtil toast:@"短信验证码错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2012"]) {
        [BaseUtil toast:@"短信发送错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2013"]) {
        [BaseUtil toast:@"短信发送超时"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2014"]) {
        [BaseUtil toast:@"顺序规则错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2015"]) {
        [BaseUtil toast:@"订单金额错误"];
    }
    if ([[[[respond objectForKey:@"info"] objectForKey:@"result"]stringValue] isEqualToString:@"2016"]) {
        [BaseUtil toast:@"商品状态错误"];
    }
    
    
    
}

@end