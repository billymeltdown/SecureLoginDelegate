//
//  AppDelegate.m
//  SecureLoginDelegate
//
//  Created by Billy Gray on 10/19/14.
//  Copyright (c) 2014 Zetetic. All rights reserved.
//

#import "AppDelegate.h"
#import "CompatMacros.h"
#import <sqlite3.h>

@interface AppDelegate ()
@property (readonly) NSURL *databaseURL;
@property (readonly) BOOL databaseExists;
@end

@implementation AppDelegate

@synthesize secureDataController=_secureDataController;
@synthesize loginViewController=_loginViewController;
@synthesize dataViewController=_dataViewController;
@dynamic databaseURL;
@dynamic databaseExists;

//- (instancetype)init {
//    self = [super init];
//    if (self != nil) {
//
//    }
//    return self;
//}

- (NSURL *)databaseURL {
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directoryURL = [URLs firstObject];
    NSURL *databaseURL = [directoryURL URLByAppendingPathComponent:@"secure.db"];
    return  databaseURL;
}

- (BOOL)databaseExists {
    BOOL exists = NO;
    NSError *error = nil;
    exists = [[self databaseURL] checkResourceIsReachableAndReturnError:&error];
    if (exists == NO && error != nil) {
        NSLog(@"Error checking availability of database file: %@", error);
    }
    return exists;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[self window] setRootViewController:self.secureDataController];
    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.secureDataController lock:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
