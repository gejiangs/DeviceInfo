//
//  AutoCheckProximityMonitorView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckProximityMonitorView.h"

@interface AutoCheckProximityMonitorView ()

@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, strong)               UIView *bgView;
@property (nonatomic, copy, nullable)       void(^checkBlock)(BOOL normal);

@end

@implementation AutoCheckProximityMonitorView

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
        make.left.right.offset(0);
        make.height.equalTo(self.mas_height);
        make.top.offset(0);
    }];
    
    self.bgView = bgView;
    
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(250);
        make.height.offset(350);
        make.center.equalTo(self.bgView);
    }];
        
    UILabel *textLabel= [contentView addLabel:@"使用手遮住前摄像头位置" font:[UIFont systemFontOfSize:16] color:AppColorGreen];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
    //开启监听距离感应的通知
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    //监听是否遮住
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)proximityChange:(NSNotificationCenter *)notification
{
    if ([UIDevice currentDevice].proximityState == YES) {
        NSLog(@"某个物体靠近了设备屏幕"); // 屏幕会自动锁住        
    } else {
        NSLog(@"某个物体远离了设备屏幕"); // 屏幕会自动解锁
        [self handResultNormal:YES];
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
    AutoCheckProximityMonitorView *checkView = [[AutoCheckProximityMonitorView alloc] init];
    checkView.checkBlock = block;
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
    [self handResultNormal:NO];
}

-(void)handResultNormal:(BOOL)normal
{
    if (self.checkBlock) {
        self.checkBlock(normal);
    }
    [self removeFromSuperview];
}

-(void)dealloc
{
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
