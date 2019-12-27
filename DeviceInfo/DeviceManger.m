//
//  DeviceManger.m
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "DeviceManger.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>  //为判断网络制式的主要文件
#import <CoreTelephony/CTCarrier.h> //添加获取客户端运营商 支持
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <objc/runtime.h>

@implementation DeviceManger

 
/*获取当前设备的IMSI值*/
+ (NSString *)getDeviceIMSIValue
{
    return @"";
}

/*获取当前设备的IMEI值*/
+ (NSString *)getDeviceIMEIValue
{
    return @"";
}

/*获取当前设备的MacId值*/
+ (NSString *)getDeviceMacIdValue
{
    return @"";
}

/*获取当前设备的通讯运营商名称*/
+ (NSString *)getDeviceCarrierName
{
    return [[[CTTelephonyNetworkInfo new] subscriberCellularProvider] carrierName];
}

/*获取当前设备的网络通讯名称值*/
+ (NSString *)getDeviceNetworkName
{
    /*
        CTRadioAccessTechnologyGPRS             //介于2G和3G之间(2.5G)
        CTRadioAccessTechnologyEdge             //GPRS到第三代移动通信的过渡(2.75G)
        CTRadioAccessTechnologyWCDMA
        CTRadioAccessTechnologyHSDPA            //亦称为3.5G(3?G)
        CTRadioAccessTechnologyHSUPA            //3G到4G的过度技术
        CTRadioAccessTechnologyCDMA1x           //3G
        CTRadioAccessTechnologyCDMAEVDORev0     //3G标准
        CTRadioAccessTechnologyCDMAEVDORevA
        CTRadioAccessTechnologyCDMAEVDORevB
        CTRadioAccessTechnologyeHRPD            //电信一种3G到4G的演进技术(3.75G)
        CTRadioAccessTechnologyLTE              //接近4G
     */
    return [[CTTelephonyNetworkInfo new] currentRadioAccessTechnology];
}

/*获取当前设备的横向最大值*/
+ (NSString *)getDeviceXMaxValue
{
    return [NSString stringWithFormat:@"%d", (int)CGRectGetWidth([UIScreen mainScreen].bounds)];
}

/*获取当前设备的纵向最大值*/
+ (NSString *)getDeviceYMaxValue
{
    return [NSString stringWithFormat:@"%d", (int)CGRectGetHeight([UIScreen mainScreen].bounds)];
}

/*获取当前设备的横向分辨率值*/
+ (NSString *)getDeviceXResolution
{
    return [NSString stringWithFormat:@"%0.1f", [self.getDeviceXMaxValue floatValue]/[UIScreen mainScreen].scale];
}

/*获取当前设备的纵向分辨率值*/
+ (NSString *)getDeviceYResolution
{
    return [NSString stringWithFormat:@"%0.1f", [self.getDeviceYMaxValue floatValue]/[UIScreen mainScreen].scale];
}

/*获取当前设备的型号名称*/
+ (NSString *)getDeviceModel
{
    NSString *platform = nil;
    struct utsname systemInfo;
    uname(&systemInfo);
    platform = [NSString stringWithCString:systemInfo.machine
                                  encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@",platform];
}


/*获取当前设备的名称*/
+ (NSString *)getDeviceName
{
    return [[UIDevice currentDevice] name];
}

/*获取当前地方型号*/
+ (NSString *)getLocalizedModel
{
    return [[UIDevice currentDevice] localizedModel];
}

/*获取当前设备的操作系统名称*/
+ (NSString *)getDeviceOSName
{
    return @"ios";
}

/*获取当前设备的操作系统版本号*/
+ (NSString *)getDeviceOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/*获取当前设备的唯一编号*/
+ (NSString *)getUUID
{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString *)formatSize:(long long)size
{
    NSString *str = @"";
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        str = [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        str = [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        str = [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        str = [NSString stringWithFormat:@"%.1fG",aFloat];
    }
    return str;
}

+ (NSString *)getTotalMemorySize
{
    return [self formatSize:[NSProcessInfo processInfo].physicalMemory];
}

/// 获取当前可用内存
+ (NSString *)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return @"No Find";
    }
    return [self formatSize:((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count))];
}

/// 获取精准电池电量
+ (NSString *)getCurrentBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [NSString stringWithFormat:@"%d%@", (int)([UIDevice currentDevice].batteryLevel*100), @"%"];
}

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UnKnow";
    } else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"Unplugged";
    } else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"Charging";
    } else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"Full";
    }
    return nil;
}

/// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

// 获取当前设备IP
+ (NSString *)getDeviceIPAdress {
    NSString *address = @"0.0.0.0";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}
@end
