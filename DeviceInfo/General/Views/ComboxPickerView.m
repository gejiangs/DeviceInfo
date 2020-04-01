//
//  ComboxPickerView.m
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "ComboxPickerView.h"

@interface ComboxPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    
}

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) UIButton *handlerView;
@property (nonatomic, strong) UIView *pickBoxView;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ComboxPickerView

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
    
    self.handlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    _handlerView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
    [_handlerView addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_handlerView];
    
    [_handlerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self).offset(0);
    }];
    
    self.pickBoxView = [[UIView alloc] init];
    _pickBoxView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickBoxView];
    
    UIView *headView = [UIView new];
    headView.backgroundColor = [UIColor whiteColor];
    [_pickBoxView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(50);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor grayColor];
    [headView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(0.5);
    }];
    
    self.titleLabel = [headView addLabel:@"" color:[UIColor blackColor]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headView);
    }];
    
    UIButton *cancelButton = [headView addButton:@"取消" target:self action:@selector(cancelAction:)];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 10.f;
    cancelButton.layer.masksToBounds = YES;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setBackgroundImage:[UIImage imageWithColor:RGB(204, 204, 204)] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageWithColor:RGB(165, 165, 165)] forState:UIControlStateHighlighted];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(65, 30));
        make.left.offset(15);
        make.centerY.equalTo(headView);
    }];
    
    
    UIButton *sureButton = [headView addButton:@"确定" target:self action:@selector(sureAction:)];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 10.f;
    sureButton.layer.masksToBounds = YES;
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureButton setBackgroundImage:[UIImage imageWithColor:AppColorRed] forState:UIControlStateNormal];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(65, 30));
        make.right.offset(-15);
        make.centerY.equalTo(headView);
    }];
    
    self.pickerView = [[UIPickerView alloc] init];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickBoxView addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(headView.mas_bottom).offset(0);
        make.height.offset(310);
    }];
    
    UIButton *touchButton = [self.pickBoxView addButton:@"" target:self action:@selector(sureAction:)];
    touchButton.backgroundColor = [UIColor clearColor];
    [touchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(40);
        make.centerY.equalTo(self.pickerView);
    }];
}

-(void)cancelAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewCancel:)]) {
        [_delegate pickerViewCancel:self];
    }
    [self show:NO];
}

-(void)sureAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewConfirm:)]) {
        [_delegate pickerViewConfirm:self];
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
    CGFloat tableHeight = 350;
    
    [self.pickBoxView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.height.offset(tableHeight);
        if (self.isShow) {
            make.bottom.equalTo(self).offset(0);
        }else{
            make.bottom.equalTo(self).offset(tableHeight);
        }
    }];
    
    [super updateConstraints];
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    [self dispatchTimerWithTime:0.1 block:^{
        [self show:YES];
    }];
}

-(void)setHandlerAlpha:(CGFloat)alpha
{
    self.handlerView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:alpha];
}

-(void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}

-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [_pickerView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return [_pickerView selectedRowInComponent:component];
}

#pragma mark --pickerView 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [_delegate numberOfComponentsInPickerView:self];
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [_delegate pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [_delegate pickerView:self titleForRow:row forComponent:component];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [_delegate pickerView:self didSelectRow:row inComponent:component];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* titleLabel = (UILabel*)view;
    if (!titleLabel){
        titleLabel = [[UILabel alloc] init];
        titleLabel.minimumScaleFactor = 8.;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor= [UIColor blackColor];
        titleLabel.font=[UIFont systemFontOfSize:17];
    }
    titleLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return titleLabel;
}

@end
