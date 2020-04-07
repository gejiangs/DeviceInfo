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
@property (nonatomic, copy)     NSString *statusText;
@property (nonatomic, strong)   AutoCheckItemModel *model;

-(void)layout;

-(void)updateCheckItemStatus:(AutoCheckItemStatus)status;

@end

NS_ASSUME_NONNULL_END
