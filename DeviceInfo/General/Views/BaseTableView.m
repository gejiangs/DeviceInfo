//
//  BaseTableView.m
//  WhiteGoods
//
//  Created by gejiangs on 2019/5/9.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(id)init
{
    if (self = [super init]) {
        [self addTableView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTableView];
    }
    return self;
}

-(void)addTableView
{
    [self setTableViewStyle:UITableViewStylePlain];
}

-(void)setTableViewStyle:(UITableViewStyle)tableViewStyle
{
    if (self.tableView != nil) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self addSubview:self.tableView];
    [_tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    return cell;
}

#pragma mark - lazy load
-(NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        self.contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

#pragma mark - dealloc
-(void)dealloc
{
    self.tableView = nil;
}

@end
