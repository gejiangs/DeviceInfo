//
//  AutoCheckCameraView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/7.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckCameraView.h"
#import <AVFoundation/AVFoundation.h>

@interface AutoCheckCameraView ()

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;
//输出图片
@property (nonatomic ,strong) AVCapturePhotoOutput *imageOutput;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, copy, nullable)       void(^checkBlock)(BOOL normal);

@end

@implementation AutoCheckCameraView

-(id)initWithFront
{
    if (self = [super init]) {
        [self initUIWithPostion:AVCaptureDevicePositionFront];
    }
    return self;
}

-(id)initWithBack
{
    if (self = [super init]) {
        [self initUIWithPostion:AVCaptureDevicePositionBack];
    }
    return self;
}

- (void)initUIWithPostion:(AVCaptureDevicePosition)position
{
//    AVCaptureDevicePositionBack  后置摄像头
//    AVCaptureDevicePositionFront 前置摄像头
    self.device = [self cameraWithPosition:position];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
    
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-100);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.previewLayer];
    //设备取景开始
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = AppColorGrayLight;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(150);
    }];
    
    UILabel *tipLabel = [bottomView addLabel:@"检测摄像头是否正常" font:[UIFont systemFontOfSize:14]];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.centerX.equalTo(bottomView);
    }];
    
    UIButton *abnormalButton = [bottomView addButton:@"异常" target:self action:@selector(abnormalAction)];
    [abnormalButton setTitleColor:AppColorRed forState:UIControlStateNormal];
    [abnormalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_centerX).offset(-20);
        make.size.equalTo(CGSizeMake(100, 40));
        make.bottom.offset(-40);
    }];
    
    UIButton *normalButton = [bottomView addButton:@"正常" target:self action:@selector(normalAction)];
    [normalButton setTitleColor:AppColorGreen forState:UIControlStateNormal];
    [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_centerX).offset(20);
        make.size.equalTo(CGSizeMake(100, 40));
        make.bottom.offset(-40);
    }];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    AVCaptureDeviceDiscoverySession *dissession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInDuoCamera,AVCaptureDeviceTypeBuiltInTelephotoCamera,AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
    for ( AVCaptureDevice *device in dissession.devices)
        if ( device.position == position ){
            return device;
        }
    return nil;
}

-(void)abnormalAction
{
    if (self.checkBlock) {
        self.checkBlock(NO);
    }
    [self removeFromSuperview];
}

-(void)normalAction
{
    if (self.checkBlock) {
        self.checkBlock(YES);
    }
    [self removeFromSuperview];
}


+(void)showInView:(UIView *)view frontObserverBlock:(nullable void (^)(BOOL))block
{
    AutoCheckCameraView *checkView = [[AutoCheckCameraView alloc] initWithFront];
    checkView.checkBlock = block;
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

+(void)showInView:(UIView *)view backObserverBlock:(void (^)(BOOL))block
{
    AutoCheckCameraView *checkView = [[AutoCheckCameraView alloc] initWithBack];
    checkView.checkBlock = block;
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        //给摄像头的切换添加翻转动画
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";

        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
  //拿到另外一个摄像头位置
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;//动画翻转方向
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;//动画翻转方向
        }
        //生成新的输入
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;
                
            } else {
                [self.session addInput:self.input];
            }
            [self.session commitConfiguration];
         
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
@end
