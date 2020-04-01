//
//  BasicWebViewController.h
//  FenQiBao
//
//  Created by gejiangs on 14/12/11.
//  Copyright (c) 2014年 DaChengSoftware. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseWebViewController : BaseViewController

@property (nonatomic, strong) UIView *webView;
@property (nonatomic, copy) NSString *urlString;

-(void)loadURString:(NSString *)urlString;
-(void)goBack;
-(void)goForward;
-(void)reload;

@end
