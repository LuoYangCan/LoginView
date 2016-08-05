//
//  FmdbHelper.m
//  Login
//
//  Created by 孤岛 on 16/8/3.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "FmdbHelper.h"
#import "ViewController.h"
@implementation FmdbHelper

//打开数据库
+ (void) openDatabase{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"myDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSLog(@"数据库打开成功");
    }
//    [db executeUpdate:@"Create Table User(Account,Password)"];
}
@end
