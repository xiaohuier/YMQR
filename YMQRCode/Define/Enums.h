//
//  Enums.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

//二维码字符串 的type
typedef NS_ENUM(NSInteger,QRStringType)
{
    QRStringHTTPType = 0,
    QRStringTextType,
    QRStringVCardType,
    QRStringTelPhoneType,
    QRStringMessageType
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

//QRScanViewType扫码格式
typedef NS_ENUM(NSUInteger,QRScanViewType)
{
    QRScanViewBarCodeType = 0,//条形码
    QRScanViewQRCodeType  //二维码
};


/**
 历史记录格式
 - QRHistoryCreatType:
 */
typedef NS_ENUM(NSUInteger,QRHistoryType)
{
    QRHistoryCreatType = 0,//创建
    QRHistoryScanType, //扫描
    QRHistoryBookType //图书
};

#endif /* Enums_h */
