//
//  AlertHelper.h
//  Login
//
//  Created by 孤岛 on 16/9/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertHelper : NSObject
+ (UIAlertController *) Alertwithtitle:(NSString *)title message:(NSString *)message actiontitle:(NSString *)actiontitle ;
@end
