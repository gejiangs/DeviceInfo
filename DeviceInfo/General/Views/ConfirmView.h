//
//  ConfirmView.h
//  WhiteGoods
//
//  Created by jon on 2019/6/13.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmView : UIView

-(id)initWithAlertView:(NSString *)content;

-(id)initWithWaitView:(NSString *)content;

-(id)initWithTipView:(NSString *)content button:(NSString *)button;

-(void)showInView:(UIView *)view;

-(void)showInView:(UIView *)view block:(nullable void(^)(void))block;


@end

NS_ASSUME_NONNULL_END
