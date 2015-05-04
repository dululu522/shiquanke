//
//  FocusImageView.m
//  shiquanke
//
//  Created by zt on 14-6-24.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "FocusImageView.h"

@implementation FocusImageView
-(id)initWithItem:(FocusImageItem*)im
{
    self = [super init];
    if (self) {
        // Initialization code
        self.item = im;
        self.frame = CGRectMake(0, 0, 320, 180);
      
        [self setImageWithURL:[NSURL URLWithString:kAPI_GetImage(im.imageUrl)] placeholderImage:[UIImage imageNamed:@"smallIcon"]];
//        NSLog(@"图片地址   %@",kAPI_GetImage(im.imageUrl));
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;

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
