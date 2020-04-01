//
//  AutoCheckItemModel.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AutoCheckItemStatus){
    AutoCheckItemStatusNone = 0,        //未检查
    AutoCheckItemStatusNormal = 1,      //正常
    AutoCheckItemStatusAbnormal = 2     //不正常
};

@interface AutoCheckItemModel : NSObject

-(id)initWithTitle:(NSString *)title;

@property (nonatomic, copy)     NSString *title;                //检查项标题
@property (nonatomic, assign)   AutoCheckItemStatus status;     //检查项状态

@end

NS_ASSUME_NONNULL_END
