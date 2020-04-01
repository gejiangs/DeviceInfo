//
//  UIViewController+Utils.m
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/16.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

/**
 当前ViewController显示ActionSheet
 
 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 */
-(void)showActionSheet:(NSString *)title
               message:(NSString *)message
               buttons:(NSArray *)buttons
                cancel:(NSString *)cancel
{
    [self showActionSheet:title message:message buttons:buttons cancel:cancel block:nil];
}

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
                 block:(void (^)(NSInteger))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(0);
        }
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(1);
        }
    }];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 当前ViewController显示ActionSheet
 
 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 @param block 按钮点击回调
 */
-(void)showActionSheet:(NSString *__nullable)title
               message:(NSString *__nullable)message
               buttons:(NSArray *)buttons
                cancel:(NSString *)cancel
                 block:(void (^)(NSInteger))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<buttons.count; i++) {
        NSString *t = buttons[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:t style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(i);
            }
        }];
        [alert addAction:action];
    }
    if (cancel) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(buttons.count);
            }
        }];
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 当前ViewController显示Alert
 
 @param title 标题
 @param message 内容
 @param buttons 按钮标题数组（字符串）
 */
-(void)showAlert:(NSString *)title
         message:(NSString *)message
         buttons:(NSArray *)buttons
{
    [self showAlert:title message:message buttons:buttons block:nil];
}
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
           block:(void (^)(NSInteger))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i=0; i<buttons.count; i++) {
        NSString *t = buttons[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:t style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(i);
            }
        }];
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
