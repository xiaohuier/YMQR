//
//  Constants.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//iphone 6 尺寸

#define IPHONE6_SCREEN_RECT CGRectMake(0, 0, 375, 667)

#define IPHONE6_SCREEN_WIDTH 375

#define IPHONE6_SCREEN_HEIGHT 667

////尺寸换算
//#define TRANSFROM_IPHONE6_RECT(x,y,width,height) CGRectMake(x/IPHONE6_SCREEN_WIDTH*SCREEN_WIDTH, y/IPHONE6_SCREEN_HEIGHT*SCREEN_HEIGHT, width/IPHONE6_SCREEN_WIDTH*SCREEN_WIDTH, height/IPHONE6_SCREEN_HEIGHT*SCREEN_HEIGHT)

#define TRANSFROM_IPHONE6_WIDTH(width) width/IPHONE6_SCREEN_WIDTH*SCREEN_WIDTH

#define TRANSFROM_IPHONE6_HEIGHT(height) height/IPHONE6_SCREEN_HEIGHT*SCREEN_HEIGHT

//机型判断
#define IS_IPHONE_4_OR_LESS (SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (SCREEN_HEIGHT == 736.0)

//系统判断
#define IOS8_0 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f

#define IOS9_1 [[[UIDevice currentDevice] systemVersion] floatValue] < 10.0

#define IOS10_0 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0

#define WIDTH self.view.bounds.size.width

#define HEIGHT self.view.bounds.size.height

#define BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define BACK_TITLE UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];\
self.navigationItem.backBarButtonItem = barItem;

#define BACK_COLOR_WHITE self.navigationController.navigationBar.tintColor =[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];

#define WORDSCOLOR [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];

#define DEEPCOLOR [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];

#define COLOR0 [UIColor colorWithRed:251.0/255 green:20.0/255 blue:37.0/255 alpha:1]
#define COLOR1 [UIColor colorWithRed:252.0/255 green:147.0/255 blue:37.0/255 alpha:1]
#define COLOR2 [UIColor colorWithRed:41.0/255 green:145.0/255 blue:255.0/255 alpha:1]
#define COLOR3 [UIColor colorWithRed:159.0/255 green:36.0/255 blue:233.0/255 alpha:1]
#define COLOR4 [UIColor colorWithRed:48.0/255 green:218.0/255 blue:169.0/255 alpha:1]
#define COLOR5 [UIColor colorWithRed:50.0/255 green:197.0/255 blue:66.0/255 alpha:1]

#define COLOR6 [UIColor colorWithRed:255.0/255 green:255.0/255 blue:37.0/255 alpha:1]
#define COLOR7 [UIColor colorWithRed:252.0/255 green:0.0/255 blue:138.0/255 alpha:1]
#define COLOR8 [UIColor colorWithRed:144.0/255 green:92.0/255 blue:17.0/255 alpha:1]
#define COLOR9 [UIColor colorWithRed:252.0/255 green:109.0/255 blue:113.0/255 alpha:1]
#define COLOR10 [UIColor colorWithRed:78.0/255 green:249.0/255 blue:253.0/255 alpha:1]
#define COLOR11 [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1]

#endif /* Constants_h */
