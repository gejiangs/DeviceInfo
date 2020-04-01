//
//  PreviewManager.h
//  WhiteGoods
//
//  Created by gejiangs on 2019/5/29.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreviewManager : NSObject

+(instancetype)manager;

-(void)previewImages:(NSArray *)images index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
