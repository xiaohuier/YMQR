//
//  HistoryService.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/15.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HistoryTextDao.h"
#import "HistoryTextModel.h"

#import "HistoryBookModel.h"
#import "HistoryScanBookDao.h"

#import "HistoryScanTextDao.h"

@interface HistoryService : NSObject

+(NSArray <HistoryTextModel *>*)selectHistoryTextCount:(NSInteger)count offset:(NSInteger)offset;

+(NSArray <HistoryBookModel *>*)selectHistoryScanBookCount:(NSInteger)count offset:(NSInteger)offset;

+(NSArray <HistoryTextModel *>*)selectHistoryScanTextCount:(NSInteger)count offset:(NSInteger)offset;

@end
