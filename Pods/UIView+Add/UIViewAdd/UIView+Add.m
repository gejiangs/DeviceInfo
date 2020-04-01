//
//  UIView+Add.m
//  UIViewAdd
//
//  Created by gejiangs on 2019/3/5.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)

#pragma mark - UITextField Add
/**
 当前View添加Label
 
 @return 返回Label
 */
-(UILabel *)addLabel
{
    return [self addLabel:@""];
}

/**
 当前View添加Label,设置文字
 
 @param text 文字
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text
{
    return [self addLabel:text font:nil color:nil];
}

/**
 当前View添加Label,设置文字、字体
 
 @param text 文字
 @param font 字体
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text font:(nullable UIFont *)font
{
    return [self addLabel:text font:font color:nil];
}

/**
 当前View添加Label,设置文字、颜色
 
 @param text 文字
 @param color 颜色
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text color:(nullable UIColor *)color
{
    return [self addLabel:text font:nil color:color];
}

/**
 当前View添加Label,设置文字、字体、颜色
 
 @param text 文字
 @param font 字体
 @param color 颜色
 @return 返回Label
 */
-(UILabel *)addLabel:(nullable NSString *)text font:(nullable UIFont *)font color:(nullable UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    
    label.text = text;
    [self addSubview:label];
    
    return label;
}

#pragma mark - UITextField Add
/**
 当前UIView添加UITextField
 
 @return 返回一个UITextField
 */
-(UITextField *)addTextField
{
    return [self addTextField:nil];
}

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @return 返回一个UITextField
 */
-(UITextField *)addTextField:(nullable NSString *)text
{
    return [self addTextField:text delegate:nil];
}

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @param delegate Delegate
 @return 返回一个UITextField
 */
-(UITextField *)addTextField:(nullable NSString *)text delegate:(nullable id)delegate
{
    return [self addTextField:text placeholder:nil delegate:delegate];
}

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @param placeholder 提示内容
 @return 返回一个UITextField
 */
-(UITextField *)addTextField:(nullable NSString *)text placeholder:(nullable NSString *)placeholder
{
    return [self addTextField:text placeholder:placeholder delegate:nil];
}

/**
 当前UIView添加UITextField
 
 @param text 文字内容
 @param placeholder 提示内容
 @param delegate Delegate
 @return 返回一个UITextField
 */
-(UITextField *)addTextField:(nullable NSString *)text placeholder:(nullable NSString *)placeholder delegate:(nullable id)delegate
{
    UITextField *tf = [[UITextField alloc]init];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.delegate = delegate;
    tf.text = text;
    tf.placeholder = placeholder;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:tf];
    return tf;
}

#pragma mark - UIButton Add
/**
 当前UIView添加UIButton
 
 @return 返回UIButton对象
 */
-(UIButton *)addButton
{
    return [self addButton:nil];
}

/**
 当前UIView添加UIButton
 
 @param title 默认状态标题
 @return 返回UIButton对象
 */
-(UIButton *)addButton:(nullable NSString *)title
{
    return [self addButton:title target:nil action:nil];
}

/**
 当前UIView添加UIButton
 
 @param title 默认状态标题
 @param target UIControlEventTouchUpInside Target
 @param action UIControlEventTouchUpInside Action
 @return 返回UIButton对象
 */
-(UIButton *)addButton:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

#pragma mark - UITextView Add
/**
 当前UIView添加UITextView
 
 @return 返回UITextView对象
 */
-(UITextView *)addTextView
{
    return [self addTextView:nil];
}

/**
 当前UIView添加UITextView
 
 @param text 文字
 @return 返回UITextView对象
 */
-(UITextView *)addTextView:(nullable NSString *)text
{
    return [self addTextView:text delegate:nil];
}

/**
 当前UIView添加UITextView
 
 @param text 文字
 @param delegate 代理delegate
 @return 返回UITextView对象
 */
