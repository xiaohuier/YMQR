//
//  YMQRCodeAppService.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/9.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMQRCodeAppService : NSObject

+(instancetype)shareInstance;
/**存储最终界面展示的*/
@property (nonatomic,strong)UIImage *QRCodeImage;
/**最初的黑白二维码照片*/
@property (nonatomic,strong)UIImage *originalQRCodeImage;
/**用户切出来的自定义图片*/
@property (nonatomic,strong)UIImage *cutImage;

@end
