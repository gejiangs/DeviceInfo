//
//  CacheManager.h
//  WhiteGoods
//
//  Created by gejiangs on 2020/2/24.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject

+(id)objectForKey:(NSString *)key;

+(void)setObject:(id)object forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
