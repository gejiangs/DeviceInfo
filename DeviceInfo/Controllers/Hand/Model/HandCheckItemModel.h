//
//  HandCheckItemModel.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, HandCheckItemStatus){
    HandCheckItemStatusNone = 0,        //未检查
    HandCheckItemStatusNormal = 1,      //正常
    HandCheckItemStatusAbnormal = 2     //不正常
};


@interface HandCheckItemModel : NSObject

-(id)initWithTitle:(NSString *)title;

@property (nonatomic, copy)     NSString *title;                //检查项标题
@property (nonatomic, assign)   HandCheckItemStatus status;     //检查项状态

@end

NS_ASSUME_NONNULL_END
