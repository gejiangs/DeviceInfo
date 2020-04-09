//
//  AppDelegate.m
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

-(void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NofiApplicationScreenLocked" object:nil];
}


@end
