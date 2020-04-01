//
//  SystemManager.m
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "SystemManager.h"
#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"
#import <UserNotifications/UserNotifications.h>
#import "UMessage.h"
#import "IQKeyboardManager.h"

@interface SystemManager ()<UNUserNotificationCenterDelegate>


@end

@implementation SystemManager

+ (instancetype)manager
{
    static id share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      share = [[self alloc] init];
                  });
    return share;
}

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}

-(NSString *)token
{
    return StringIsEmpty(_token) ? @"" : _token;
}

-(void)configDeviceToken:(NSData *)deviceToken
{
    NSString *token = @"";
    if (@available(iOS 13, *)) {
        const unsigned *tokenBytes = [deviceToken bytes];
        token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    } else {
        token = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    }
    
    NSLog(@"deviceToken=====%@",token);
    
    _token = token;
}

/**
 配置信息
 
 @param launchOptions 系统参数
 */
-(void)configWithLaunch:(NSDictionary *)launchOptions
{
    [self registerNotificationSetting];
    [self registerUmengConfig:launchOptions];
}

//注册友盟配置
-(void)registerUmengConfig:(NSDictionary *)launchOptions
{
    UMConfigInstance.appKey = UmengAppkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:AppVersionNumber];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    //友盟通知
    [UMessage startWithAppkey:UmengAppkey launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
}


-(void)registerNotificationSetting
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //必须写代理，不然无法监听通知的接收与点击事件
    center.delegate = self;
    UNAuthorizationOptions types=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error && granted) {
            //用户点击允许
            NSLog(@"注册成功");
        }else{
            //用户点击不允许
            NSLog(@"注册失败");
        }
    }];
}

//处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (userInfo != nil) {
        [self handlerNotificationWithInfo:userInfo];
    }
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (userInfo != nil) {
        [self handlerNotificationWithInfo:userInfo];
    }
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }    
}

#pragma mark Post url
-(void)postWithUrlString:(NSString *)urlString params:(NSDictionary *)params block:(void(^)(BOOL succ,id obj))block
{
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *key in params.allKeys) {
        [values addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    NSString *body = [values componentsJoinedByString:@"&"];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            BOOL success = [[dict objectForKey:@"code"] intValue] == 0;
            if (block) {
                block(success, dict);
            }
        }else{
            if (block) {
                block(NO, error);
            }
        }
        
    }];
}

//处理推送消息
-(void)handlerNotificationWithInfo:(NSDictionary *)userInfo
{
    NSString *type = [[userInfo objectForKey:@"type"] trim];
    NSString *value = [[userInfo objectForKey:@"value"] trim];
    
    [self dispatchTimerWithTime:0.3 block:^{
        [self pushMessageValue:value type:type];
    }];
}

/**
 处理消息跳转
 
 @param value 消息值
 @param type 消息类型
 */
-(void)pushMessageValue:(NSString *)value type:(NSString *)type
{
    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    UITabBarController *tabBarVC = (UITabBarController *)window.rootViewController;
    UINavigationController *naviVC = (UINavigationController *)tabBarVC.selectedViewController;
    //异常处理
    if (![type isKindOfClass:[NSString class]]) {
        return;
    }
    //去空格，转小写
    type = [[type trim] lowercaseString];
    
    //网络链接
    if ([type isEqualToString:@"url"]){
        //做参数兼容处理
        NSString *split = [value rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
        NSString *urlString = [NSString stringWithFormat:@"%@%@x_token=0", value, split];
        [RouterHandler openKey:RouterKeyWebLink scopeVC:naviVC.topViewController info:@{@"urlString":urlString}];
    }
}

#pragma mark - lazy
@end
