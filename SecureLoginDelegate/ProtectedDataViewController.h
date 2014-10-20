//
//  ProtectedDataViewController.h
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProtectedDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *lockButton;

- (IBAction)lock:(id)sender;

@end
