//
//  AutoCheckScreenDisplayView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/8.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckScreenDisplayView.h"
#import "CustomAlertView.h"

@interface AutoCheckScreenDisplayView ()

@property (nonatomic, strong)               UILabel *titleLabel;
@property (nonatomic, assign)               NSInteger step;
@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, copy, nullable)       void(^checkBlock)(BOOL normal);

@end

@implementation AutoCheckScreenDisplayView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.step = 0;
    self.backgroundColor = [UIColor hexString:@"#FF4E00"];
    self.titleLabel = [self addLabel:@"点击屏幕切换背景颜色\n请着重检查亮点、坏点、漏光等问题" font:[UIFont systemFontOfSize:13] color:[UIColor blackColor]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.centerX.equalTo(self);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

-(void)setStep:(NSInteger)step
{
    _step = step;
    if (step == 1) {
        self.backgroundColor = [UIColor hexString:@"#FFFFFF"];
    }else if(step == 2){
        self.backgroundColor = [UIColor hexString:@"#15EE15"];
    }else if(step == 3){
        self.backgroundColor = [UIColor hexString:@"#1C54F4"];
    }
}

-(void)tapAction
{
    if (self.step == 0) {
        self.step = 1;
    }else if (self.step == 1){
        self.step = 2;
    }else if (self.step == 2){
        self.step = 3;
        [self showResultAlertView];
    }
}


-(void)show:(BOOL)show
{
    self.isShow = show;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.isShow == NO) {
            [self removeFromSuperview];
        }
    }];
}


- (void)updateConstraints
{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(ScreenHeight);
        if (self.isShow) {
            make.top.offset(0);
        }else{
            make.top.offset(ScreenHeight);
        }
    }];
    
    [super updateConstraints];
}

-(void)showResultAlertView
{
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:@"" message:@"屏幕显示是否正常？" cancel:@"异常" sure:@"正常"];
    [alertView showWithCancelBlock:^{
        if (self.checkBlock) {
            self.checkBlock(NO);
        }
        [self show:NO];
    } sureBlock:^{
        if (self.checkBlock) {
            self.checkBlock(YES);
        }
        [self show:NO];
    }];
}

+(void)showInView:(UIView *)view block:(nullable void (^)(BOOL))block
{
    AutoCheckScreenDisplayView *checkView = [[AutoCheckScreenDisplayView alloc] init];
    checkView.checkBlock = block;
    [view addSubview:checkView];
    [self dispatchTimerWithTime:0.1 block:^{
        [checkView show:YES];
    }];
}

@end
