//
//  AppDelegate.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "AppDelegate.h"
#import "CompatMacros.h"

@interface AppDelegate ()
- (void)_showAppView:(BOOL)animated;
- (void)_hideAppView:(BOOL)animated;
- (void)_timeToLockNotification:(NSNotification *)notification;
@property (nonatomic) BOOL isLoginViewControllerDisplayed;
@end

@implementation AppDelegate

@synthesize loginViewController=_loginViewController;
@synthesize dataViewController=_dataViewController;
@synthesize isLoginViewControllerDisplayed=_isLoginViewControllerDisplayed;

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        // depending on iOS version, we have differing root view controllers
        _isLoginViewControllerDisplayed = NO;
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // setup the window with loginViewController as the rootViewController for now
    // to avoid showing app view on launch on iOS 8
    [[self window] setRootViewController:self.loginViewController];
    [[self window] makeKeyAndVisible];
    self.isLoginViewControllerDisplayed = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self _hideAppView:NO];
    [self.loginViewController.view snapshotViewAfterScreenUpdates:YES];
}

//- (void)applicationDidEnterBackground:(UIApplication *)application {
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)_showAppView:(BOOL)animated {
    if (self.window.rootViewController == self.loginViewController) {
        [UIView transitionFromView:self.window.rootViewController.view
                            toView:self.dataViewController.view
                          duration:0.4f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished){
                            self.window.rootViewController = self.dataViewController;
                        }];
    }
    // keep our record up to date here:
    self.isLoginViewControllerDisplayed = NO;
}

- (void)_hideAppView:(BOOL)animated {
    // avoid re-doing this just in case
    if (self.isLoginViewControllerDisplayed == NO) {
        // modal view controllers screw this all up, sorry they have to get the boot
        if ([self.dataViewController presentedViewController] != nil) {
            [self.dataViewController dismissViewControllerAnimated:NO completion:nil];
        }
        NSTimeInterval duration = (is_iOS8) ? 0.2f : 0.0f;
        UIViewAnimationOptions options = (is_iOS8) ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionNone;
        if (self.window.rootViewController == self.dataViewController) {
            [UIView transitionFromView:self.window.rootViewController.view
                                toView:self.loginViewController.view
                              duration:duration
                               options:options
                            completion:^(BOOL finished){
                                self.window.rootViewController = self.loginViewController;
                            }];
        }
        self.isLoginViewControllerDisplayed = YES;
    }
}

- (void)_timeToLockNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSelectorOnMainThread:@selector(_hideAppView:) withObject:nil waitUntilDone:NO];
}

- (void)dealloc {
    // dealloc is still called if present when using ARC, but don't call super anymore
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LoginDelegate

- (void)loginComplete:(id)sender {
    [self performSelectorOnMainThread:@selector(_showAppView:) withObject:nil waitUntilDone:NO];
    // We'll want to start watching for lock notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_timeToLockNotification:)
                                                 name:kSecureDelegateTimeToLockNotifiction
                                               object:nil];
}

@end
