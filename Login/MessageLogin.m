//
//  MessageLogin.m
//  Login
//
//  Created by 孤岛 on 16/8/1.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "MessageLogin.h"

@interface MessageLogin ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyNumber;
@property (weak, nonatomic) IBOutlet UIButton *Verify;

@end

@implementation MessageLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapButton:(id)sender {
    /*短信API*/
    [self performSegueWithIdentifier:@"login" sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
