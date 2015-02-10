//
//  LoginViewController.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "LoginViewController.h"
#import "ZTSecureDataController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize loginButton;
@synthesize delegate=_delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unlock:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSecureDataControllerUnlockNotifiction object:nil];
}

@end
