//
//  ATNetworkingHelper.h
//  Login
//
//  Created by 孤岛 on 16/8/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ATNetworkingHelper : NSObject
+ (AFHTTPSessionManager *) SharedHttpManager;
@end
