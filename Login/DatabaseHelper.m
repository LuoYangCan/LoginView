//
//  DatabaseHelper.m
//  Login
//
//  Created by 孤岛 on 16/9/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "DatabaseHelper.h"
@implementation DatabaseHelper
+ (FMDatabase *) openDatabase{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"myDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSLog(@"数据库打开成功");
        [db executeUpdate:@"Create Table IF NOT EXISTS User(Account,Password)"];
    }
    return db;

}
@end
