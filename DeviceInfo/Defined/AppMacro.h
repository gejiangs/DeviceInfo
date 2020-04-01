//
//  AppMarco.h
//  GoodsWhite
//
//  Created by guojiang on 14-5-13.
//  Copyright (c) 2014年 GoodsWhite. All rights reserved.
//

#ifndef GoodsWhite_AppMarco_h
#define GoodsWhite_AppMarco_h


#pragma mark - 发布有关的设置

#define AppVersionNumber                    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppName                             [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
#define DeviceName                          [[UIDevice currentDevice] name]
#define DeviceModel                         [[UIDevice currentDevice] systemName]
#define DeviceVersion                       [[UIDevice currentDevice] systemVersion]
#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define WINDOW                              ApplicationDelegate.window
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define Phone3_5                            ScreenHeight == 480
#define Phone4_0                            ScreenHeight == 568
#define Phone4_7                            ScreenHeight == 667
#define Phone5_5                            ScreenHeight == 736
#define iPhoneX                             (ScreenWidth == 812 || ScreenHeight == 812)
#define iPhoneXMax                          (ScreenWidth == 896 || ScreenHeight == 896)
#define iPhoneX_Device \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define iOS7Later                           (IOSVersion >= 7.0)
#define iOS8Later                           (IOSVersion >= 8.0)
#define iOS9Later                           (IOSVersion >= 9.0)
#define iOS10Later                          (IOSVersion >= 10.0)
#define iOS11Later                          (IOSVersion >= 11.0)
#define LangKey(key)                        NSLocalizedString(key, nil)
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)
#define IntNumber(i)                        [NSNumber numberWithInt:i]
#define IntegerNumber(i)                    [NSNumber numberWithInteger:i]
#define FloatNumber(f)                      [NSNumber numberWithFloat:f]
#define DoubleNumber(dl)                    [NSNumber numberWithDouble:dl]
#define BoolNumber(b)                       [NSNumber numberWithBool:b]

#define StringNotEmpty(str)                 (str && (str.length > 0))
#define StringIsEmpty(str)                  (!str || (str.length == 0))
#define ArrayNotEmpty(arr)                  (arr && (arr.count > 0))
#define URLFromString(str)                  [NSURL URLWithString:str]

#define AppColorTabBar                      RGB(1, 126, 192)
#define AppColorGreen                       RGB(55,155,14)
#define AppColorBlue                        RGB(1, 126, 192)
#define AppColorOrange                      RGB(255,182,0)
#define AppColorGrayDark                    RGB(51, 51, 51)                 //深灰
#define AppColorGrayMiddle                  RGB(102, 102, 102)              //中灰
#define AppColorGrayLow                     RGB(137, 137, 137)              //小灰
#define AppColorGrayLight                   RGB(186, 186, 186)              //浅灰
#define AppColorWhiteGray                   RGB(249, 249, 249)              //白灰
#define AppColorViceText                    RGB(160, 160, 160)              //副文字颜色
#define AppColorBoxBG                       RGB(244, 244, 244)              //背景

#define AppColorTheme                       RGB(255, 255, 255)               //导航主题颜色
#define AppColorMain                        RGB(255, 255, 255)               //view背景颜色
#define AppColorMainText                    RGB(41,  41, 41)                 //主文字颜色
#define AppColorTabBarText                  RGB(98, 98, 98)                  //Tabbar未选择颜色
#define AppColorGrayText                    RGB(112, 112, 112)              //灰色文字
#define AppColorRed                         RGB(254, 05, 29)
#define AppColorShadow                      RGB(239, 239, 239)
#define AppColorGray                        RGB(155, 155, 155)              //灰色文字
#define AppColorSplitLine                   RGBA(245, 245, 245, 1)             //分割线颜色

#define WEAKSELF                            __weak      __typeof(self)      weakSelf = self;
#define STRONGSELF                          __strong    __typeof(weakSelf)  strongSelf = weakSelf;


//自定义宏输出
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog(@"<%s> %@",__FUNCTION__,[NSString stringWithFormat:fmt, ##__VA_ARGS__]);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif


#endif
