//
//  UIColor+Utils.m
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)


//取得格式化时间
-(NSString *)getDateTimeString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTimeStr = [dateFormatter stringFromDate:self];
    return dateTimeStr;
}
//取得日期
-(NSString *)getDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

//取得日期
-(NSString *)getYmdDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

//获取时、分、秒
-(NSString *)getDateHMSString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString  *dateString = [formatter stringFromDate:self];
    return dateString;
}

//获取昨天的日期
-(NSString *)getYesterdayDateString
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:([components day]-1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

//获取明天的日期
-(NSString *)getTomorrowDateString
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

//获取星期
-(NSString *)getWeekString
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    int weekday = (int) [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
    if (weekday == 1) {
        return @"星期日";
    }
    
    else if (weekday == 2){
        return @"星期一";
    }
    
    else if (weekday == 3){
        return @"星期二";
        
    }
    else if (weekday == 4){
        return @"星期三";
    }
    
    else if (weekday == 5){
        return @"星期四";
    }
    
    else if (weekday == 6){
        return @"星期五";
    }
    
    else if (weekday == 7){
        return @"星期六";
        
    }
    return @"";
}

@end
