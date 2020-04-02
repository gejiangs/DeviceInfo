//
//  AutoCheckLayout.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckLayout.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface AutoCheckLayout ()

@property (nonatomic, strong)   CMMotionManager *motionManager;

@end

@implementation AutoCheckLayout

-(void)layout
{
    NSArray *titles = @[@"电池",@"喇叭",@"底部麦克风",@"前麦克风",@"后麦克风",@"内存",@"处理器",@"硬盘",@"重力感应",@"陀螺仪",@"磁力计",@"GPS",@"电池罗盘",@"压力计"];
    
    [self.itemLayouts removeAllObjects];
    for (NSString *t in titles) {
        AutoCheckItemLayout *itemLayout = [AutoCheckItemLayout new];
        itemLayout.title = t;
        [itemLayout layout];
        [self.itemLayouts addObject:itemLayout];
    }
}

//检查指南针
-(BOOL)headingAvailable
{
    return [CLLocationManager headingAvailable];
}

/// 检测陀螺仪可用
-(BOOL)gyroscopeAvaibale
{
    return self.motionManager.gyroAvailable;
}

/// 支持加速度数据
-(BOOL)accelerometerAvailable
{
    return self.motionManager.accelerometerAvailable;
}

/// 磁场计
-(BOOL)magnetometerAvailable
{
    return self.motionManager.magnetometerAvailable;
}

#pragma mark - lazy
-(NSMutableArray *)itemLayouts
{
    if (_itemLayouts == nil) {
        _itemLayouts = [NSMutableArray array];
    }
    return _itemLayouts;
}

-(CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

@end
