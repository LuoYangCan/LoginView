//
//  UINavigationController.m
//  Login
//
//  Created by 孤岛 on 16/7/28.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "UINavigationController.h"

@interface UINavigationController ()

@end

@implementation UINavigationController (UINavigationController_KeyboardDismiss)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)disablesAutomaticKeyboardDismissal{
    return NO;
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
