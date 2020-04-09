//
//  AutoCheckPowerKeyView.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/9.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoCheckPowerKeyView : UIView

+(void)showInView:(UIView *)view block:(nullable void(^)(BOOL normal))block;

@end

NS_ASSUME_NONNULL_END
