//
//  WebLinkRouter.m
//  WhiteGoods
//
//  Created by gejiangs on 2020/2/21.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "WebRouter.h"
#import <MGJRouter/MGJRouter.h>

@implementation WebRouter

+(void)load
{
    [MGJRouter registerURLPattern:RouterKeyWebLink toHandler:^(NSDictionary *routerParameters) {
        NSDictionary *params = routerParameters[MGJRouterParameterUserInfo];
        UIViewController *skipVC = params[RouterKeyController];
        NSString *toVcName = @"BaseWebViewController";
        if (skipVC == nil || [NSStringFromClass([skipVC class]) isEqualToString:toVcName]) {
            return ;
        }
        
        RouterSkipStyle style = RouterSkipStylePush;
        if (params[RouterKeySkipStyle]) {
            style = [params[RouterKeySkipStyle] integerValue];
        }
        BOOL animated = YES;
        if (params[RouterKeyAnimated]) {
            style = [params[RouterKeyAnimated] boolValue];
        }
        
        UIViewController *toVC = [[NSClassFromString(toVcName) alloc] init];
        [toVC setValue:params[@"urlString"] forKey:@"urlString"];
        if (params[@"title"]) {
            toVC.title = params[@"title"];
        }
        
        [self skipVC:skipVC toVC:toVC styke:style animated:animated];
    }];
}

@end
