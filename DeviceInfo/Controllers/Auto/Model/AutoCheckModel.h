//
//  AutoCheckModel.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AutoCheckStatus){
    AutoCheckStatusNone = 0,        //未检查
    AutoCheckStatusNormal = 1,      //正常
    AutoCheckStatusAbnormal = 2     //不正常
};

@interface AutoCheckModel : NSObject

@property (nonatomic, assign)   AutoCheckStatus jailBreak;       //是否越狱
@property (nonatomic, assign)   AutoCheckStatus horn;            //喇叭是否正常
@property (nonatomic, assign)   AutoCheckStatus battery;         //电池是否正常
@property (nonatomic, assign)   AutoCheckStatus bottomMike;      //底麦克风
@property (nonatomic, assign)   AutoCheckStatus frontMike;       //前麦克风
@property (nonatomic, assign)   AutoCheckStatus backMike;        //后麦克风
@property (nonatomic, assign)   AutoCheckStatus memony;          //内存是否正常
@property (nonatomic, assign)   AutoCheckStatus processor;       //处理器
@property (nonatomic, assign)   AutoCheckStatus disk;            //硬盘
@property (nonatomic, assign)   AutoCheckStatus gSensor;         //重力感应
@property (nonatomic, assign)   AutoCheckStatus gyro;            //陀螺仪
@property (nonatomic, assign)   AutoCheckStatus magnetometer;    //磁力计
@property (nonatomic, assign)   AutoCheckStatus gps;             //GPS
@property (nonatomic, assign)   AutoCheckStatus compass;         //电子罗盘
@property (nonatomic, assign)   AutoCheckStatus manometer;       //压力计

@end

NS_ASSUME_NONNULL_END
