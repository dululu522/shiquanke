//
//  CMCChangeTimeFormat.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-10-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCChangeTimeFormat.h"

@implementation CMCChangeTimeFormat
+ (id)conversionTimeFormat:(NSString *)timeStr alabel:(UILabel *)alabel
{

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *tempSTR = [NSString stringWithFormat:@"%@",timeStr];
     
     
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tempSTR doubleValue]];
     
//     UILabel *begin_timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 320, 20)];
     alabel.text = [formatter stringFromDate:date];
     
//     [view addSubview:alabel];

    return alabel.text;

}

@end
