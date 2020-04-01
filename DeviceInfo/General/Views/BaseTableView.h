//
//  BaseTableView.h
//  WhiteGoods
//
//  Created by gejiangs on 2019/5/9.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong, nullable)     UITableView *tableView;
@property (nonatomic, strong, nullable)     NSMutableArray *contentArray;

-(void)setTableViewStyle:(UITableViewStyle)tableViewStyle;

@end

NS_ASSUME_NONNULL_END
