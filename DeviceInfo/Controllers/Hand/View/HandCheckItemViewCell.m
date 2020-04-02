//
//  HandCheckItemViewCell.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "HandCheckItemViewCell.h"

@interface HandCheckItemViewCell ()

@property (nonatomic, strong)   UIImageView *imageView;
@property (nonatomic, strong)   UILabel *titleLabel;

@end

@implementation HandCheckItemViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.titleLabel = [self.contentView addLabel:@"" font:[UIFont systemFontOfSize:16]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.centerY.equalTo(self.contentView);
    }];
}

-(void)setLayout:(HandCheckItemLayout *)layout
{
    _layout = layout;
    self.titleLabel.text = _layout.title;
}

@end
