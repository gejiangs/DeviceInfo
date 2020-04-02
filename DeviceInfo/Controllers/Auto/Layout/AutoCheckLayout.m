//
//  AutoCheckLayout.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckLayout.h"

@interface AutoCheckLayout ()

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

#pragma mark - lazy
-(NSMutableArray *)itemLayouts
{
    if (_itemLayouts == nil) {
        _itemLayouts = [NSMutableArray array];
    }
    return _itemLayouts;
}

@end
