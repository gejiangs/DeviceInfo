//
//  HandCheckLayout.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "HandCheckLayout.h"

@implementation HandCheckLayout

-(void)layout
{
    NSArray *titles = @[@"屏幕亮点坏点",@"多指触控",@"触摸检测",
                        @"震动检测",@"距离传感器",@"光线传感器",
                        @"闪光灯",@"静音键",@"音量-",
                        @"音量+",@"电源键",@"Home键",
                        @"后相机粉尘",@"前相机粉尘",@"前相机录影",
                        @"后相机录影",@"底麦克风录音",@"扬声器",
                        @"通话测试",@"蓝牙测试",@"Wifi测试",
                        @"耳机",@"充电口",@"生物识别"];
    
    [self.itemLayouts removeAllObjects];
    for (NSString *t in titles) {
        HandCheckItemLayout *itemLayout = [HandCheckItemLayout new];
        itemLayout.title = t;
        [itemLayout layout];
        [self.itemLayouts addObject:itemLayout];
    }
}

#pragma mark - lazy
-(NSMutableArray *)itemLayouts
{
    if (_itemLayouts == nil) {
        _itemLayouts = [NSMutableArray array];
    }
    return _itemLayouts;
}
@end
