//
//  YMFMDatebase.h
//  FMDBTest
//
//  Created by junhaoshen on 17/2/6.
//  Copyright © 2017年 junhaoshen. All rights reserved.
//

#import <Foundation/Foundation.h>

//类声明  用于查询返回值
@class FMResultSet;

@interface YMFMDatebase : NSObject

//创建一个类方法获取本类对象
+ (YMFMDatebase *)sharedYMFMDatabase;

/**
 *  建表的功能
 *
 *  @param tableName  数据库的表名
 *  @param fieldDict 数据库表的字段名（不包含主键,key-->字段名,value-->字段类型）
 */
- (void)createTable:(NSString *)tableName byModel:(NSDictionary *) fieldDict;

/**
 *  删表的功能
 *
 *  @param tableName 数据库的表名
 */
- (void)dropTable:(NSString *)tableName;

/**
 *  插入数据
 *
 *  @param tableName 数据库表名
 *  @param fieldDict 数据模型的key-value
 */
- (void)insertDataToTable:(NSString *)tableName byModel:(NSDictionary *)fieldDict;

/**
 *  删除数据
 *
 *  @param tableName 数据库表名
 *  @param name      字段名
 *  @param value     字段值
 */
- (void)deleteDataFromTable:(NSString *)tableName byParaName:(NSString *)name paraVulue:(id)value;

/**
 *  查询数据
 *
 *  @param tableName 数据库表名
 *  @param name      字段名   （当字段名为空时，查询并返回数据库所有数据）
 *  @param value     字段值
 *
 *  @return 查询的结果
 */
- (FMResultSet *)selectFromTable:(NSString *)tableName byParaName:(NSString *)name paraValue:(id)value;

/**
 *  修改数据
 *
 *  @param tableName 数据库表名
 *  @param dict      修改数据的表达式条件key-value    （一对key-value）
 *  @param dict2     待修改的字段key-value           （一对key-value）
 */
- (void)updateTable:(NSString *)tableName paraDict:(NSDictionary *)dict newParaDict:(NSDictionary *)dict2;

/**
 *  事务删除数据
 *
 *  @param tableName 数据库表名
 *  @param name      字段名
 *  @param value     字段值
 */
- (void)deleteinTransactionDataFromTable:(NSString *)tableName byParaName:(NSString *)name paraVulue:(NSArray *)dataArray;


@end
