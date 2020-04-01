//
//  RouterHandler.m
//  WhiteGoods
//
//  Created by gejiangs on 2020/2/21.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "RouterHandler.h"
#import <MGJRouter/MGJRouter.h>

@implementation RouterHandler

/// 处理路由跳转
/// @param skipVC 当前vc
/// @param toVCName 需要中转至的toVCName
/// @param style 转场类型
/// @param animated 是否动画
+(void)skipVC:(UIViewController *)skipVC toVCName:(NSString *)toVCName styke:(RouterSkipStyle)style animated:(BOOL)animated
{
    UIViewController *toVC = [[NSClassFromString(toVCName) alloc] init];
    if (style == RouterSkipStylePush) {
        toVC.hidesBottomBarWhenPushed = YES;
        [skipVC.navigationController pushViewController:toVC animated:animated];
    }else{
        [skipVC presentViewController:toVC animated:animated completion:nil];
    }
}

/// 处理路由跳转
/// @param skipVC 当前vc
/// @param toVC 需要中转至的toVC
/// @param style 转场类型
/// @param animated 是否动画
+(void)skipVC:(UIViewController *)skipVC toVC:(UIViewController *)toVC styke:(RouterSkipStyle)style animated:(BOOL)animated
{
    if (style == RouterSkipStylePush) {
        toVC.hidesBottomBarWhenPushed = YES;
        [skipVC.navigationController pushViewController:toVC animated:animated];
    }else{
        [skipVC presentViewController:toVC animated:animated completion:nil];
    }
}

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
+(void)openKey:(NSString *)routerKey scopeVC:(UIViewController *)scopeVC
{
    [self openKey:routerKey scopeVC:scopeVC info:nil];
}

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
/// @param info 参数信息
+(void)openKey:(NSString *)routerKey scopeVC:(UIViewController *)scopeVC info:(NSDictionary *)info
{
    [self openKey:routerKey scopeVC:scopeVC info:info completion:nil];
}

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
/// @param info 参数信息
/// @param completion 回调
+(void)openKey:(NSString *)routerKey scopeVC:(UIViewController *)scopeVC info:(NSDictionary *)info completion:(void (^)(id result))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:info];
    [params setObject:scopeVC forKey:RouterKeyController];
    [MGJRouter openURL:routerKey withUserInfo:params completion:completion];
}
@end
