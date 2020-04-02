//
//  HandCheckItemLayout.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandCheckItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HandCheckItemLayout : NSObject

@property (nonatomic, copy)     NSString *title;
@property (nonatomic, strong)   HandCheckItemModel *model;

-(void)layout;

@end

NS_ASSUME_NONNULL_END
