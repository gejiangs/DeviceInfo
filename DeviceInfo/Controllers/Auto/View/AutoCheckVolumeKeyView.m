//
//  AutoCheckVolumeKeyView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/3.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckVolumeKeyView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AutoCheckVolumeKeyView ()

@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, strong)               UIView *bgView;
@property (nonatomic, strong)               UILabel *volumeLabel;
@property (nonatomic, strong)               UIImageView *imageView;
@property (nonatomic, copy, nullable)       void(^checkPlusBlock)(BOOL normal);
@property (nonatomic, copy, nullable)       void(^checkSubBlock)(BOOL normal);
@property (nonatomic, assign)               CGFloat currentVolume;
@end

@implementation AutoCheckVolumeKeyView

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
        make.top.offset(20);
    }];
    
    self.imageView = [contentView addImageView];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_volumeLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    UIButton *backButton = [contentView addButton:@"异常" target:self action:@selector(backAction)];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageWithColor:AppColorGrayLow] forState:UIControlStateNormal];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(40);
    }];
        
    self.currentVolume = [AVAudioSession sharedInstance].outputVolume;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeDidChange:)name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)volumeDidChange:(NSNotification *)notification
{
    CGFloat volume = [[notification.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    if (volume >= self.currentVolume) {
        self.currentVolume = volume;
        if (self.checkPlusBlock) {
            self.checkPlusBlock(YES);
            [self removeFromSuperview];
        }
    }else{
        self.currentVolume = volume;
        if (self.checkSubBlock) {
            self.checkSubBlock(YES);
            [self removeFromSuperview];
        }
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

+(void)showInView:(UIView *)view plusObserverBlock:(nullable void (^)(BOOL))block
{
    AutoCheckVolumeKeyView *checkView = [[AutoCheckVolumeKeyView alloc] init];
    checkView.checkPlusBlock = block;
    checkView.volumeLabel.text = @"请按音量“+”键";
    checkView.imageView.image = [UIImage imageNamed:@"checking_volume_big"];
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    [self dispatchTimerWithTime:0.1 block:^{
        [checkView show:YES];
    }];
}

+(void)showInView:(UIView *)view subObserverBlock:(void (^)(BOOL))block
{
    AutoCheckVolumeKeyView *checkView = [[AutoCheckVolumeKeyView alloc] init];
    checkView.checkSubBlock = block;
    checkView.volumeLabel.text = @"请按音量“-”键";
    checkView.imageView.image = [UIImage imageNamed:@"checking_volume_small"];
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
    if (self.checkPlusBlock) {
        self.checkPlusBlock(NO);
        [self removeFromSuperview];
    }
    if (self.checkSubBlock) {
        self.checkSubBlock(NO);
        [self removeFromSuperview];
    }
}

-(void)dealloc
{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

@end
