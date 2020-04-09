//
//  AutoCheckTouchView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/8.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckTouchView.h"

@interface AutoCheckTouchView ()

@property (nonatomic, strong)               NSMutableArray *imageArray;
@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, copy, nullable)       void(^checkBlock)(BOOL normal);

@end

@implementation AutoCheckTouchView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor= [UIColor lightGrayColor];
    CGFloat rowCount    = 13.f;
    CGFloat colsCount   = 7.f;
    CGFloat top         = iPhoneX_Device ? 34 : 10;
    CGFloat bottom      = iPhoneX_Device ? 24 : 10;
    CGFloat left_space  = 15;
    CGFloat width       = (ScreenWidth - left_space*(colsCount+1))/colsCount;
    CGFloat top_space   = (ScreenHeight - top - bottom - width*2 - width * (rowCount-2))/(rowCount-1);
    
    self.imageArray     = [NSMutableArray array];
    
    //横
    for (int i=0; i<3; i++) {
        for (int j=0; j<colsCount; j++) {
            CGFloat x = (left_space + width)*j + left_space;
            CGFloat y = top;
            if (i == 0) {
                y = top;
            }else if (i == 1){
                y = (ScreenHeight - top - bottom - width)/2.f + top;
            }else if (i == 2){
                y = ScreenHeight - bottom - width;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
            imageView.image = [UIImage imageNamed:@"checking_lamp_off"];
            imageView.highlightedImage = [UIImage imageNamed:@"checking_lamp_on"];
            [self addSubview:imageView];
            [self.imageArray addObject:imageView];
        }
    }
    //竖
    for (int i=0; i<3; i++) {
        for (int j=0; j<rowCount; j++) {
            if (j == 0 || j == 6 || j == 12) {
                continue;
            }
            CGFloat x = left_space;
            CGFloat y = top + (top_space + width)*j;
            if (i == 0) {
                x = left_space;
            }else if (i == 1){
                x = (ScreenWidth - width)/2.f;
            }else if (i == 2){
                x = ScreenWidth - left_space - width;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
            imageView.image = [UIImage imageNamed:@"checking_lamp_off"];
            imageView.highlightedImage = [UIImage imageNamed:@"checking_lamp_on"];
            [self addSubview:imageView];
            [self.imageArray addObject:imageView];
        }
    }
    
    UIButton *abnormalButton = [self addButton:@"异常" target:self action:@selector(abnormalAction)];
    [abnormalButton setTitleColor:AppColorRed forState:UIControlStateNormal];
    abnormalButton.layer.cornerRadius = 5;
    abnormalButton.layer.masksToBounds = YES;
    abnormalButton.layer.borderColor = AppColorRed.CGColor;
    abnormalButton.layer.borderWidth = 0.5;
    [abnormalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-width-left_space-10);
        make.size.equalTo(CGSizeMake(100, 40));
        make.bottom.offset(-100);
    }];
}

+(void)showInView:(UIView *)view block:(nullable void (^)(BOOL))block
{
    AutoCheckTouchView *checkView = [[AutoCheckTouchView alloc] init];
    checkView.checkBlock = block;
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
//    [self dispatchTimerWithTime:0.1 block:^{
//        [checkView show:YES];
//    }];
}

-(void)abnormalAction
{
    if (self.checkBlock) {
        self.checkBlock(NO);
    }
    [self removeFromSuperview];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        for (UIImageView *imageView in self.imageArray) {
            if (CGRectContainsPoint(imageView.frame, point)) {
                imageView.highlighted = YES;
            }
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BOOL isTouchAll = YES;
    for (UIImageView *imageView in self.imageArray) {
        if (!imageView.isHighlighted) {
            isTouchAll = NO;break;
        }
    }
    if (isTouchAll) {
        if (self.checkBlock) {
            self.checkBlock(YES);
        }
        [self removeFromSuperview];
    }
}

@end
