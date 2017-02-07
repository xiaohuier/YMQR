//
//  GuideViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideScrollView.h"

#import "AppDelegate.h"

#import "BaseNavigationController.h"
#import "LeftViewController.h"
#import "HomePageViewController.h"
#import <MMDrawerController.h>

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubView];
}

-(void)initSubView
{
    
    NSArray *Images = @[[UIImage imageNamed:@"引导页1"],[UIImage imageNamed:@"引导页2"],[UIImage imageNamed:@"引导页3"]];
    GuideScrollView *guideScrollView = [[GuideScrollView alloc]initWithFrame:self.view.bounds WithImages:Images];
    [guideScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 3, 0)];
    [guideScrollView setPagingEnabled:YES];  //视图整页显示
    [guideScrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    [guideScrollView.startButton addTarget:self action:@selector(startApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guideScrollView];
    
}

-(void)startApp:(id)sender
{
    HomePageViewController *HomePageVC = [[HomePageViewController alloc]init];
    
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    
    BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:HomePageVC];
    
    MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:Nav leftDrawerViewController:leftVC];
    
    drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    [UIApplication sharedApplication].keyWindow.rootViewController = drawer;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"noFirstLaunch"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
