//
//  DataBase.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "SqlModel.h"

@interface DataBase : NSObject

@property (nonatomic,strong)FMDatabase *db;


@property (nonatomic,strong)NSString *tableName;


+(instancetype)shareInstance;

/**建表*/
-(BOOL)creatDataBase:(NSString *)sqlString;

/**增*/
-(BOOL)addModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString;

/**删*/
-(BOOL)deleteModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString;

/**改*/
-(BOOL)updateModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString;

/**查*/
-(NSArray <NSDictionary *>*)selectModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString;

@end
