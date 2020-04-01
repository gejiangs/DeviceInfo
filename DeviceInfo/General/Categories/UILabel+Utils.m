//
//  UIView+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

//给label指定text的颜色、字体
-(void)addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text font:font];
}

//给label指定text的颜色、字体大小(系统字体)
-(void)addAttributesText:(NSString *)text color:(UIColor *)color fontSize:(int)fontSize
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text fontSize:fontSize];
}

//给label指定text的颜色
-(void)addAttributesText:(NSString *)text color:(UIColor *)color
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSForegroundColorAttributeName:color} range:range];
        self.attributedText = mat;
    }
}

////给label指定text的颜色
//-(void)addAttributesText:(NSString *)text color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing
//{
//    NSRange range = [[self.attributedText string] rangeOfString:text];
//    if(range.location != NSNotFound)
//    {
//        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
//        [mat addAttributes:@{NSForegroundColorAttributeName:color} range:range];
//        self.attributedText = mat;
//    }
//}

//给label指定text的字体
-(void)addAttributesText:(NSString *)text fontSize:(int)fontSize
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:range];
        self.attributedText = mat;
    }
}

//给label指定text的字体(系统字体)
-(void)addAttributesText:(NSString *)text font:(UIFont *)font
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:font} range:range];
        self.attributedText = mat;
    }
}

/**
 设置文本,并指定行间距
 
 @param lineSpacing 行间距
 */
-(void)setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [self.attributedText mutableCopy];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}
@end
