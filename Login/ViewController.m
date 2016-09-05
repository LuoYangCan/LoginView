//
//  ViewController.m
//  Login
//
//  Created by 孤岛 on 16/7/25.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISwitch    *Check;
@property (weak, nonatomic) IBOutlet UITextField *Account;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (strong,nonatomic)         NSString    *RAccount;
@property (strong,nonatomic)         NSString    *RPassword;
@property (strong,nonatomic) NSMutableDictionary *dic;
@property (assign,nonatomic) BOOL                 sw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PassWord.delegate     = self;
    self.Account.delegate      = self;
    self.PassWord.placeholder  = @"请输入密码";
    self.Account.placeholder   = @"请输入账号";
    self.sw = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
    self.Check.on              = self.sw;
    if (self.Check.on) {
        [self loadfromFile];
    };
    [self.PassWord setSecureTextEntry:YES];//隐藏输入字符
    // Do any additional setup after loading the view, typically from a nib.
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didCheck:(UISwitch *)sender {
    //记住switch的状态
    [[NSUserDefaults standardUserDefaults] setBool:self.Check.on forKey:@"state"];
    //记住密码开关
    //    if ([self.Check isOn]) {
    //        self.RAccount = self.Account.text;
    //        self.RPassword = self.PassWord.text;
    //        [self saveFile];
    //    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.PassWord resignFirstResponder];
    [self.Account  resignFirstResponder];
}
//登陆
- (IBAction)Login:(UIButton *)sender {
    [self Login];
}

//#pragma mark - UITextFieldDelegate实现
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
#pragma mark - 储存文件
//保存文件实现记住密码
- (void) saveFile{
    //    NSString *file = @"UserInformation";
    //    NSString *path = [[NSBundle mainBundle]pathForResource:file ofType:@"plist"];
    //    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentDirectory = [paths objectAtIndex:0];
    NSString *DocumentPath = [DocumentDirectory stringByAppendingPathComponent:@"UserInformation.plist"];
    NSFileManager *fm = [[NSFileManager alloc]init];
    [fm createFileAtPath:DocumentPath contents:nil attributes:nil];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString *Account = self.RAccount;
    NSString *Password = self.RPassword;
    [dic setValue:Account forKey:@"Account"];
    [dic setValue:Password forKey:@"Password"];
    
    NSLog(@"储存文件时候的字典%@",dic);
    [dic writeToFile:DocumentPath atomically:YES];
}

#pragma mark -读取文件
//读取文件实现记住密码
- (void) loadfromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentDirectory = [paths objectAtIndex:0];
    NSString *DocumentPath = [DocumentDirectory stringByAppendingPathComponent:@"UserInformation.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:DocumentPath];
    NSLog(@"读取后的字典%@",dic);
    self.Account.text = [dic objectForKey:@"Account"];
    self.PassWord.text = [dic objectForKey:@"Password"];
}
#pragma mark -done事件
- (IBAction)Done:(id)sender {
    [self Login];
}
#pragma mark - 换行
- (IBAction)Change:(id)sender {
    [self.PassWord becomeFirstResponder];
}
#pragma mark -Login
-(void)Login{
    FMDatabase *db = [DatabaseHelper openDatabase];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM User"];
    //分开正确登陆和输入错误
    BOOL Flag = NO;
    while ([rs next]) {
        NSString * Account = [rs stringForColumn:@"Account"];
        NSString * Password = [rs stringForColumn:@"Password"];
        if ([self.Account.text isEqualToString:Account]&&[self.PassWord.text isEqualToString:Password]) {
            NSLog(@"登陆成功");
            if (self.Check.on) {
                self.RAccount = self.Account.text;
                self.RPassword = self.PassWord.text;
                [self saveFile];
                
            }
            Flag = YES;
            break;
        }
        
    }if (Flag) {
        [db close];
        [self performSegueWithIdentifier:@"succeed" sender:nil];
    }else{
        UIAlertController * alert =[AlertHelper Alertwithtitle:@"提示" message:@"输入的账号或密码有误" actiontitle:@"确定"];
                [self presentViewController:alert animated:YES completion:nil];
        [db close];
            }

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Register1"]) {
//        Register *RegisterVC = [segue destinationViewController];
        if (!self.Check.on) {
            self.Account.text = @"";
            self.PassWord.text = @"";

        }
            }
}
@end
