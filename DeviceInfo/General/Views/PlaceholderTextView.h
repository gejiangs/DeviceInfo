//
//  PlaceHodlerTextView.h
//  GoodsWhite
//
//  Created by gejiangs on 2019/4/10.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property (nonatomic, copy)     NSString *placeholder;
@property (nonatomic, strong)   UIColor *placeholderColor;

@end
