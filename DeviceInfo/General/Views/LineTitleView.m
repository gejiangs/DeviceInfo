//
//  LineTitleView.m
//  WhiteGoods
//
//  Created by gejiangs on 2019/6/20.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "LineTitleView.h"

@interface LineTitleView ()

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UIButton *touchView;
@property (nonatomic, strong)   UIImageView *arrowView;

@property (nonatomic, copy)     void(^block)(void);

@end

@implementation LineTitleView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _title = title;
        [self initUI];
    }
    return self;
}

-(id)initWithStyle:(LineTitleStyle)style title:(nullable NSString *)title
{
    if (self = [super init]) {
        _style = style;
        _title = title;
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.touchView = [self addButton:@"" target:self action:@selector(touchAction)];
    [_touchView setBackgroundImage:[UIImage imageWithColor:[UIColor hexString:@"#F8F8F8"]] forState:UIControlStateHighlighted];
    [_touchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = AppColorMainText;
    lineView.userInteractionEnabled = NO;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.offset(5);
        make.bottom.offset(-5);
        make.height.offset(20);
        make.width.offset(2.5);
    }];
    
    self.titleLabel = [self addLabel:self.title font:[UIFont boldSystemFontOfSize:16] color:AppColorMainText];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(lineView);
    }];
    
    self.arrowView = [self.touchView addImageView];
    [self updateStyleUI];
}

-(void)setStyle:(LineTitleStyle)style
{
    _style = style;
    [self updateStyleUI];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

-(void)updateStyleUI
{
    if (self.style == LineTitleStyleDefault) {
        self.arrowView.hidden = YES;
        self.touchView.hidden = YES;
    }else if (self.style == LineTitleStyleRight){
        self.touchView.hidden = NO;
        self.arrowView.image = [UIImage imageNamed:@"arrow_right"];
        [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self);
        }];
    }else if (self.style == LineTitleStyleUp){
        self.touchView.hidden = NO;
        self.arrowView.image = [UIImage imageNamed:@"order_arrow_up"];
        [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
    }else if (self.style == LineTitleStyleDown){
        self.touchView.hidden = NO;
        self.arrowView.image = [UIImage imageNamed:@"order_arrow_down"];
        [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
    }else if (self.style == LineTitleStyleRightUp){
        self.touchView.hidden = NO;
        self.arrowView.image = [UIImage imageNamed:@"order_arrow_up"];
        [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self);
        }];
    }else if (self.style == LineTitleStyleRightDown){
        self.touchView.hidden = NO;
        self.arrowView.image = [UIImage imageNamed:@"order_arrow_down"];
        [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self);
        }];
    }
}

-(void)touchAction
{
    if (self.block) {
        self.block();
    }
}

-(void)touchBlock:(void (^)(void))block
{
    if (block == nil) {
        self.touchView.hidden = YES;
        self.arrowView.hidden = YES;
        return;
    }
    
    self.touchView.hidden = NO;
    self.arrowView.hidden = NO;
    
    self.block = block;
}

@end
