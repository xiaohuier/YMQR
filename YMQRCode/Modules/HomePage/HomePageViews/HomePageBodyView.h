//
//  HomePageBodyView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HomePageBodyType)
{
    HomePageBodyHTTPType = 0,
    HomePageBodyTextType,
    HomePageBodyVCardType,
    HomePageBodyTelPhoneType,
    HomePageBodyMessageType
};

@interface HomePageBodyView : UIView 

- (instancetype)initWithType:(HomePageBodyType)type;

@end
