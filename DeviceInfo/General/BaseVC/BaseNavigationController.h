//
//  BaseNavigationController.h
//  wook
//
//  Created by guojiang on 5/8/14.
//  Copyright (c) 2014年 guojiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

//启动返回手势
-(void)enablePopGesture;
//禁用返回手势
-(void)disablePopGesture;

@end