-(UITextView *)addTextView:(nullable NSString *)text delegate:(nullable id)delegate
{
    UITextView *textView = [[UITextView alloc]init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.text = text;
    textView.delegate = delegate;
    textView.clearsContextBeforeDrawing = YES;
    [self addSubview:textView];
    
    return textView;
}


#pragma mark - UITextView Add
/**
 当前UIView添加UIScrollView
 
 @return 返回UIScrollView实例对象
 */
-(UIScrollView *)addScrollView:(GJScroll)direction
{
    return [self addScrollView:direction delegate:nil];
}

/**
 当前UIView添加UIScrollView
 
 @param direction 滚动方向
 @param delegate 代理
 @return 返回UIScrollView实例对象
 */
-(UIScrollView *)addScrollView:(GJScroll)direction delegate:(nullable id)delegate
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.pagingEnabled = NO;
    scrollView.delegate = delegate;
    scrollView.bounces = YES;
    scrollView.alwaysBounceHorizontal = direction == GJScrollHorizontal;
    scrollView.alwaysBounceVertical = direction == GJScrollVertical;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    return scrollView;
}

#pragma mark - UIImageView Add
/**
 当前UIView添加UIImage
 
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageView
{
    return [self addImageViewWithImage:nil];
}

/**
 当前UIView添加UIImage
 
 @param imageName image名称
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageViewWithName:(nullable NSString *)imageName
{
    return [self addImageViewWithImage:imageName ? [UIImage imageNamed:imageName] : nil];
}


/**
 当前UIView添加UIImage
 
 @param image image对象
 @return 返回UIImageView实例对象
 */
-(UIImageView *)addImageViewWithImage:(nullable UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (image) {
        imageView.image = image;
    }
    [self addSubview:imageView];
    return imageView;
}

#pragma mark - UISlider Add
/**
 当前UIView添加UISlider
 
 @return 返回UISlider实例对象
 */
-(UISlider *)addSlider
{
    return [self addSlider:nil action:nil];
}

/**
 当前UIView添加UISlider
 
 @param target 代理对象
 @param action action
 @return 返回UISlider实例对象
 */
-(UISlider *)addSlider:(nullable id)target action:(nullable SEL)action
{
    UISlider *slider = [[UISlider alloc] init];
    if (target && action) {
        [slider addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    [self addSubview:slider];
    return slider;
}

#pragma mark - UISwitch Add
/**
 当前UIView添加UISwitch
 
 @return 返回UISwitch实例对象
 */
-(UISwitch *)addSwitch
{
    return [self addSwitch:nil action:nil];
}

/**
 当前UIView添加UISwitch
 
 @param target 代理对象
 @param action action
 @return 返回UISwitch实例对象
 */
-(UISwitch *)addSwitch:(nullable id)target action:(nullable SEL)action
{
    UISwitch *s = [[UISwitch alloc] init];
    if (target && action) {
        [s addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    [self addSubview:s];
    
    return s;
}

#pragma mark - UITableView Add
/**
 当前UIView添加UITableView
 
 @return 返回UITableView实例对象
 */
-(UITableView *)addTableView:(UITableViewStyle)style
{
    return [self addTableView:style delegate:nil];
}

/**
 当前UIView添加UITableView
 
 @param delegate 代理对象
 @return 返回UITableView实例对象
 */
-(UITableView *)addTableView:(UITableViewStyle)style delegate:(nullable id)delegate;
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
    if (delegate) {
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
    }
    tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - UICollectionView Add
/**
 当前UIView添加UISwitch
 
 @return 返回UICollectionView实例对象
 */
-(UICollectionView *)addCollectionView:(GJScroll)direction
{
    return [self addCollectionView:direction delegate:nil];
}

/**
 当前UIView添加UISwitch
 
 @param direction 滚动方向
 @param delegate 代理对象
 @return 返回UICollectionView实例对象
 */
-(UICollectionView *)addCollectionView:(GJScroll)direction delegate:(nullable id)delegate
{
    //初始化
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    if (direction == GJScrollHorizontal) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else if (direction == GJScrollVertical){
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    if (delegate) {
        view.delegate = delegate;
        view.dataSource = delegate;
    }
    view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    
    return view;
}

#pragma mark - UIPageControl Add

/**
 当前UIView添加UIPageControl
 
 @return 返回UIPageControl实例对象
 */
-(UIPageControl *)addPageControl
{
    return [self addPageControl:nil action:nil];
}

/**
 当前UIView添加UISwitch
 
 @param target 代理对象
 @param action action
 @return 返回UISwitch实例对象
 */
-(UIPageControl *)addPageControl:(nullable id)target action:(nullable SEL)action
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    if (target && action) {
        [pageControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    [self addSubview:pageControl];
    
    return pageControl;
}

@end
