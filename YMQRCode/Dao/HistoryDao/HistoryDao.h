//
//  HistoryDao.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/9.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "DataBase.h"

@interface HistoryDao : DataBase

/**
 插入一条

 @param dic 插入的dic
 @return bool
 */
-(BOOL)insertModel:(NSDictionary *)dic;

/**
 查询历史

 @param count 查询数量
 @param offset 偏移量
 @return 数组
 */
-(NSArray <NSDictionary *>*)descendSelectHistoryCount:(NSInteger)count offset:(NSInteger)offset;

@end
