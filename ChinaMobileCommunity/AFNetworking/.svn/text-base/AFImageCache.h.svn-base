//
//  AFImageCache.h
//  bplup
//
//  Created by zhang on 14-2-24.
//  Copyright (c) 2014年 ssports.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFImageCache : NSCache
+ (AFImageCache *)af_sharedImageCache;

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;

@end
