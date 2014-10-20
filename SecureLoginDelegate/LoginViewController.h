//
//  LoginViewController.h
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>
@required
- (void)loginComplete:(id)sender;
@end

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet id<LoginDelegate> delegate;

- (IBAction)unlock:(id)sender;

@end
