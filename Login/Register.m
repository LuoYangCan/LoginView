//
//  Register.m
//  Login
//
//  Created by 孤岛 on 16/8/5.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "Register.h"
#import "FMDB.h"
#import "MessageLogin.h"
@interface Register ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *CheckPassword;
@property (weak, nonatomic) IBOutlet UIButton *FinishButton;
@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.Password setSecureTextEntry:YES];
    [self.CheckPassword setSecureTextEntry:YES];
    self.account.placeholder = @"请输入账号";
    self.Password.placeholder = @"请输入六位以上的密码";
    self.CheckPassword.placeholder = @"请再次输入密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)FinishResign:(id)sender {
    if ([self checkaccount]&&[self check]) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"此账号已被注册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:action1];
        [self presentViewController:alert1 animated:YES completion:^{
        }];
    }
       else if ([self.Password.text isEqualToString:self.CheckPassword.text]&&[self check]) {
           
            [self performSegueWithIdentifier:@"back" sender:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    
}
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
#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"back"]) {
        MessageLogin *messageLogin = [segue destinationViewController];
        messageLogin.Account1 = self.account.text;
        messageLogin.Password1 = self.Password.text;
    }
}
//#pragma mark - PassValueDelegate
//- (void)UsersAccount:(NSString *)Account{
//    Account = self.account.text;
//}
//- (void)UsersPassword:(NSString *)Password{
//    Password = self.account.text;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
