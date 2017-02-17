//
//  BaseNavigationController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1]} forState:UIControlStateNormal];
     self.delegate = self;
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        ((BaseViewController *)viewController).hidesBottomBarWhenPushed = [(BaseViewController *)viewController shouldHideBottomBarWhenPushed];
    }else{
        
    }
    [super pushViewController:viewController animated:animated];
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
