//
//  PreviewManager.m
//  WhiteGoods
//
//  Created by gejiangs on 2019/5/29.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "PreviewManager.h"
#import "HXPhotoPicker.h"
#import "HXPhotoPreviewViewController.h"
#import "AppDelegate.h"

@interface PreviewManager ()<HXPhotoViewControllerDelegate>

@property (strong, nonatomic)   HXPhotoManager *photoManager;

@end

@implementation PreviewManager

+(instancetype)manager
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

-(void)previewWithViewController:(UIViewController *)viewController index:(NSInteger)index
{
    HXPhotoPreviewViewController *vc = [[HXPhotoPreviewViewController alloc] init];
    vc.disableaPersentInteractiveTransition = NO;
    vc.outside = YES;
    vc.manager = self.photoManager;
    vc.exteriorPreviewStyle = HXPhotoViewPreViewShowStyleDark;
    vc.modelArray = [NSMutableArray arrayWithArray:self.photoManager.afterSelectedArray];
    vc.currentModelIndex = index;
    vc.previewShowDeleteButton = NO;
    vc.photoView = nil;
    
    [viewController presentViewController:vc animated:YES completion:^{
        //HXPhotoPreviewViewController 里有 translucent = yes,返回后，导航栏颜色会变，这里得改回来
        [UINavigationBar appearance].translucent = NO;
    }];
}

-(void)previewImages:(NSArray *)images index:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<images.count; i++) {
        NSURL *url = [NSURL URLWithString:images[i]];
        HXCustomAssetModel *m = [HXCustomAssetModel assetWithNetworkImageURL:url selected:YES];
        [array addObject:m];
    }
    [self.photoManager clearSelectedList];
    self.photoManager.configuration.photoMaxNum = array.count;
    [self.photoManager addCustomAssetModel:array];
    
    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    [self previewWithViewController:window.rootViewController index:index];
}

#pragma mark - < HXPhotoPreviewViewControllerDelegate >
- (void)photoPreviewCellDownloadImageComplete:(HXPhotoPreviewViewController *)previewController model:(HXPhotoModel *)model
{
    if (!model.loadOriginalImage) {
        
    }
}
- (void)photoPreviewDidDeleteClick:(HXPhotoPreviewViewController *)previewController deleteModel:(HXPhotoModel *)model deleteIndex:(NSInteger)index
{
    
}
- (void)photoPreviewSelectLaterDidEditClick:(HXPhotoPreviewViewController *)previewController beforeModel:(HXPhotoModel *)beforeModel afterModel:(HXPhotoModel *)afterModel
{
    
}

#pragma mark - lazy

- (HXPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _photoManager.configuration.photoCanEdit = NO;
        _photoManager.configuration.cameraCellShowPreview = NO;
        _photoManager.configuration.openCamera = NO;
    }
    return _photoManager;
}

@end
