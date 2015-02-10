//
//  ZTSecureDataController.h
//  SecureLoginDelegate
//
//  Created by Billy Gray on 2/10/15.
//  Copyright (c) 2015 Zetetic. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kSecureDataControllerLockNowNotifiction;
extern NSString * const kSecureDataControllerUnlockNotifiction;

@interface ZTSecureDataController : UIViewController

@property (nonatomic, strong) IBOutlet UIViewController *loginViewController;
@property (nonatomic, strong) IBOutlet UIViewController *dataViewController;
@property (nonatomic) BOOL isLocked;

- (IBAction)lock:(id)sender;
- (IBAction)unlock:(id)sender;

@end
