//
//  ComboxPickerView.h
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "BaseView.h"


@class ComboxPickerView;

@protocol ComboxPickerViewDelegate<NSObject>

@optional

- (NSInteger)numberOfComponentsInPickerView:(ComboxPickerView *)comboBoxView;
- (NSInteger)pickerView:(ComboxPickerView *)comboBoxView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(ComboxPickerView *)comboBoxView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(ComboxPickerView *)comboBoxView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)pickerViewConfirm:(ComboxPickerView*)comboBoxView;//点击确认按钮
- (void)pickerViewCancel:(ComboxPickerView*)comboBoxView;//点击取消按钮

@end

@interface ComboxPickerView : BaseView

@property(nonatomic,weak) id<ComboxPickerViewDelegate> delegate;

@property (nonatomic, strong)   UILabel *titleLabel;

-(void)showInView:(UIView *)view;
-(void)setHandlerAlpha:(CGFloat)alpha;

- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (NSInteger)selectedRowInComponent:(NSInteger)component;

@end
