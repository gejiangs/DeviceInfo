//
//  UIColor+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)
#pragma mark --颜色相关方法
//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) hexString: (NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    unsigned int red,green,blue;
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    [[NSScanner scannerWithString:[cString substringWithRange:range]] scanHexInt:&red];
    //g
    range.location = 2;
    [[NSScanner scannerWithString:[cString substringWithRange:range]] scanHexInt:&green];
    //b
    range.location = 4;
    [[NSScanner scannerWithString:[cString substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

//颜色转换 UIColor转成十六进制hexData值
+ (NSData *)hexDataWithRGBColor:(UIColor *)color {
    Byte byteColor[3];
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    for (int i=0; i<3; i++) {
        byteColor[i] = cs[i] * 255;
    }
    NSData *data = [NSData dataWithBytes:byteColor length:3];
    return data;
}


@end
