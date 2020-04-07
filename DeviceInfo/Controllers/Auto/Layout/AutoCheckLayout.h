//
//  AutoCheckLayout.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoCheckItemLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckLayout : NSObject

@property (nonatomic, strong)   NSMutableArray *itemLayouts;

-(void)layout;

-(void)autoCheckWithBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
