//
//  UIColor+Utils.h
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (Utils)


/**
 *  获取日期 yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期值
 */
- (NSString *)getDateTimeString;

/**
 *  获取日期 yyyy-MM-dd
 *
 *  @return 日期值
 */
- (NSString *)getDateString;

//取得日期
-(NSString *)getYmdDateString;

/**
 *  获取日期 HH:mm:ss
 *
 *  @return 时间值
 */
- (NSString *)getDateHMSString;     


/**
 *  获取昨天的日期
 *
 *  @return 时间值
 */
-(NSString *)getYesterdayDateString;

/**
 *  获取明天的日期
 *
 *  @return 时间值
 */
-(NSString *)getTomorrowDateString;

/**
 *  获取星期 （星期xx）
 *
 *  @return 星期xx
 */
-(NSString *)getWeekString;

@end
