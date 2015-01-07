//
//  CompatMacros.h
//  SecureLoginDelegate
//
//  Created by Billy Gray on 1/6/15.
//  Copyright (c) 2015 Zetetic. All rights reserved.
//

#ifdef __OBJC__

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define is_iOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define is_iOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

#endif