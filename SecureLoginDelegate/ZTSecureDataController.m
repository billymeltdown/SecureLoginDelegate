//
//  ZTSecureDataController.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 2/10/15.
//  Copyright (c) 2015 Zetetic. All rights reserved.
//

#import "ZTSecureDataController.h"
#import "CompatMacros.h"

NSString * const kSecureDataControllerLockNowNotifiction = @"kSecureDataControllerLockNowNotifiction";
NSString * const kSecureDataControllerUnlockNotifiction = @"kSecureDataControllerUnlockNotifiction";

@interface ZTSecureDataController ()
@end

@implementation ZTSecureDataController

@synthesize loginViewController=_loginViewController;
@synthesize dataViewController=_dataViewController;
@synthesize isLocked=_isLocked;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {
        _isLocked = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.loginViewController]; // this automatically calls willMoveToParentViewController:
    [self.view addSubview:self.loginViewController.view];
    [self.loginViewController didMoveToParentViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(lock:)
                                                 name:kSecureDataControllerLockNowNotifiction
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unlock:)
                                                 name:kSecureDataControllerUnlockNotifiction
                                               object:nil];
    self.isLocked = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lock:(id)sender {
    if (self.isLocked == NO) {
        self.loginViewController.view.frame = self.dataViewController.view.bounds;
        [self addChildViewController:self.loginViewController];
        [self.dataViewController willMoveToParentViewController:nil];
        NSTimeInterval duration = (is_iOS8) ? 0.2f : 0.0f;
        UIViewAnimationOptions options = (is_iOS8) ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionNone;
        [self transitionFromViewController:self.dataViewController
                          toViewController:self.loginViewController
                                  duration:duration
                                   options:options
                                animations:nil
                                completion:^(BOOL finished) {
                                    [self.loginViewController didMoveToParentViewController:self];
                                    [self.dataViewController removeFromParentViewController];
                                    self.isLocked = YES;
                                }];
    }
}

- (IBAction)unlock:(id)sender {
    if (self.isLocked == YES) {
        self.dataViewController.view.frame = self.loginViewController.view.bounds;
        [self addChildViewController:self.dataViewController];
        [self.loginViewController willMoveToParentViewController:nil];
        [self transitionFromViewController:self.loginViewController
                          toViewController:self.dataViewController
                                  duration:0.4f
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:nil
                                completion:^(BOOL finished) {
                                    [self.dataViewController didMoveToParentViewController:self];
                                    [self.loginViewController removeFromParentViewController];
                                    self.isLocked = NO;
                                }];
    }
}

- (void)dealloc {
    // dealloc is still called if present when using ARC, but don't call super anymore
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
