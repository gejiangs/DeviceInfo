//
//  CacheManager.m
//  WhiteGoods
//
//  Created by gejiangs on 2020/2/24.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "CacheManager.h"
#import "TMCache.h"

@interface CacheManager ()

@property (nonatomic, strong)   TMCache *tmCache;

@end

@implementation CacheManager

+(instancetype)manager
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

-(id)init
{
    if (self = [super init]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        self.tmCache = [[TMCache alloc] initWithName:@"com.tmcache.user" rootPath:path];
    }
    return self;
}

+(id)objectForKey:(NSString *)key
{
    return [[CacheManager manager].tmCache objectForKey:key];
}

+(void)setObject:(id)object forKey:(NSString *)key
{
    [[CacheManager manager].tmCache setObject:object forKey:key];
}
@end
