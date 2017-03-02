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


#define TRANSFROM_IPHONE6_WIDTH(width) width/IPHONE6_SCREEN_WIDTH*SCREEN_WIDTH

#define TRANSFROM_IPHONE6_HEIGHT(height) height/IPHONE6_SCREEN_HEIGHT*SCREEN_HEIGHT

//机型判断
#define IS_IPHONE_4_OR_LESS (SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (SCREEN_HEIGHT == 736.0)

//设置颜色
//十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue  & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue  & 0xFF))/255.0 alpha:alphaValue]

//RGB
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//系统判断
#define IOS8_0 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f

#define IOS9_1 [[[UIDevice currentDevice] systemVersion] floatValue] < 10.0

#define IOS10_0 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0

#define BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define WORDSCOLOR [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];

#define DEEPCOLOR [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];

#define BLUECOLOR [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];



#endif /* Constants_h */
