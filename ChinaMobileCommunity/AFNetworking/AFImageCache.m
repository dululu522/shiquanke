//
//  AFImageCache.m
//  bplup
//
//  Created by zhang on 14-2-24.
//  Copyright (c) 2014年 ssports.com. All rights reserved.
//

#import "AFImageCache.h"

@implementation AFImageCache

+ (AFImageCache *)af_sharedImageCache {
    static AFImageCache *_af_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_imageCache = [[AFImageCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [_af_imageCache removeAllObjects];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [_af_imageCache removeAllObjects];
        }];

        
    });
    
    return _af_imageCache;
}
#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}


- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
	return [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
    }
}


@end
