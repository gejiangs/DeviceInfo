//
//  AutoCheckProximityMonitorView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckProximityMonitorView.h"

@implementation AutoCheckProximityMonitorView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    //开启监听距离感应的通知
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    //监听是否遮住
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)proximityChange:(NSNotificationCenter *)notification {
    if ([UIDevice currentDevice].proximityState == YES) { NSLog(@"某个物体靠近了设备屏幕"); // 屏幕会自动锁住
    } else {
        NSLog(@"某个物体远离了设备屏幕"); // 屏幕会自动解锁
    }
}

-(void)dealloc
{
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
