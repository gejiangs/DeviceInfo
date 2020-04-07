//
//  AutoCheckVolumeKeyView.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/3.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckVolumeKeyView : UIView

+(void)showInView:(UIView *)view plusObserverBlock:(nullable void(^)(BOOL normal))block;
+(void)showInView:(UIView *)view subObserverBlock:(nullable void(^)(BOOL normal))block;

@end

NS_ASSUME_NONNULL_END
