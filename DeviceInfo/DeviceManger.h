//
//  DeviceManger.h
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceManger : NSObject

/*获取当前设备的IMSI值*/
+ (NSString *)getDeviceIMSIValue;

/*获取当前设备的IMEI值*/
+ (NSString *)getDeviceIMEIValue;

/*获取当前设备的MacId值*/
+ (NSString *)getDeviceMacIdValue;

/*获取当前设备的通讯运营商名称*/
+ (NSString *)getDeviceCarrierName;

/*获取当前设备的网络通讯名称值*/
+ (NSString *)getDeviceNetworkName;

/*获取当前设备的横向最大值*/
+ (NSString *)getDeviceXMaxValue;

/*获取当前设备的纵向最大值*/
+ (NSString *)getDeviceYMaxValue;

/*获取当前设备的横向分辨率值*/
+ (NSString *)getDeviceXResolution;

/*获取当前设备的纵向分辨率值*/
+ (NSString *)getDeviceYResolution;

/*获取当前设备的型号名称*/
+ (NSString *)getDeviceModel;

/*获取当前设备的名称*/
+ (NSString *)getDeviceName;

/*获取当前地方型号*/
+ (NSString *)getLocalizedModel;

/*获取当前设备的操作系统名称*/
+ (NSString *)getDeviceOSName;

/*获取当前设备的操作系统版本号*/
+ (NSString *)getDeviceOSVersion;

/*获取当前设备的唯一编号*/
+ (NSString *)getUUID;

///获取手机总内存
+ (NSString *)getTotalMemorySize;

/// 获取当前可用内存
+ (NSString *)getAvailableMemorySize;

/// 获取精准电池电量
+ (NSString *)getCurrentBatteryLevel;

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState;

/// 获取当前语言
+ (NSString *)getDeviceLanguage;

// 获取当前设备IP
+ (NSString *)getDeviceIPAdress;

@end

NS_ASSUME_NONNULL_END
