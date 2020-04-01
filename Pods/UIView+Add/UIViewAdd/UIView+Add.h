//
//  UIView+Add.h
//  UIViewAdd
//
//  Created by gejiangs on 2019/3/5.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Add)

typedef NS_ENUM(NSInteger){
    GJScrollHorizontal,
    GJScrollVertical
} GJScroll;

#pragma mark - UILabel Add
/**
 当前View添加label

 @return 返回Label
 */
-(UILabel *)addLabel;

/**
 当前View添加Label，设置文字

 @param text 显示文字
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text;

/**
 当前View添加Label，设置文字、字体

 @param text 显示文字
 @param font 字体
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text font:(nullable UIFont *)font;

/**
 当前View添加Label,设置文字、颜色

 @param text 文字
 @param color 颜色
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text color:(nullable UIColor *)color;

/**
 当前View添加Label,设置文字、字体、颜色

 @param text 文字
 @param font 字体
 @param color 颜色
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text font:(nullable UIFont *)font color:(nullable UIColor *)color;


#pragma mark - UITextField Add
/**
 当前UIView添加UITextField
 
 @return 返回UITextField对象
 */
-(UITextField *)addTextField;

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @return 返回UITextField对象
 */
-(UITextField *)addTextField:(nullable NSString *)text;

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @param delegate Delegate
 @return 返回UITextField对象
 */
-(UITextField *)addTextField:(nullable NSString *)text delegate:(nullable id)delegate;

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @param placeholder 提示内容
 @return 返回UITextField对象
 */
-(UITextField *)addTextField:(nullable NSString *)text placeholder:(nullable NSString *)placeholder;

/**
 当前UIView添加UITextField

 @param text 文字内容
 @param placeholder 提示内容
 @param delegate Delegate
 @return 返回UITextField对象
 */
-(UITextField *)addTextField:(nullable NSString *)text placeholder:(nullable NSString *)placeholder delegate:(nullable id)delegate;

#pragma mark - UIButton Add
/**
 当前UIView添加UIButton
 
 @return 返回UIButton对象
 */
-(UIButton *)addButton;

/**
 当前UIView添加UIButton
 
 @param title 默认状态标题
 @return 返回UIButton对象
 */
-(UIButton *)addButton:(nullable NSString *)title;

/**
 当前UIView添加UIButton

 @param title 默认状态标题
 @param target UIControlEventTouchUpInside Target
 @param action UIControlEventTouchUpInside Action
 @return 返回UIButton对象
 */
-(UIButton *)addButton:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;

#pragma mark - UITextView Add
/**
 当前UIView添加UITextView
 
 @return 返回UITextView对象
 */
-(UITextView *)addTextView;

/**
 当前UIView添加UITextView
 
 @param text 文字
 @return 返回UITextView对象
 */
-(UITextView *)addTextView:(nullable NSString *)text;

/**
 当前UIView添加UITextView

 @param text 文字
 @param delegate 代理delegate
 @return 返回UITextView对象
 */
-(UITextView *)addTextView:(nullable NSString *)text delegate:(nullable id)delegate;

#pragma mark - UITextView Add
/**
 当前UIView添加UIScrollView
 
 @return 返回UIScrollView实例对象
 */
-(UIScrollView *)addScrollView:(GJScroll)direction;

/**
 当前UIView添加UIScrollView

 @param direction 滚动方向
 @param delegate 代理
 @return 返回UIScrollView实例对象
 */
-(UIScrollView *)addScrollView:(GJScroll)direction delegate:(nullable id)delegate;

#pragma mark - UIImageView Add
/**
 当前UIView添加UIImage
 
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageView;

/**
 当前UIView添加UIImage
 
 @param imageName image名称
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageViewWithName:(nullable NSString *)imageName;

/**
 当前UIView添加UIImage

 @param image image对象
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageViewWithImage:(nullable UIImage *)image;

#pragma mark - UISlider Add
/**
 当前UIView添加UISlider
 
 @return 返回UISlider实例对象
 */
-(UISlider *)addSlider;

/**
 当前UIView添加UISlider

 @param target 代理对象
 @param action action
 @return 返回UISlider实例对象
 */
-(UISlider *)addSlider:(nullable id)target action:(nullable SEL)action;

#pragma mark - UISwitch Add
/**
 当前UIView添加UISwitch
 
 @return 返回UISwitch实例对象
 */
-(UISwitch *)addSwitch;

/**
 当前UIView添加UISwitch
 
 @param target 代理对象
 @param action action
 @return 返回UISwitch实例对象
 */
-(UISwitch *)addSwitch:(nullable id)target action:(nullable SEL)action;

#pragma mark - UITableView Add
/**
 当前UIView添加UITableView
 
 @return 返回UITableView实例对象
 */
-(UITableView *)addTableView:(UITableViewStyle)style;

/**
 当前UIView添加UITableView

 @param delegate 代理对象
 @return 返回UITableView实例对象
 */
-(UITableView *)addTableView:(UITableViewStyle)style delegate:(nullable id)delegate;

#pragma mark - UICollectionView Add
/**
 当前UIView添加UISwitch
 
 @return 返回UICollectionView实例对象
 */
-(UICollectionView *)addCollectionView:(GJScroll)direction;

/**
 当前UIView添加UISwitch

 @param direction 滚动方向
 @param delegate 代理对象
 @return 返回UICollectionView实例对象
 */
-(UICollectionView *)addCollectionView:(GJScroll)direction delegate:(nullable id)delegate;

#pragma mark - UIPageControl Add

/**
 当前UIView添加UISwitch
 
 @return 返回UISwitch实例对象
 */
-(UIPageControl *)addPageControl;

/**
 当前UIView添加UISwitch
 
 @param target 代理对象
 @param action action
 @return 返回UISwitch实例对象
 */
-(UIPageControl *)addPageControl:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
