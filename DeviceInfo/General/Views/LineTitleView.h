//
//  LineTitleView.h
//  WhiteGoods
//
//  Created by gejiangs on 2019/6/20.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    LineTitleStyleDefault,      //默认，只能显示文字，没有点击效果
    LineTitleStyleRight,        //右方向
    LineTitleStyleDown,         //下方向图标
    LineTitleStyleUp,           //上方向图标
    LineTitleStyleRightDown,    //右下方向图标
    LineTitleStyleRightUp       //右上方向图标
}LineTitleStyle;

NS_ASSUME_NONNULL_BEGIN

@interface LineTitleView : UIView

-(id)initWithTitle:(NSString *)title;

-(id)initWithStyle:(LineTitleStyle)style title:(nullable NSString *)title;

@property (nonatomic, assign)   LineTitleStyle style;
@property (nonatomic, copy)     NSString *title;

-(void)touchBlock:(nullable void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
