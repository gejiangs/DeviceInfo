//
//  CustomAlertView.h
//  SmartStick
//
//  Created by jon on 2020/2/7.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView

-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
            cancel:(NSString *)cancel
              sure:(NSString *)sure;

-(id)initWithTitleAttribute:(NSAttributedString *)titleAttribute
           messageAttribute:(NSAttributedString *)messageAttribute
            cancelAttribute:(NSAttributedString *)cancelAttribute
              sureAttribute:(NSAttributedString *)sureAttribute;

-(void)showWithCancelBlock:(void(^)(void))cancelBlock
                 sureBlock:(void(^)(void))sureBlock;

-(void)showWithSureBlock:(void(^)(void))sureBlock;
@end

NS_ASSUME_NONNULL_END
