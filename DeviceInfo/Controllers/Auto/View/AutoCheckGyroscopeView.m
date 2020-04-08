//
//  AutoCheckGyroscopeView.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/7.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckGyroscopeView.h"
#import <CoreMotion/CoreMotion.h>

@interface AutoCheckGyroscopeView ()

@property (nonatomic, assign)               BOOL isShow;
@property (nonatomic, strong)               UIView *bgView;
@property (nonatomic, strong)               UIView *topView;
@property (nonatomic, strong)               UIView *bottomView;
@property (nonatomic, strong)               CMMotionManager *motionManager;
@property (nonatomic, copy, nullable)       void(^checkBlock)(BOOL normal);

@end

@implementation AutoCheckGyroscopeView

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
    
    [self initTopView];
    [self initBottomView];
    [self initGyrosscopy];
}

-(void)initTopView
{
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = 1 / 500;
    
    self.topView = [UIView new];
    _topView.backgroundColor = AppColorRed;
    _topView.layer.transform = trans;
    [self.bgView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.equalTo(_topView.mas_width);
    }];
    
    CGFloat width = (ScreenWidth/375.f)*200;
    
    //前
    UIImageView *frontView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    frontView.image = [UIImage imageNamed:@"checking_gro_font"];
    trans = CATransform3DTranslate(trans, 0, 0, width/2);
    frontView.layer.transform = trans;
    //后
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];;
    backView.image = [UIImage imageNamed:@"checking_gro_font"];
    trans = CATransform3DTranslate(trans, 0, 0, -width);
    backView.layer.transform = trans;
    //左
    UIImageView *leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];;
    leftView.image = [UIImage imageNamed:@"checking_gro_font"];
    trans = CATransform3DMakeTranslation(-width/2, 0, 0);
    trans = CATransform3DRotate(trans, -M_PI_2, 0, 1, 0);
    leftView.layer.transform = trans;
    //右
    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];;
    rightView.image = [UIImage imageNamed:@"checking_gro_font"];
    trans = CATransform3DMakeTranslation(width/2, 0, 0);
    trans = CATransform3DRotate(trans, M_PI_2, 0, 1, 0);
    rightView.layer.transform = trans;
    //上
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];;
    topView.image = [UIImage imageNamed:@"checking_gro_up"];
    trans = CATransform3DMakeTranslation(0, width/2, 0);
    trans = CATransform3DRotate(trans, M_PI_2, 1, 0, 0);
    topView.layer.transform = trans;
    //下
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    bottomView.image = [UIImage imageNamed:@"checking_gro_low"];
    trans = CATransform3DMakeTranslation(0, -width/2, 0);
    trans = CATransform3DRotate(trans, M_PI_2, -1, 0, 0);
    bottomView.layer.transform = trans;
    
    [self.topView addSubview:frontView];
    [self.topView addSubview:backView];
    [self.topView addSubview:leftView];
    [self.topView addSubview:rightView];
    [self.topView addSubview:topView];
    [self.topView addSubview:bottomView];
}

-(void)initBottomView
{
    self.bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.bgView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.bottom.right.offset(0);
    }];
    
    UILabel *titleLabel = [_bottomView addLabel:@"请摇晃手机，观察画面是否会变动" font:[UIFont systemFontOfSize:14] color:RGB(50, 50, 50)];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerX.equalTo(_bottomView);
    }];
    
    UIButton *abnormalButton = [_bottomView addButton:@"异常" target:self action:@selector(abnormalAction)];
    [abnormalButton setTitleColor:AppColorRed forState:UIControlStateNormal];
    abnormalButton.layer.cornerRadius = 5;
    abnormalButton.layer.masksToBounds = YES;
    abnormalButton.layer.borderColor = AppColorRed.CGColor;
    abnormalButton.layer.borderWidth = 0.5;
    [abnormalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_centerX).offset(-20);
        make.size.equalTo(CGSizeMake(100, 40));
        make.centerY.equalTo(_bottomView.mas_centerY).offset(25);
    }];
    
    UIButton *normalButton = [_bottomView addButton:@"正常" target:self action:@selector(normalAction)];
    [normalButton setTitleColor:AppColorGreen forState:UIControlStateNormal];
    normalButton.layer.cornerRadius = 5;
    normalButton.layer.masksToBounds = YES;
    normalButton.layer.borderColor = AppColorGreen.CGColor;
    normalButton.layer.borderWidth = 0.5;
    [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_centerX).offset(20);
        make.size.equalTo(CGSizeMake(100, 40));
        make.centerY.equalTo(abnormalButton.mas_centerY);
    }];
}


-(void)initGyrosscopy
{
    if (![self.motionManager isGyroAvailable]) {
//        [self onUnormalAction:nil];
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.motionManager isDeviceMotionAvailable]) {
            self.motionManager.gyroUpdateInterval = 0.03;
            [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]withHandler:^(CMDeviceMotion * _Nullable motion,NSError* _Nullable error) {
                double gravityX = motion.gravity.x;
                double gravityY = motion.gravity.y;
                double gravityZ = motion.gravity.z;
                //获取手机的倾斜弧度：
                double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY));
                double yTheta = atan2(gravityY,sqrtf(gravityX*gravityX+gravityZ*gravityZ));
                double xTheta = atan2(gravityX,sqrtf(gravityZ*gravityZ+gravityY*gravityY));
                //降低精度
                int intZ = zTheta *100;
                int intY = yTheta *100;
                int intX = xTheta *100;
                double zdTheta = intZ*1.0/100;
                double ydTheta = intY*1.0/100;
                double xdTheta = intX*1.0/100;
                dispatch_async(dispatch_get_main_queue(), ^{
                    CATransform3D tran = CATransform3DIdentity;
                    tran.m34 = -1/ 500;
                    tran = CATransform3DRotate(tran,-xdTheta, 1,0, 0);
                    weakSelf.topView.layer.sublayerTransform = tran;
                    tran = CATransform3DRotate(tran,-ydTheta, 0,1, 0);
                    weakSelf.topView.layer.sublayerTransform = tran;
                    tran = CATransform3DRotate(tran,-zdTheta, 0,0, 1);
                    weakSelf.topView.layer.sublayerTransform = tran;
                });
                
            }];
        }
    });
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
    AutoCheckGyroscopeView *checkView = [[AutoCheckGyroscopeView alloc] init];
    checkView.checkBlock = block;
    [view addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [self dispatchTimerWithTime:0.1 block:^{
        [checkView show:YES];
    }];
}

-(CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

@end
