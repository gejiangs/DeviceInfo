//
//  RouterHandler.h
//  WhiteGoods
//
//  Created by gejiangs on 2020/2/21.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RouterSkipStyle){
    RouterSkipStylePush,        // push 跳转
    RouterSkipStylePresent      // 模态跳转
};

@interface RouterHandler : NSObject

/// 处理路由跳转
/// @param skipVC 当前vc
/// @param toVCName 需要中转至的toVCName
/// @param style 转场类型
/// @param animated 是否动画
+(void)skipVC:(UIViewController *)skipVC toVCName:(NSString *)toVCName styke:(RouterSkipStyle)style animated:(BOOL)animated;

/// 处理路由跳转
/// @param skipVC 当前vc
/// @param toVC 需要中转至的VC
/// @param style 转场类型
/// @param animated 是否动画
+(void)skipVC:(UIViewController *)skipVC toVC:(UIViewController *)toVC styke:(RouterSkipStyle)style animated:(BOOL)animated;

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
+(void)openKey:(nonnull NSString *)routerKey scopeVC:(nonnull UIViewController *)scopeVC;

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
/// @param info 参数信息
+(void)openKey:(nonnull NSString *)routerKey scopeVC:(nonnull UIViewController *)scopeVC info:(nullable NSDictionary *)info;

/// 打开路由
/// @param routerKey 路由key
/// @param scopeVC 当前作用域vc
/// @param info 参数信息
/// @param completion 回调
+(void)openKey:(nonnull NSString *)routerKey scopeVC:(nonnull UIViewController *)scopeVC info:(nullable NSDictionary *)info completion:(nullable void (^)(id result))completion;

@end

NS_ASSUME_NONNULL_END
