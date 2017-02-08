//
//  Enums.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#ifndef Enums_h
#define Enums_h
//HomePageBodyView 的type
typedef NS_ENUM(NSInteger,HomePageBodyType)
{
    HomePageBodyHTTPType = 0,
    HomePageBodyTextType,
    HomePageBodyVCardType,
    HomePageBodyTelPhoneType,
    HomePageBodyMessageType
};

//QRImageType二维码图片格式
typedef NS_ENUM(NSUInteger,QRImageType)
{
    QRImageTypeMario = 0,
    QRImageTypeDish,
    QRImageTypeBread,
    QRImageTypeLeaf,
    QRImageTypeBuild,
    QRImageTypeDefult
};


#endif /* Enums_h */
