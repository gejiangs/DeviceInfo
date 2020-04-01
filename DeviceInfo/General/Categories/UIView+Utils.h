//
//  UIView+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//


/*
 [view1 remakeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.mas_bottom).offset(SPACE_Y);
     make.centerY.equalTo(@[view2]);
     make.size.mas_equalTo(CGSizeMake(140, 45));
 }];
 
 [view2 remakeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake(140, 45));
 }];
 
 //多view水平居中对齐
 [self distributeSpacingHorizontallyWith:@[view1, view2]];
 
 //多view垂直居中对齐
 [self distributeSpacingVerticallyWith:@[view1, view2]];
 */



#import <UIKit/UIKit.h>

@interface UIView (Utils)

#pragma mark -- View 添加UILabel,UITextField。。。。。

//多view水平居中对齐（参考顶部）
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;

//多view垂直居中对齐（参考顶部）
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

//设置view圆角
-(instancetype)cornerRadius:(CGFloat)radius;

//设置通用阴影
-(void)setGeneralShadow;

//截图
- (UIImage *)screenshot;

//截图(区域)
- (UIImage *)screenshotWithRect:(CGRect)rect;

//返回当前view的VC控制器
-(UIViewController *)mainViewController;

//设置阴影、阴影透明度
-(void)addShadowColor:(UIColor *)color;

//设置阴影、阴影透明度
-(void)addShadowColor:(UIColor *)color opacity:(CGFloat)opacity;



@end

