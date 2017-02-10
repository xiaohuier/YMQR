//
//  YMQRCodeAppService.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/9.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "YMQRCodeAppService.h"

@implementation YMQRCodeAppService

+(instancetype)shareInstance
{
    static YMQRCodeAppService *appService= nil;
    if (appService == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            appService = [[YMQRCodeAppService alloc]init];
        });
        
    }
    return appService;
}


@end
