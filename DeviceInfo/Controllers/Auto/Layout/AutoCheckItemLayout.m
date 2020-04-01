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

@end
