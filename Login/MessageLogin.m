//
//  MessageLogin.m
//  Login
//
//  Created by 孤岛 on 16/8/1.
//  Copyright © 2016年 孤岛. All rights reserved.
//
#import "ViewController.h"
#import "MessageLogin.h"

@interface MessageLogin ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField * PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField * verifyNumber;
@property (weak, nonatomic) IBOutlet UIButton    * Verify;
@property (strong,nonatomic) NSString            * randomnumber;
@property (assign,nonatomic) int                   count;
@property (strong,nonatomic) NSTimer             * timer;
@end

@implementation MessageLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PhoneNumber.delegate    = self;
    self.verifyNumber.delegate   = self;
    self.PhoneNumber.placeholder = @"11位大陆手机号";
    self.count                   = 60;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击空白回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.PhoneNumber  resignFirstResponder];
    [self.verifyNumber resignFirstResponder];
}
- (IBAction)tapButton:(id)sender {
    /*短信API*/
    if (self.PhoneNumber.text.length == 11 ) {
        if (self.checkPhoneNumber) {
            UIAlertController *alert1 = [AlertHelper Alertwithtitle:@"提示" message:@"此号码已被注册" actiontitle:@"确定"];
            [self presentViewController:alert1 animated:YES completion:nil];

        }else{
            int random = arc4random()%10000;
            NSLog(@"random是%i",random);
            self.randomnumber =[NSString stringWithFormat:@"%i",random];
            NSString *encodePhone = [self.PhoneNumber.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSString *URLtext = [NSString stringWithFormat:@"860-1?showapi_appid=22718&showapi_sign=a30b3fab36334b08bdff76b2fdee72d8&mobile=%@&title=CQUPT&content=%d",encodePhone,random];
            
            [[ATNetworkingHelper SharedHttpManager]GET:URLtext parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject != nil) {
                    NSDictionary *dict = responseObject;
                    NSDictionary * res = dict[@"showapi_res_body"];
                    //                [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    //                    NSDictionary *result = obj;
                    //                }];
                    NSString* Results = res[@"ret_code"];
                    if ([Results isEqualToString:@"0"]) {
                        //                    self.Verify.titleLabel.text = @"已发送";
                        //                    self.Verify.userInteractionEnabled = NO;
                        [self.Verify setEnabled:NO];
                        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
                        
                    }
                    
                    
                }
            }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self.Verify setEnabled:NO];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
                NSLog(@"失败了");
            }];

            
        }
           }else{                      //如果电话没填则报错
        UIAlertController *alert1 = [AlertHelper Alertwithtitle:@"提示" message:@"请输入正确的号码" actiontitle:@"确定"];
        [self presentViewController:alert1 animated:YES completion:nil];
        
    }
}
- (IBAction)Finish:(UIButton *)sender {
    [self FinishRegister];
    }
#pragma mark -FinishRegister
-(void)FinishRegister{
    if ([self.verifyNumber.text isEqualToString:self.randomnumber]) {
       FMDatabase *db = [DatabaseHelper openDatabase];
        NSString *Account = self.Account1;
        NSString *Password = self.Password1;
        NSLog(@"账号是是是：%@ 密码是是是:%@",Account,Password);
        [db executeUpdate:@"INSERT INTO User(Account,Password)VALUES(?,?)",Account,Password];
        [db executeUpdate:@"INSERT INTO User(Account,Password)VALUES(?,?)",self.PhoneNumber.text,Password];
        NSLog(@"注册成功");
        [db close];
        [self performSegueWithIdentifier:@"login" sender:nil];
    }else{
        UIAlertController *alert1 = [AlertHelper Alertwithtitle:@"提示" message:@"验证码输入错误" actiontitle:@"确定"];
        [self presentViewController:alert1 animated:YES completion:nil];
        
    }

}
#pragma mark - NSTimer的实现
- (void)onTimer {
    if (self.count > 0) {
        [self.Verify setTitleColor:[UIColor colorWithWhite:0.468 alpha:1.000] forState:UIControlStateDisabled];
        [self.Verify setTitle:[NSString stringWithFormat:@"%d秒后重新获取",self.count] forState:UIControlStateDisabled];
        self.count --;
    }else{
        self.count = 60;
        [self.timer invalidate];
        self.timer = nil;
        [self.Verify setTitle:@"重发验证码" forState:UIControlStateNormal];
        [self.Verify setTitle:@"60秒后重新获取" forState:UIControlStateDisabled];
        [self.Verify setEnabled:YES];
    }
            }
#pragma mark - 判断是否已有此电话注册
- (BOOL) checkPhoneNumber{
    BOOL FLag = NO;
    FMDatabase *db = [DatabaseHelper openDatabase];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM User"];
    while ([rs next]) {
        NSString * Account = [rs stringForColumn:@"Account"];
        if ([self.PhoneNumber.text isEqualToString:Account]) {
            FLag = YES; break;
        }
        
    }
    return FLag;
    
}
#pragma mark - DidonExit
- (IBAction)Change:(id)sender {
    [self.verifyNumber becomeFirstResponder];
}

- (IBAction)Done:(id)sender {
    [self FinishRegister];
}
//#pragma mark - 跳转
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"login"]) {
//        ViewController *LoginVC = [segue destinationViewController];
//        [LoginVC reloadInputViews];
//    }
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
