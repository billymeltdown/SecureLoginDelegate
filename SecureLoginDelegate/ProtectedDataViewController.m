//
//  ProtectedDataViewController.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "ProtectedDataViewController.h"
#import "SecureDelegateNotifications.h"

@interface ProtectedDataViewController ()

@end

@implementation ProtectedDataViewController

@synthesize lockButton=_lockButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lock:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSecureDelegateTimeToLockNotifiction object:nil];
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