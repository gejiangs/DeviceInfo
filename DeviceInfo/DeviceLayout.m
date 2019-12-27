//
//  DeviceLayout.m
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "DeviceLayout.h"
#import "DeviceManger.h"

@implementation DeviceLayout

-(id)init
{
    if (self = [super init]) {
        [self initValues];
    }
    return self;
}

-(void)initValues
{
    NSMutableArray *a = [NSMutableArray array];
//    [a addObject:@{@"k":@"IMSI", @"v":[DeviceManger getDeviceIMSIValue]}];
//    [a addObject:@{@"k":@"IMEI", @"v":[DeviceManger getDeviceIMEIValue]}];
    [a addObject:@{@"k":@"设备名称", @"v":[DeviceManger getDeviceName]}];
    [a addObject:@{@"k":@"MAC地址", @"v":[DeviceManger getDeviceMacIdValue]}];
    [a addObject:@{@"k":@"运营商", @"v":[DeviceManger getDeviceCarrierName]}];
    [a addObject:@{@"k":@"网络", @"v":[DeviceManger getDeviceNetworkName]}];
    [a addObject:@{@"k":@"屏X", @"v":[DeviceManger getDeviceXMaxValue]}];
    [a addObject:@{@"k":@"屏Y", @"v":[DeviceManger getDeviceYMaxValue]}];
    [a addObject:@{@"k":@"分辨率X", @"v":[DeviceManger getDeviceXResolution]}];
    [a addObject:@{@"k":@"分辨率Y", @"v":[DeviceManger getDeviceYResolution]}];
    [a addObject:@{@"k":@"型号", @"v":[DeviceManger getDeviceModel]}];
    [a addObject:@{@"k":@"操作系统", @"v":[DeviceManger getDeviceOSName]}];
    [a addObject:@{@"k":@"系统版本", @"v":[DeviceManger getDeviceOSVersion]}];
    [a addObject:@{@"k":@"UUID", @"v":[DeviceManger getUUID]}];
    [a addObject:@{@"k":@"内存", @"v":[DeviceManger getTotalMemorySize]}];
    [a addObject:@{@"k":@"可用内存", @"v":[DeviceManger getAvailableMemorySize]}];
    [a addObject:@{@"k":@"电量", @"v":[DeviceManger getCurrentBatteryLevel]}];
    [a addObject:@{@"k":@"电池状态", @"v":[DeviceManger getBatteryState]}];
    [a addObject:@{@"k":@"语言", @"v":[DeviceManger getDeviceLanguage]}];
    [a addObject:@{@"k":@"地区型号", @"v":[DeviceManger getLocalizedModel]}];
    [a addObject:@{@"k":@"IP地址", @"v":[DeviceManger getDeviceIPAdress]}];
    
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:a];
}

-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
