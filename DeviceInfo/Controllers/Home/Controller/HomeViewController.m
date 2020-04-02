//
//  HomeViewController.m
//  DeviceInfo
//
//  Created by gejiangs on 2020/4/1.
//  Copyright © 2020 gejiangs. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeLayout.h"

@interface HomeViewController ()

@property (nonatomic, strong)   HomeLayout *layout;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备信息";
    [self initUI];
}

-(void)initUI
{
    [self addRightBarTitle:@"自动化检测" target:self action:@selector(rightAction)];

}

-(void)rightAction
{
    [self pushViewControllerName:@"AutoCheckViewController"];
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layout.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *item = self.layout.array[indexPath.row];
    cell.textLabel.text = item[@"k"];
    cell.detailTextLabel.text = item[@"v"];
    
    return cell;
}

#pragma mark - lazy
-(HomeLayout *)layout
{
    if (_layout == nil) {
        _layout = [[HomeLayout alloc] init];
    }
    return _layout;
}
@end
