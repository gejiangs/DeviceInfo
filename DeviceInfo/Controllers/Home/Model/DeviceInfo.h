//
//  DeviceInfo.h
//  DeviceInfo
//
//  Created by gejiangs on 2019/12/27.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfo : NSObject

@property (nonatomic, copy)     NSString *imsi;
@property (nonatomic, copy)     NSString *imei;
@property (nonatomic, copy)     NSString *mac;
@property (nonatomic, copy)     NSString *carrierName;
@property (nonatomic, copy)     NSString *networkName;
@property (nonatomic, copy)     NSString *yMax;
@property (nonatomic, copy)     NSString *xMax;
@property (nonatomic, copy)     NSString *xResolution;
@property (nonatomic, copy)     NSString *yResolution;
@property (nonatomic, copy)     NSString *model;
@property (nonatomic, copy)     NSString *osName;
@property (nonatomic, copy)     NSString *osDevice;
@property (nonatomic, copy)     NSString *UUID;
@property (nonatomic, copy)     NSString *batteryLevel;
@property (nonatomic, copy)     NSString *ip;
@property (nonatomic, copy)     NSString *memorySize;
@property (nonatomic, copy)     NSString *memorySizeAble;
@property (nonatomic, copy)     NSString *batteryStatus;
@property (nonatomic, copy)     NSString *language;

@end

NS_ASSUME_NONNULL_END
