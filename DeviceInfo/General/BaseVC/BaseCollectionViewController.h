//
//  BaseCollectionViewController.h
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/2.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *contentArray;

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection;


@end

NS_ASSUME_NONNULL_END
