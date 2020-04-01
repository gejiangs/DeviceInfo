//
//  DottedLineView.m
//  BMJapan
//
//  Created by 郭江 on 2017/7/12.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "DottedLineView.h"

@interface DottedLineView()


@end

@implementation DottedLineView

-(id)initWithColor:(UIColor *)color
{
    if (self = [super init]) {
        _lineColor = color;
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init]) {
        _lineColor = [UIColor blackColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _lineColor = [UIColor blackColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();//获取绘图用的图形上下文
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充色设置成
    CGFloat lengths[] = {2};
    CGContextSetLineDash(context, 4, lengths,1);
    
    CGContextFillRect(context,self.bounds);//把整个空间用刚设置的颜色填充
    //上面是准备工作，下面开始画线了
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);//设置线的颜色
    CGContextMoveToPoint(context,0,0);//画线的起始点位置
    
    //水平虚线
    if (self.frame.size.width > self.frame.size.height) {
        CGContextAddLineToPoint(context,self.frame.size.width, 0);//画第一条线的终点位置
    }
    //垂直虚线
    else{
        CGContextAddLineToPoint(context,0,self.frame.size.height);//画第一条线的终点位置
    }
    
    CGContextStrokePath(context);//把线在界面上绘制出来
}

@end
