//
//  CustomAlertView.m
//  SmartStick
//
//  Created by jon on 2020/2/7.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *messageLabel;
@property (nonatomic, strong)   UIButton *cancelButton;
@property (nonatomic, strong)   UIButton *sureButton;

@property (nonatomic, copy)     void(^cancelBlock)(void);
@property (nonatomic, copy)     void(^sureBlock)(void);

@end

@implementation CustomAlertView

-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
            cancel:(NSString *)cancel
              sure:(NSString *)sure
{
    if (self = [super init]) {
        [self initUI];
        self.titleLabel.text = title;
        self.messageLabel.text = message;
        [self.cancelButton setTitle:cancel forState:UIControlStateNormal];
        [self.sureButton setTitle:sure forState:UIControlStateNormal];
    }
    return self;
}

-(id)initWithTitleAttribute:(NSAttributedString *)titleAttribute
           messageAttribute:(NSAttributedString *)messageAttribute
            cancelAttribute:(NSAttributedString *)cancelAttribute
              sureAttribute:(NSAttributedString *)sureAttribute
{
    if (self = [super init]) {
        [self initUI];
        self.titleLabel.attributedText = titleAttribute;
        self.messageLabel.attributedText = messageAttribute;
        [self.cancelButton setAttributedTitle:cancelAttribute forState:(UIControlState)UIControlStateNormal];
        [self.sureButton setAttributedTitle:sureAttribute forState:UIControlStateNormal];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *handlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    handlerView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
//    [handlerView addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:handlerView];
    
    [handlerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self).offset(0);
    }];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = AppColorBoxBG;
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.offset(30);
        make.right.offset(-30);
    }];
    
    self.titleLabel = [contentView addLabel:@"" font:[UIFont systemFontOfSize:17] color:[UIColor blackColor]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    self.messageLabel = [contentView addLabel:@"" font:[UIFont systemFontOfSize:17] color:[UIColor blackColor]];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageLabel.mas_bottom).offset(20);
        make.left.right.offset(0);
        make.height.offset(0.5);
    }];
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.centerX.equalTo(contentView);
        make.width.offset(0.5);
        make.bottom.offset(0);
    }];
    
    self.cancelButton = [contentView addButton:@"" target:self action:@selector(cancelAction)];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.right.equalTo(lineView2.mas_left).offset(0);
        make.height.offset(40);
    }];
    
    self.sureButton = [contentView addButton:@"" target:self action:@selector(sureAction)];
    [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.equalTo(lineView2.mas_right).offset(0);
        make.height.offset(40);
    }];
}

-(void)showWithCancelBlock:(void(^)(void))cancelBlock
                 sureBlock:(void(^)(void))sureBlock;
{
    self.cancelBlock = cancelBlock;
    self.sureBlock = sureBlock;
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rootWindow);
    }];
}


-(void)showWithSureBlock:(void(^)(void))sureBlock
{
    self.sureBlock = sureBlock;
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rootWindow);
    }];
}

#pragma mark - UIButton Action
-(void)cancelAction
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}

-(void)sureAction
{
    if (self.sureBlock) {
        self.sureBlock();
    }
    [self removeFromSuperview];
}

@end
