//
//  NSString+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)

//字符串去空格
-(NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (BOOL)checkEmpty{
    return [[self trim] isEqualToString:@""];
}

#pragma mark --长度宽度相关方法

//方法功能：根据字体大小与限宽，计算高度
-(CGFloat)getHeightWithFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    return [self getHeightWithFont:[UIFont systemFontOfSize:fontSize] maxWidth:maxWidth];
}

-(CGFloat)getHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return [self getSizeWithFont:font size:CGSizeMake(maxWidth, MAXFLOAT)].height;
}

//方法功能：根据字体大小与限高，计算宽度
-(CGFloat)getWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight
{
    return [self getWidthWithFont:[UIFont systemFontOfSize:fontSize] maxHeight:maxHeight];
}

-(CGFloat)getWidthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    return [self getSizeWithFont:font size:CGSizeMake(MAXFLOAT, maxHeight)].width;
}

-(CGSize)getSizeWithFont:(UIFont *)font size:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                           attributes:attribute context:nil].size;
}


#pragma mark --时间相关方法
// 方法功能：时间戳
+ (NSString *)getTimeStamp{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
// 获取格式化时间时间戳
- (NSString *)getTimeStampString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:self];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
//取得格式化时间
-(NSString *)getDateTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateTimeStr = [dateFormatter stringFromDate:date];
    return dateTimeStr;
}
//取得日期
-(NSString *)getDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

// 手机号码隐藏处理(加星号处理)
-(NSString *)securePhoneNumber{
    
    NSString *regular=@"(?<=\\d{3})\\d(?=\\d{4})";
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regular options:0 error:nil];
    
    NSString *content=self;
    content  = [regularExpression stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@"*"];
    
    return content;
}

// Dictionary 转 Json String
+(NSString *)dictionaryToJsonString:(NSDictionary *)dic;
{
    if (dic==nil) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //NSLog(@"JSON String = %@", jsonString);
    return jsonString;
}

// 十六进制转换为普通字符串的。
- (NSString *)stringFromHexString
{
    NSString *hexString = self;
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}

//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString
{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (NSData*)hexToBytesWithString
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
//16进制字符串转10进制字符串
- (NSString *)turn16to10
{
    NSString *upperString = [self uppercaseString];
    NSTimeInterval sum = 0;
    for (int i = 0; i < upperString.length; i++) {
        sum *= 16;
        char c = [upperString characterAtIndex:i] ;
        if (c >= 'A') {
            sum += c - 'A' + 10;
        }else{
            sum += c - '0';
        }
    }
    return [NSString stringWithFormat:@"%.0lf",sum];
}

//10进制字符串转16进制字符串
- (NSString *) turn10to16
{
    int num = [self intValue];
    NSMutableString * result = [[NSMutableString alloc]init];
    while (num > 0) {
        int a = num % 16;
        char c;
        
        if (a > 9) {
            c = 'a' + (a - 10);
        }else{
            c = '0' + a;
        }
        NSString * reminder = [NSString stringWithFormat:@"%c",c];
        [result insertString:reminder atIndex:0];
        num = num / 16;
    }
    return result;
}

//处理蓝牙UUID
-(NSString *)convertUUID
{
    NSArray *array = [self componentsSeparatedByString:@"-"];
    NSMutableArray *newArray = [NSMutableArray array];
    NSInteger count = MIN(3, [array count]);
    for (int i=0; i<count; i++) {
        [newArray addObject:[array objectAtIndex:i]];
    }
    return [newArray componentsJoinedByString:@"-"];
}

//验证邮箱
-(BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//验证手机号（简单的验证11位数字就行）
-(BOOL)validPhone
{
    NSString *emailRegex = @"[0-9]{11}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
