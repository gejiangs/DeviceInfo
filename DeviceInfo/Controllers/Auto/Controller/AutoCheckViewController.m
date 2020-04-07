//
//  AutoCheckViewController.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "AutoCheckViewController.h"
#import "AutoCheckLayout.h"
#import "AutoCheckItemViewCell.h"
#import "AutoCheckProximityMonitorView.h"
#import "AutoCheckVolumeKeyView.h"
#import "AutoCheckCameraView.h"

@interface AutoCheckViewController ()

@property (nonatomic, strong)   AutoCheckLayout *layout;

@end

@implementation AutoCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自动化测试";
    [self initUI];
}


-(void)initUI
{
    [self addRightBarTitle:@"开始检测" target:self action:@selector(rightAction)];
}

-(void)rightAction
{
    [self autoCheckWithIndex:0];
}

-(void)autoCheckWithIndex:(NSInteger)index
{
    [self updateItemCheckingWithIndex:index];
    if (index == 0) {
        [AutoCheckProximityMonitorView showInView:self.view.window block:^(BOOL normal) {
            [self updateItemStatusWithIndex:index normal:normal];
            [self autoCheckWithIndex:1];
        }];
    }else if (index == 1){
        [AutoCheckVolumeKeyView showInView:self.view.window subObserverBlock:^(BOOL normal) {
            if (normal) {
                [AutoCheckVolumeKeyView showInView:self.view.window plusObserverBlock:^(BOOL normal) {
                    [self updateItemStatusWithIndex:index normal:normal];
                    [self autoCheckWithIndex:2];
                }];
            }else{
                [self updateItemStatusWithIndex:index normal:normal];
                [self autoCheckWithIndex:2];
            }
        }];
    }else if (index == 2){
        [AutoCheckCameraView showInView:self.view.window frontObserverBlock:^(BOOL normal) {
            [self updateItemStatusWithIndex:index normal:normal];
            [self autoCheckWithIndex:3];
        }];
    }else if (index == 3){
        [AutoCheckCameraView showInView:self.view.window backObserverBlock:^(BOOL normal) {
            [self updateItemStatusWithIndex:index normal:normal];
            [self autoCheckWithIndex:4];
        }];
    }
}

-(void)updateItemCheckingWithIndex:(NSInteger)index
{
    if (self.layout.itemLayouts.count <= index) {
        return;
    }
    AutoCheckItemLayout *itemLayout = self.layout.itemLayouts[index];
    [itemLayout updateCheckItemStatus:AutoCheckItemStatusChecking];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)updateItemStatusWithIndex:(NSInteger)index normal:(BOOL)normal
{
    if (self.layout.itemLayouts.count <= index) {
        return;
    }
    AutoCheckItemLayout *itemLayout = self.layout.itemLayouts[index];
    [itemLayout updateCheckItemStatus:normal ? AutoCheckItemStatusNormal : AutoCheckItemStatusAbnormal];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layout.itemLayouts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    AutoCheckItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[AutoCheckItemViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    
    cell.layout = self.layout.itemLayouts[indexPath.row];
    
    return cell;
}

#pragma mark - lazy
-(AutoCheckLayout *)layout
{
    if (_layout == nil) {
        _layout = [[AutoCheckLayout alloc] init];
        [_layout layout];
    }
    return _layout;
}
@end
