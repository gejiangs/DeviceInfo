//
//  AutoCheckItemLayout.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckItemLayout.h"

@implementation AutoCheckItemLayout

-(void)layout
{
    self.model = [[AutoCheckItemModel alloc] initWithTitle:self.title];
    self.statusText = @"等待检测";
}

-(NSString *)statusText
{
    if (_model.status == AutoCheckItemStatusNone) {
        _statusText = @"等待检测";
    }else if (_model.status == AutoCheckItemStatusChecking){
        _statusText = @"检测中...";
    }else if (_model.status == AutoCheckItemStatusNormal){
        _statusText = @"正常";
    }else if (_model.status == AutoCheckItemStatusAbnormal){
        _statusText = @"不正常";
    }
    return _statusText;
}

//检查是否越狱
-(BOOL)checkIsJailBreak
{
    //能获取到该目录，就表示已经越狱了
    return [[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"];
}

-(void)updateCheckItemStatus:(AutoCheckItemStatus)status
{
    self.model.status = status;
}

@end
