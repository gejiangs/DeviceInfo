//
//  AutoCheckItemLayout.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoCheckItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckItemLayout : NSObject

@property (nonatomic, copy)     NSString *title;
@property (nonatomic, strong)   AutoCheckItemModel *model;

-(void)layout;

@end

NS_ASSUME_NONNULL_END
