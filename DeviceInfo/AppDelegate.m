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
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"testjson1" ofType:@"text"];
    NSString *jsonText = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:jsonPath] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *jsonDict = [jsonText mj_JSONObject];
    NSLog(@"jsonDict:%@", jsonDict);
    NSString *name = jsonDict[@"info"][@"name"];
    NSLog(@"name:%@", name);
    
    return YES;
}

-(void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NofiApplicationScreenLocked" object:nil];
}


@end
