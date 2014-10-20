//
//  AppDelegate.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
- (void)_showAppView:(BOOL)animated;
- (void)_hideAppView:(BOOL)animated;
- (void)_timeToLockNotification:(NSNotification *)notification;
@property (nonatomic) BOOL isLoginViewControllerDisplayed;
@property (nonatomic) BOOL isIOS8;
@end

@implementation AppDelegate

@synthesize loginViewController=_loginViewController;
@synthesize dataViewController=_dataViewController;
@synthesize isLoginViewControllerDisplayed=_isLoginViewControllerDisplayed;
@synthesize isIOS8=_isIOS8;

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        // depending on iOS version, we have differing root view controllers
        _isLoginViewControllerDisplayed = NO;
        _isIOS8 = [NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // checking for an iOS 8 API..
    if (self.isIOS8) {
        // setup the window with loginViewController as the rootViewController for now
        // to avoid showing app view on launch on iOS 8
        [[self window] setRootViewController:self.loginViewController];
        [[self window] makeKeyAndVisible];
        self.isLoginViewControllerDisplayed = YES;
    } else {
        // we're on iOS 7 or below
        // setup the window with the app view as the base view on the window
        [[self window] setRootViewController:self.dataViewController];
        // show the window, making our login view visible, on top of the app view
        [[self window] makeKeyAndVisible];
        [self _hideAppView:NO];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self _hideAppView:NO];
    [self.loginViewController.view snapshotViewAfterScreenUpdates:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)_showAppView:(BOOL)animated {
    if (self.isLoginViewControllerDisplayed == YES) {
        if (self.isIOS8) {
            if (self.window.rootViewController == self.loginViewController) {
                [self.dataViewController.view setHidden:NO];
                [UIView transitionFromView:self.window.rootViewController.view
                                    toView:self.dataViewController.view
                                  duration:0.4f
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                completion:^(BOOL finished){
                                    self.window.rootViewController = self.dataViewController;
                                }];
            }
        } else { // iOS < version 8
            //        self.appViewController.view.hidden = NO;
            [[[self loginViewController] presentingViewController] dismissViewControllerAnimated: animated completion:NULL];
        }
        // keep our record up to date here:
        self.isLoginViewControllerDisplayed = NO;
    }
}

- (void)_hideAppView:(BOOL)animated {
    // avoid re-doing this just in case
    if (self.isLoginViewControllerDisplayed == NO) {
        // modal view controllers screw this all up, sorry they have to get the boot
        if ([self.dataViewController presentedViewController] != nil) {
            [self.dataViewController dismissViewControllerAnimated:NO completion:nil];
        }
        if (self.isIOS8) {
            if (self.window.rootViewController == self.dataViewController) {
                [UIView transitionFromView:self.window.rootViewController.view
                                    toView:self.loginViewController.view
                                  duration:0.2f
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                completion:^(BOOL finished){
                                    self.window.rootViewController = self.loginViewController;
                                    [self.dataViewController.view setHidden:YES];
                                }];
            }
        } else { // iOS version < 8
            //            [self.appViewController.view setHidden:YES];
            [self.window.rootViewController presentViewController:self.loginViewController animated:animated completion:NULL];
            //            [self.window.rootViewController.view snapshotViewAfterScreenUpdates:YES];
            //            [self.appViewController.view snapshotViewAfterScreenUpdates:YES];
        }
        // and when we're done...
        self.isLoginViewControllerDisplayed = YES;
    }
}

- (void)_timeToLockNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self _hideAppView:YES];
}

- (void)dealloc {
    // dealloc is still called if present when using ARC, but don't call super anymore
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LoginDelegate

- (void)loginComplete:(id)sender {
    [self _showAppView:YES];
    // We'll want to start watching for lock notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_timeToLockNotification:)
                                                 name:kSecureDelegateTimeToLockNotifiction
                                               object:nil];
}

@end
