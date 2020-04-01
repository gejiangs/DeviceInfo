//
//  BaseVC.m
//  wook
//
//  Created by guojiang on 5/8/14.
//  Copyright (c) 2014年 guojiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout= UIRectEdgeNone;
    
    self.view.backgroundColor = AppColorMain;
    
    if ([[self.navigationController viewControllers] count] > 1) {
        [self resetBackBarButton];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {    
    return UIStatusBarStyleLightContent;
}


- (void)resetBackBarButton
{
    UIImage *image = [[UIImage imageNamed:@"back_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(viewWillBack)];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)viewWillBack
{
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)pushViewControllerName:(NSString *)VCName
{
    id objClass = [[NSClassFromString(VCName) alloc] init];
    if (objClass == nil) {
        NSLog(@"ViewController:%@ is not exist", VCName);
        return;
    }
    
    [self.navigationController pushViewController:objClass animated:YES];
}

-(void)pushHideTabbarViewControllerName:(NSString *)VCName
{
    UIViewController *objClass = [[NSClassFromString(VCName) alloc] init];
    if (objClass == nil) {
        NSLog(@"ViewController:%@ is not exist", VCName);
        return;
    }
    objClass.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:objClass animated:YES];
}

-(void)pushViewControllerName:(NSString *)VCName animated:(BOOL)animated
{
    id objClass = [[NSClassFromString(VCName) alloc] init];
    if (objClass == nil) {
        NSLog(@"ViewController:%@ is not exist", VCName);
        return;
    }
    
    [self.navigationController pushViewController:objClass animated:animated];
}

-(void)addLeftBarTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    button.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = button;
}

-(void)addRightBarTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    button.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = button;
}


-(void)addLeftBarImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    [self addLeftBarImage:[UIImage imageNamed:imageName] target:target action:action];
}

-(void)addLeftBarImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 40, 40);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space_item, item, nil];
}

-(void)addRightBarImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    [self addRightBarImage:[UIImage imageNamed:imageName] target:target action:action];
}

-(void)addRightBarImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 40, 40);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space_item,item,  nil];
}


#pragma mark 启动键盘通知

-(void)enableKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)noti
{
    CGSize size = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self keyboardWillShowKeyHeight:size.height];
}

-(void)keyboardWillHide
{
    self.view.frame = Rect(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)keyboardDidShow:(NSNotification *)noti
{
    
}

-(void)keyboardWillShowKeyHeight:(CGFloat)keyHeight
{
    
}

-(void)setKeyboardUpShowView:(UIView *)showView keyboardHeight:(CGFloat)keyHeight
{
    CGFloat distanceToMove = keyHeight- (ScreenHeight - CGRectGetMaxY(showView.frame));
    
    if (distanceToMove <= 0) {
        return;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.y = -distanceToMove;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = rect;
    }];
}

#define mark System
-(void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
