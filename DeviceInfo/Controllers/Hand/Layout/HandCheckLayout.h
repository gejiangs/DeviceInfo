//
//  HandCheckLayout.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandCheckItemLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface HandCheckLayout : NSObject

@property (nonatomic, strong)   NSMutableArray *itemLayouts;

-(void)layout;

@end

NS_ASSUME_NONNULL_END
