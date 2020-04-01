//
//  ConfirmView.m
//  WhiteGoods
//
//  Created by jon on 2019/6/13.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "ConfirmView.h"

@interface ConfirmView ()

@property (nonatomic, copy)     void(^confirmBlock)(void);
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *contentLabel;

@end

@implementation ConfirmView

-(id)initWithAlertView:(NSString *)content
{
    if (self = [super init]) {
        UIView *bgView = [UIView new];
        bgView.backgroundColor = RGBA(244, 244, 244, 0.7);
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *boxView = [UIView new];
        boxView.layer.cornerRadius = 5;
        boxView.layer.masksToBounds = YES;
        boxView.backgroundColor = [UIColor whiteColor];
        [self addSubview:boxView];
        [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(210);
            make.center.equalTo(self);
        }];
        
        self.titleLabel = [boxView addLabel:@"温 馨 提 示" font:[UIFont boldSystemFontOfSize:15] color:AppColorMainText];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.centerX.equalTo(boxView);
        }];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor hexString:@"#E60016"];
        [boxView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.right.equalTo(_titleLabel.mas_right);
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.height.offset(0.5);
        }];
        
        self.contentLabel = [boxView addLabel:content font:[UIFont systemFontOfSize:12] color:AppColorGrayText];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(20);
            make.left.offset(20);
            make.right.offset(-20);
        }];
        
        UIButton *cancelButton = [boxView addButton:@"取消" target:self action:@selector(cancelAction)];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageWithColor:[UIColor hexString:@"#E60016"]] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
        cancelButton.layer.cornerRadius = 5;
        cancelButton.layer.masksToBounds = YES;
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).offset(20);
            make.right.equalTo(boxView.mas_centerX).offset(-10);
            make.width.offset(60);
            make.height.offset(25);
            make.bottom.offset(-20);
        }];
        
        UIButton *sureButton = [boxView addButton:@"确认" target:self action:@selector(sureAction)];
        [sureButton setTitleColor:[UIColor hexString:@"#E60016"] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [sureButton setBackgroundImage:[UIImage imageWithColor:AppColorWhiteGray] forState:UIControlStateHighlighted];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:12];
        sureButton.layer.cornerRadius = 5;
        sureButton.layer.masksToBounds = YES;
        sureButton.layer.borderColor = [UIColor hexString:@"#E60016"].CGColor;
        sureButton.layer.borderWidth = 0.5;
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).offset(20);
            make.left.equalTo(boxView.mas_centerX).offset(10);
            make.width.offset(60);
            make.height.offset(25);
        }];
    }
    return self;
}

-(id)initWithWaitView:(NSString *)content
{
    if (self = [super init]) {
        UIView *bgView = [UIView new];
        bgView.backgroundColor = RGBA(244, 244, 244, 0.7);
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *boxView = [UIView new];
        boxView.layer.cornerRadius = 5;
        boxView.layer.masksToBounds = YES;
        boxView.backgroundColor = [UIColor whiteColor];
        [self addSubview:boxView];
        [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(210);
            make.center.equalTo(self);
        }];
        
        self.titleLabel = [boxView addLabel:@"温 馨 提 示" font:[UIFont boldSystemFontOfSize:15] color:AppColorMainText];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.centerX.equalTo(boxView);
        }];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor hexString:@"#E60016"];
        [boxView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.right.equalTo(_titleLabel.mas_right);
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.height.offset(0.5);
        }];
        
        UIButton *closeButton = [boxView addButton:@"" target:self action:@selector(sureAction)];
        [closeButton setImage:[UIImage imageNamed:@"address_del"] forState:UIControlStateNormal];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.offset(0);
            make.width.height.offset(30);
        }];
        
        self.contentLabel = [boxView addLabel:content font:[UIFont systemFontOfSize:12] color:[UIColor hexString:@"#E60016"]];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(20);
            make.left.offset(20);
            make.right.offset(-20);
        }];
        
        UIButton *button = [boxView addButton:@"客服将在24小时内完成审核" target:nil action:nil];
        [button setTitleColor:[UIColor hexString:@"#E60016"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.layer.cornerRadius = 15;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [UIColor hexString:@"#E60016"].CGColor;
        button.layer.borderWidth = 0.5;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).offset(20);
            make.centerX.equalTo(boxView);
            make.width.offset(180);
            make.height.offset(30);
            make.bottom.offset(-20);
        }];
    }
    return self;
}


-(id)initWithTipView:(NSString *)content button:(NSString *)button
{
    if (self = [super init]) {
        UIView *bgView = [UIView new];
        bgView.backgroundColor = RGBA(244, 244, 244, 0.7);
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *boxView = [UIView new];
        boxView.layer.cornerRadius = 5;
        boxView.layer.masksToBounds = YES;
        boxView.backgroundColor = [UIColor whiteColor];
        [self addSubview:boxView];
        [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(210);
            make.center.equalTo(self);
        }];
        
        self.titleLabel = [boxView addLabel:@"温 馨 提 示" font:[UIFont boldSystemFontOfSize:15] color:AppColorMainText];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.centerX.equalTo(boxView);
        }];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor hexString:@"#E60016"];
        [boxView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.right.equalTo(_titleLabel.mas_right);
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.height.offset(0.5);
        }];
        
        UIButton *closeButton = [boxView addButton:@"" target:self action:@selector(cancelAction)];
        [closeButton setImage:[UIImage imageNamed:@"address_del"] forState:UIControlStateNormal];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.offset(0);
            make.width.height.offset(30);
        }];
        
        self.contentLabel = [boxView addLabel:content font:[UIFont systemFontOfSize:12] color:AppColorGrayText];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(20);
            make.left.offset(20);
            make.right.offset(-20);
        }];
        
        if (StringNotEmpty(button)) {
            UIButton *btn = [boxView addButton:button target:self action:@selector(sureAction)];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor hexString:@"E60016"]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.layer.cornerRadius = 15;
            btn.layer.masksToBounds = YES;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_contentLabel.mas_bottom).offset(20);
                make.centerX.equalTo(boxView);
                make.width.offset(180);
                make.height.offset(30);
                make.bottom.offset(-20);
            }];
        }else{
            [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(-20);
            }];
        }
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [self showInView:view block:nil];
}

-(void)showInView:(UIView *)view block:(nullable void (^)(void))block
{
    self.confirmBlock = block;
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

-(void)showWaitInView:(UIView *)view
{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

-(void)cancelAction
{
    [self removeFromSuperview];
}

-(void)sureAction
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}

@end
