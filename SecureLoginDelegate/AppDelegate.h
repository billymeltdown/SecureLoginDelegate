//
//  AppDelegate.h
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSecureDataController.h"
#import "LoginViewController.h"
#import "ProtectedDataViewController.h"
#import "SecureDelegateNotifications.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet ZTSecureDataController *secureDataController;
@property (strong, nonatomic) IBOutlet LoginViewController *loginViewController;
@property (strong, nonatomic) IBOutlet ProtectedDataViewController *dataViewController;

@end

