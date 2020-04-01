//
//  UIViewController+Utils.h
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/16.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Utils)


/**
 当前ViewController显示ActionSheet

 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 */
-(void)showActionSheet:(NSString *)title
               message:(NSString *)message
               buttons:(NSArray<NSString *> *)buttons
                cancel:(NSString *)cancel;

/**
 当前ViewController显示ActionSheet
 
 @param title 标题
 @param message 内容
 @param destructive 红色按钮标题
 @param cancel 取消按钮标题
 */
-(void)showActionSheet:(NSString *)title
               message:(NSString *)message
           destructive:(NSString *)destructive
                cancel:(NSString *)cancel
                 block:(void (^__nullable)(NSInteger buttonIndex))block;

/**
 当前ViewController显示ActionSheet

 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 @param block 按钮点击回调
 */
-(void)showActionSheet:(NSString * __nullable)title
               message:(NSString *__nullable)message
               buttons:(NSArray<NSString *> *)buttons
                cancel:(NSString *)cancel
                 block:(void (^__nullable)(NSInteger buttonIndex))block;

/**
 当前ViewController显示Alert

 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 */
-(void)showAlert:(NSString *)title
         message:(NSString *)message
         buttons:(NSArray *)buttons;

/**
 当前ViewController显示Alert
 
 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 @param block 按钮点击回调
 */
-(void)showAlert:(NSString *)title
         message:(NSString *)message
         buttons:(NSArray *)buttons
           block:(void (^__nullable)(NSInteger buttonIndex))block;
@end

NS_ASSUME_NONNULL_END
