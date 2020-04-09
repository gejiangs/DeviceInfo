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
#import <AVFoundation/AVFoundation.h>

@interface AutoCheckLayout ()

@property (nonatomic, strong)   CMMotionManager *motionManager;

@end

@implementation AutoCheckLayout

-(void)layout
{
    NSArray *titles = @[@"距离传感器", @"按键功能", @"前摄像头", @"后摄像头", @"面容FaceID", @"陀螺仪", @"通话功能", @"屏幕显示", @"触摸屏功能", @"闪光灯", @"电源键功能"];
    //@[@"电池",@"喇叭",@"底部麦克风",@"前麦克风",@"后麦克风",@"内存",@"处理器",@"硬盘",@"重力感应",@"陀螺仪",@"磁力计",@"GPS",@"电池罗盘",@"压力计"];
    
    [self.itemLayouts removeAllObjects];
    for (NSString *t in titles) {
        AutoCheckItemLayout *itemLayout = [AutoCheckItemLayout new];
        itemLayout.title = t;
        [itemLayout layout];
        [self.itemLayouts addObject:itemLayout];
    }
}

-(void)autoCheckWithBlock:(void (^)(void))block
{
    
}

-(void)autoCheckWithIndex:(NSInteger)index
{
    
}

///检查闪光灯
/// @param block 返回是否正常
-(void)checkTorch:(void(^)(BOOL normal))block
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];
            [device unlockForConfiguration];
            
            if (block) {
                block(YES);
            }
        });
    }else{
        if (block) {
            block(NO);
        }
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
