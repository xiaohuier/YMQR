//
//  YMFMDatebase.m
//  FMDBTest
//
//  Created by junhaoshen on 17/2/6.
//  Copyright © 2017年 junhaoshen. All rights reserved.
//

#import "YMFMDatebase.h"

#import "FMDatabase.h"
#import "QrcodeModel.h"

//定义本工程使用的数据库路径
#define DBPATH [NSString stringWithFormat:@"%@/Documents/mijinQrcodeData.db", NSHomeDirectory()]

@implementation YMFMDatebase

{
    //全局的FMDatabase对象
    FMDatabase *_database;
    
    //线程锁
    NSLock *_lock;
    
    NSDictionary *ymDict;
    
}

+ (YMFMDatebase *)sharedYMFMDatabase
{
    YMFMDatebase *ymfmdatabase;
    //创建一个对象并返回
    //考虑多线程，不允许多条线层同时调用此函数体的内容
    @synchronized(self){
        ymfmdatabase = [[self alloc] init];
    }
    return ymfmdatabase;
}

- (instancetype)init
{
    if (self = [super init]) {
        //自定义的操作
        //实例化_database对象
        _database = [[FMDatabase alloc] initWithPath:DBPATH];
        //打开数据库
        [_database open];
        //初始化线程锁
        _lock = [[NSLock alloc] init];
        
    }
    return self;
}

- (void)createTable:(NSString *)tableName byModel:(NSDictionary *)fieldDict
{
    //加锁
    [_lock lock];
    
    ymDict = fieldDict;
    
    NSMutableString *sqlContent = [NSMutableString string];
    int i = 0;
    for (NSString *key in fieldDict) {
        if (i == 0) {
            [sqlContent appendFormat:@"%@ %@", key, fieldDict[key]];
        }else{
            [sqlContent appendFormat:@",%@ %@", key, fieldDict[key]];
        }
        i ++;
    }
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key autoincrement, %@)", tableName, sqlContent];
    
    //执行sql语句
    BOOL bo = [_database executeUpdate:sql];
    
    if (!bo) {
        NSLog(@"创建表失败：%@", _database.lastErrorMessage);
    }else{
        NSLog(@"创建表成功 %d",bo);
    }
    
    //解锁
    [_lock unlock];
}

- (void)dropTable:(NSString *)tableName
{
    [_lock lock];
    NSString *sql = [NSString stringWithFormat:@"drop table %@", tableName];
    BOOL bo = [_database executeUpdate:sql];
    if (!bo) {
        NSLog(@"删除表失败：%@", _database.lastErrorMessage);
    }else{
        NSLog(@"删除表成功 %d",bo);
    }
    
    [_lock unlock];
}

- (void)insertDataToTable:(NSString *)tableName byModel:(NSDictionary *)fieldDict
{
    [_lock lock];
    
    NSMutableString *sqlContent1 = [NSMutableString string];
    int i = 0;
    for (NSString *key in fieldDict) {
        if (i == 0) {
            [sqlContent1 appendFormat:@"%@", key];
        }else{
            [sqlContent1 appendFormat:@",%@", key];
        }
        i ++;
    }
    
    NSMutableString *sqlContent2 = [NSMutableString string];
    int j = 0;
    for (NSString *key in fieldDict) {
        if (j == 0) {
            [sqlContent2 appendFormat:@"%@", @"?"];
        }else{
            [sqlContent2 appendFormat:@",%@", @"?"];
        }
        j ++;
    }
    
    //组装sql语句
    NSString *sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@)", tableName, sqlContent1, sqlContent2];
    
    //模型 （字典）  成员属性
    NSArray *keyArray = [fieldDict allKeys];

    if (keyArray.count == 2) {
        BOOL bo = [_database executeUpdate:sql, fieldDict[keyArray[0]], fieldDict[keyArray[1]]];
        if (!bo) {
            NSLog(@"插值错误：%@", _database.lastErrorMessage);
        }else{
            NSLog(@"插值成功 %d",bo);
            
        }
    }
    
    
    [_lock unlock];
}

- (void)deleteDataFromTable:(NSString *)tableName byParaName:(NSString *)name paraVulue:(id)value
{
    [_lock lock];
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?", tableName, name];
    
    BOOL bo = [_database executeUpdate:sql, value];
    
    if (!bo) {
        NSLog(@"删除失败：%@", _database.lastErrorMessage);
    }else{
        NSLog(@"删除成功 %d",bo);
        
    }
    
    [_lock unlock];
}

- (FMResultSet *)selectFromTable:(NSString *)tableName byParaName:(NSString *)name paraValue:(id)value
{
    [_lock lock];
    
    FMResultSet *result = nil;
    
    if (name == nil) {
        //全查
        result = [_database executeQuery:[NSString stringWithFormat:@"select * from %@",tableName]];
        
    }else{
        //特定值查询
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = ?", tableName, name];
        result = [_database executeQuery:sql, value];
        
    }
    
    [_lock unlock];
    
    return result;
}

- (void)updateTable:(NSString *)tableName paraDict:(NSDictionary *)dict newParaDict:(NSDictionary *)dict2
{
    [_lock lock];
    
    NSString *key1 = [[dict allKeys] firstObject];
    NSString *key2 = [[dict2 allKeys] firstObject];
    
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = ? where %@ = ?", tableName, key2, key1];
    
    BOOL bo = [_database executeUpdate:sql, dict2[key2], dict[key1]];
    
    if (!bo) {
        NSLog(@"修改失败：%@", _database.lastErrorMessage);
    }else{
        NSLog(@"修改成功 %d",bo);
    }
    
    [_lock unlock];
}

- (void)deleteinTransactionDataFromTable:(NSString *)tableName byParaName:(NSString *)name paraVulue:(NSArray *)dataArray;{
    
    [_lock lock];
    
    [_database beginTransaction];
    
    QrcodeModel *qrcode = [[QrcodeModel alloc]init];
    
    for (int i = 0; i < dataArray.count; i ++) {
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?", tableName, name];
        
        qrcode = dataArray[i];
        
        BOOL bo = [_database executeUpdate:sql, [qrcode time]];
        
        NSLog(@"%d", bo);
        
        if (!bo) {
            NSLog(@"批量删除失败：%@", _database.lastErrorMessage);
        }else{
            NSLog(@"批量删除成功 %d",bo);
            
        }
    }
    
    BOOL commitSuccess = [_database commit];
    
    NSLog(@"提交事务：%d", commitSuccess);
    
 
    
    [_lock unlock];
    
    
    
}



- (void)dealloc
{
    //关闭数据库
    [_database close];
    _database = nil;
}






@end
