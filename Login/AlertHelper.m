//
//  AlertHelper.m
//  Login
//
//  Created by 孤岛 on 16/9/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper
+ (UIAlertController *) Alertwithtitle:(NSString *)title message:(NSString *)message actiontitle:(NSString *)actiontitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",title] message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",actiontitle] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    return alert;
}
@end
//提示 输入的账号或密码有误 确定