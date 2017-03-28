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

/******这个类的作用，保存app所需要的三个image，并且在适合的时候，把image记录进入数据库******/


/**存储最终界面展示的*/
@property (nonatomic,strong)UIImage *QRCodeImage;

/**最初的黑白二维码照片*/
@property (nonatomic,strong)UIImage *originalQRCodeImage;

/**用户切出来的自定义图片*/
@property (nonatomic,strong)UIImage *cutImage;

//@property (nonatomic,strong,readonly)NSString *imagePath;

-(BOOL)insertToDataBaseWithType:(NSUInteger)type jsonString:(NSString *)jsonString;


@end
