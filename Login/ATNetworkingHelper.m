//
//  ATNetworkingHelper.m
//  Login
//
//  Created by 孤岛 on 16/8/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "ATNetworkingHelper.h"

static  NSString *const shortMessage = @"http://route.showapi.com/";
@implementation ATNetworkingHelper
+ (AFHTTPSessionManager *) SharedHttpManager{
    static AFHTTPSessionManager * _sharedClient = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        _sharedClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:shortMessage]];
    });
    return _sharedClient;
}

@end
