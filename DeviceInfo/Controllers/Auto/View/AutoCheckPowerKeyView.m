//
//  AutoCheckPowerKeyView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/9.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckPowerKeyView.h"

@interface AutoCheckPowerKeyView ()

@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, strong)               UIView *bgView;
@property (nonatomic, strong)               UILabel *volumeLabel;
@property (nonatomic, copy, nullable)       void(^block)(BOOL normal);
@property (nonatomic, assign)               CGFloat currentVolume;
@end

@implementation AutoCheckPowerKeyView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.bgView = bgView;
    
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(250);
        make.height.offset(350);
        make.center.equalTo(bgView);
    }];
        
    self.volumeLabel = [contentView addLabel:@"" font:[UIFont systemFontOfSize:16] color:AppColorGreen];
    [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.offset(50);
    }];
    
    UIButton *backButton = [contentView addButton:@"异常" target:self action:@selector(backAction)];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageWithColor:AppColorGrayLow] forState:UIControlStateNormal];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(40);
    }];
    
    //监听锁屏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkComplate) name:@"NofiApplicationScreenLocked" object:nil];
}

-(void)checkComplate
{
    if (self.block) {
        self.block(YES);
    }
    [self show:NO];
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
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
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

+(void)showInView:(UIView *)view block:(nullable void (^)(BOOL))block
{
    AutoCheckPowerKeyView *checkView = [[AutoCheckPowerKeyView alloc] init];
    checkView.block = block;
    checkView.volumeLabel.text = @"请按电源键";
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    [self dispatchTimerWithTime:0.1 block:^{
        [checkView show:YES];
    }];
}

-(void)backAction
{
    if (self.block) {
        self.block(NO);
        [self removeFromSuperview];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
