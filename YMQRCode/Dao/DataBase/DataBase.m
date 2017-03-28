//
//  DataBase.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "DataBase.h"
#import "DataBaseHelper.h"

@implementation DataBase

-(FMDatabase *)db
{
    if (_db == nil) {
        _db = [DataBaseHelper buildDataBase];
    }
    NSParameterAssert(_db);
    return _db;
}

+(instancetype)shareInstance
{
    NSParameterAssert(0);
    return nil;
}

/**建表*/
-(BOOL)creatDataBase:(NSString *)sqlString
{
    BOOL success= NO;
    
    
    NSParameterAssert(sqlString);
    
    if (![self.db open]) {
        return NO;
    }
    
    if ([self.db executeUpdate:sqlString]) {
        success = YES;
    }
    [self.db close];
    
    return success;
    
}

/**增*/
-(BOOL)addModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString
{
    BOOL success= NO;
    
    NSParameterAssert(sqlString);
    
    if (![self.db open]) {
        return NO;
    }
    
    if ([self.db executeUpdate:sqlString withParameterDictionary:dic]) {
        success = YES;
    }
    [self.db close];
    return success;
    
}

/**删*/
-(BOOL)deleteModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString
{
    BOOL success= NO;
    

    NSParameterAssert(sqlString);
    
    if (![self.db open]) {
        return NO;
    }
    
    if ([self.db executeUpdate:sqlString withParameterDictionary:dic]) {
        success = YES;
    }
    [self.db close];
    return success;
}

/**改*/
-(BOOL)updateModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString
{
    BOOL success= NO;
    
    
    NSParameterAssert(sqlString);
    
    if (![self.db open]) {
        return NO;
    }
    
    if ([self.db executeUpdate:sqlString withParameterDictionary:dic]) {
        success = YES;
    }
    [self.db close];
    return success;
}

/**查*/
-(NSArray <NSDictionary *>*)selectModel:(NSDictionary *)dic withSqlString:(NSString *)sqlString
{
    NSMutableArray *mutableArray = @[].mutableCopy;
    
    
    NSParameterAssert(sqlString);
    
    if (![self.db open]) {
        return nil;
    }
    
    FMResultSet *s = [self.db executeQuery:sqlString withParameterDictionary:dic];

    while ([s next]) {
        [mutableArray addObject:s.resultDictionary];
    }
    
    [self.db close];
    
    return mutableArray.copy;
}

@end
