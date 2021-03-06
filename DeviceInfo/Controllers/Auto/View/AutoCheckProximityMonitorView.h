//
//  AutoCheckProximityMonitorView.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckProximityMonitorView : UIView

+(void)showInView:(UIView *)view block:(nullable void(^)(BOOL normal))block;

@end

NS_ASSUME_NONNULL_END
