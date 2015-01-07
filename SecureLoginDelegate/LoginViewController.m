//
//  LoginViewController.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "LoginViewController.h"

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
    [self.delegate loginComplete:nil];
}

@end
