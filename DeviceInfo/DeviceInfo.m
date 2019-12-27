//
//  DeviceInfo.m
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "DeviceInfo.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>  //为判断网络制式的主要文件
#import <CoreTelephony/CTCarrier.h> //添加获取客户端运营商 支持
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

@implementation DeviceInfo

-(id)init
{
    if (self = [super init]) {
        [self initValues];
    }
    return self;
}

-(void)initValues
{
    CTTelephonyNetworkInfo *net = [CTTelephonyNetworkInfo new];
    self.carrierName = [[net subscriberCellularProvider] carrierName];
    self.networkName = [net currentRadioAccessTechnology];
    self.xMax   = [NSString stringWithFormat:@"%d", (int)CGRectGetWidth([UIScreen mainScreen].bounds)];
    self.yMax   = [NSString stringWithFormat:@"%d", (int)CGRectGetHeight([UIScreen mainScreen].bounds)];
    self.xResolution = [NSString stringWithFormat:@"%0.1f", [self.xMax floatValue]/[UIScreen mainScreen].scale];
    self.yResolution = [NSString stringWithFormat:@"%0.1f", [self.yMax floatValue]/[UIScreen mainScreen].scale];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    self.model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    self.osName = @"iOS";
    self.osDevice = [[UIDevice currentDevice] systemVersion];
    self.UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    self.ip = @"0.0.0.0";
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
                    self.ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
//    self.memorySize = [NSProcessInfo processInfo].physicalMemory;
    
//    vm_statistics_data_t vmStats;
//    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
//    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
//    if (kernReturn != KERN_SUCCESS)
//    {
//        return NSNotFound;
//    }
//     ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

   
@end
