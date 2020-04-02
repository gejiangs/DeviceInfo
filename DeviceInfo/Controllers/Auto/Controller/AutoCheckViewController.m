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
    [self addRightBarTitle:@"手动检测" target:self action:@selector(rightAction)];
}

-(void)rightAction
{
    [self pushViewControllerName:@"HandCheckViewController"];
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
