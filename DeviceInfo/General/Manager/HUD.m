//
//  HUD.m
//  WhiteGoods
//
//  Created by 郭江 on 2019/8/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "HUD.h"
#import "AppDelegate.h"
#import "ToastView.h"

@interface HUD ()

@property (nonatomic, strong)   UIView *view;
@property (nonatomic, strong)   MBProgressHUD *hud;

@end

@implementation HUD

+(instancetype)manager
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

-(MBProgressHUD *)showHUD
{
    return [self showHUDText:@""];
}

//显示加载提示
- (MBProgressHUD *)showHUDText:(NSString *)text
{
    return [self showHUDText:text inView:self.view];
}

//显示加载提示
- (MBProgressHUD *)showHUDText:(NSString *)text inView:(UIView *)inView
{
    if (self.hud != nil) {
        [self.hud hideAnimated:NO];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    hud.label.text = StringIsEmpty(text) ? nil : text;
    [inView addSubview:hud];
    [hud showAnimated:YES];
    
    self.hud = hud;
    
    return hud;
}

//显示进度条
-(MBProgressHUD *)showProgressHUDText:(NSString *)text
{
    if (self.hud != nil) {
        [self.hud hideAnimated:NO];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = StringIsEmpty(text) ? nil : text;
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    
    self.hud = hud;
    
    return hud;
}

- (void)showError:(NSString *)error
{
    [self show:error icon:@"error" view:nil];
}

- (void)showSuccess:(NSString *)success
{
    [self show:success icon:@"success" view:nil];
}

- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

//隐藏加载提示
- (void)hiddenHUD
{
    if (self.hud != nil) {
        [self.hud hideAnimated:YES];
    }
}

-(UIWindow *)window
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
}

-(UIView *)view
{
    UIView *v = nil;
    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    UIViewController *rootVC = window.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UIViewController *firstVC = [((UINavigationController *)rootVC).viewControllers lastObject];
        v = firstVC.view;
    }else if ([rootVC isKindOfClass:[UITabBarController class]]){
        UIViewController *firstVC = ((UITabBarController *)rootVC).selectedViewController;
        if ([firstVC isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc = [((UINavigationController *)firstVC).viewControllers lastObject];
            v = vc.view;
        }else if ([firstVC isKindOfClass:[UIViewController class]]){
            v = firstVC.view;
        }
    }else if ([rootVC isKindOfClass:[UIViewController class]]){
        v = rootVC.view;
    }
    
    if (v == nil) {
        v = window;
    }
    
    return v;
}

#pragma mark - 显示Toast
//显示toast文字
- (void)showToastText:(NSString *)text
{
    [self showToastText:text duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字
- (void)showToastText:(NSString *)text inView:(UIView *)view
{
    [ToastView showWithText:text inView:view duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字与指定时间消失
- (void)showToastText:(NSString *)text duration:(CGFloat)duration
{
    [ToastView showWithText:text inView:self.window duration:duration];
}

//显示toast文字，指定向上偏移
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset
{
    [self showToastText:text topOffset:topOffset duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字，指定向上偏移与定时消失
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset duration:(CGFloat) duration
{
    [ToastView showWithText:text inView:self.window topOffset:topOffset duration:duration];
}

//显示toast文字，指定向下偏移
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset
{
    [self showToastText:text bottomOffset:bottomOffset duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字，指定向下偏移与定时消失
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset duration:(CGFloat) duration
{
    [ToastView showWithText:text inView:self.window bottomOffset:bottomOffset duration:duration];
}

#pragma mark -mark
+(MBProgressHUD *)show
{
    return [[HUD manager] showHUD];
}

+(MBProgressHUD *)showInView:(UIView *)view
{
    return [[HUD manager] showHUDText:nil inView:view];
}

+(MBProgressHUD *)showText:(NSString *)text
{
    return [[HUD manager] showHUDText:text];
}

+(void)showSuccess:(NSString *)text
{
    [self hide];
    [[HUD manager] showToastText:text];
}

+(void)showSuccess:(NSString *)text inView:(UIView *)view
{
    [self hide];
    [[HUD manager] showToastText:text];
}

+(void)showError:(NSString *)text
{
    [self hide];
    [[HUD manager] showError:text];
}

+(void)hide
{
    [[HUD manager] hiddenHUD];
}

@end
