//
//  FocusImageItem.m
//  shiquanke
//
//  Created by zt on 14-6-24.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "FocusImageItem.h"

@implementation FocusImageItem

+(FocusImageItem *)fromDict:(NSDictionary *) dict
{
    if (nil == dict)
        return nil;
    
    FocusImageItem *focus = [[FocusImageItem alloc]init];
    focus.imageUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]];
    focus.link = [NSString stringWithFormat:@"%@",[dict objectForKey:@"link"]];
    focus.title = [NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    focus.available = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"available"]] intValue];
    focus.displayOrder = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"displayorder"]] intValue];
    focus.ID = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] intValue];
    focus.pid = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"pid"]] intValue];
    
    return focus;
}


@end
