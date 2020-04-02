//
//  HandCheckViewController.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "HandCheckViewController.h"
#import "HandCheckLayout.h"
#import "HandCheckItemViewCell.h"

@interface HandCheckViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)   HandCheckLayout *layout;

@end

@implementation HandCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手动检测";
    [self initUI];
}

-(void)initUI
{
    [self.collectionView registerClass:[HandCheckItemViewCell class] forCellWithReuseIdentifier:@"item_cell"];
}

#pragma mark -UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.layout.itemLayouts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HandCheckItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item_cell" forIndexPath:indexPath];
    cell.layout = self.layout.itemLayouts[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    size.width  = collectionView.frame.size.width / 3.f;
    size.height = size.width;
    
    return size;
}

#pragma mark - lazy
-(HandCheckLayout *)layout
{
    if (_layout == nil) {
        _layout = [HandCheckLayout new];
        [_layout layout];
    }
    return _layout;
}

@end
