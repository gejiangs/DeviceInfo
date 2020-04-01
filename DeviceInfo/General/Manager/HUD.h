//
//  HUD.h
//  WhiteGoods
//
//  Created by 郭江 on 2019/8/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUD : NSObject

+(MBProgressHUD *)show;

+(MBProgressHUD *)showInView:(UIView *)view;

+(MBProgressHUD *)showText:(NSString *)text;

+(void)showSuccess:(NSString *)text;

+(void)showSuccess:(NSString *)text inView:(UIView *)view;

+(void)showError:(NSString *)text;

+(void)hide;

@end

NS_ASSUME_NONNULL_END
