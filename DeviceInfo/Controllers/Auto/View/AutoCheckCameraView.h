//
//  AutoCheckCameraView.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/7.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckCameraView : UIView


+(void)showInView:(UIView *)view frontObserverBlock:(nullable void(^)(BOOL normal))block;
+(void)showInView:(UIView *)view backObserverBlock:(nullable void(^)(BOOL normal))block;

@end

NS_ASSUME_NONNULL_END
