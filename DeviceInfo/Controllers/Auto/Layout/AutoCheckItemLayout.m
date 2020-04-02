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
}

//检查是否越狱
-(BOOL)checkIsJailBreak
{
    //能获取到该目录，就表示已经越狱了
    return [[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"];
}

@end
