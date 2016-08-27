//
//  CheckHelper.m
//  Login
//
//  Created by 孤岛 on 16/8/26.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "CheckHelper.h"

@implementation CheckHelper
#pragma mark - 判断是否没有输入正确信息
- (BOOL) check{
    if (self.account.text.length > 0 && self.Password.text.length >= 6 ) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 判断是否已有账号
- (BOOL) checkaccount{
    BOOL FLag = NO;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"myDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSLog(@"数据库打开成功");
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM User"];
    while ([rs next]) {
        NSString * Account = [rs stringForColumn:@"Account"];
        if ([self.account.text isEqualToString:Account]) {
            FLag = YES; break;
        }
        
    }
    return FLag;
    
}
@end
