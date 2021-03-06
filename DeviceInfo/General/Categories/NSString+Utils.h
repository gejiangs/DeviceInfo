//
//  NSString+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//字符串去空格
- (NSString *)trim;
/// 判断字符串是否为空

- (BOOL)checkEmpty;
//指定字体，宽度获取字符串高度
-(CGFloat)getHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
-(CGFloat)getHeightWithFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

//指定字体，高度获取字符串宽度
-(CGFloat)getWidthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;
-(CGFloat)getWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight;

//指定大小，高度获取字符串大小
-(CGSize)getSizeWithFont:(UIFont *)font size:(CGSize)size;

+ (NSString *)getTimeStamp; // 获取时间戳
- (NSString *)getTimeStampString; // 获取格式化时间时间戳
- (NSString *)getDateTimeString;//取得格式化时间
- (NSString *)getDateString;//取得日期

// 手机号码隐藏处理(加星号处理)
-(NSString *)securePhoneNumber;

// Dictionary 转 Json String
+(NSString *)dictionaryToJsonString:(NSDictionary *)dic;

// 十六进制转换为普通字符串的。
- (NSString *)stringFromHexString;

//16进制字符串转10进制字符串
- (NSString *)turn16to10;

//10进制字符串转16进制字符串
- (NSString *)turn10to16;

//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString;

//16进制字符串转data
- (NSData*)hexToBytesWithString;

//处理蓝牙UUID
-(NSString *)convertUUID;

//验证邮箱
-(BOOL) validateEmail;

//验证手机号（简单的验证11位数字就行）
-(BOOL)validPhone;

@end
