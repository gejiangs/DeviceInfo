//
//  SystemManager.h
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemManager : NSObject

@property (nonatomic, copy)     NSString *token;

+(instancetype)manager;

-(void)configDeviceToken:(NSData *)deviceToken;

/**
 配置信息
 
 @param launchOptions 系统参数
 */
-(void)configWithLaunch:(NSDictionary *)launchOptions;

-(void)handlerNotificationWithInfo:(NSDictionary *)userInfo;

/**
 处理消息跳转

 @param value 消息值
 @param type 消息类型
 */
-(void)pushMessageValue:(NSString *)value type:(NSString *)type;

/**
 打开在线客服
 */
-(void)showServiceViewController;

@end
