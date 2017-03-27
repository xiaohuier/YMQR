//
//  QRScanService.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryBookModel.h"

@interface QRScanService : NSObject
+(void)fetchBookWithISBN: (NSString *)ISBN completionHandle:(void (^)(HistoryBookModel *bookmodel))completionHandle;
@end
