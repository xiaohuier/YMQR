//
//  HistoryScanTextDao.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/23.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryScanTextDao.h"

@implementation HistoryScanTextDao
{
    NSString *_selectTableString;
    NSString *_insertTableString;
    NSString *_creatTableString;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.tableName = @"TB_History_Scan_Text";
        
        _creatTableString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY autoincrement,imagePath TEXT,jsonString TEXT,date datetime)",self.tableName];
        
        _insertTableString = [NSString stringWithFormat:@"INSERT INTO %@ (imagePath,jsonString,date) VALUES (:imagePath,:jsonString,datetime('now','+8 hour'))",self.tableName];
        
        _selectTableString = [NSString stringWithFormat:@"SELECT * FROM %@ order by id desc limit ",self.tableName];
        
        
        BOOL success =   [self creatDataBase:_creatTableString];
        
        NSParameterAssert(success);
        
        
    }
    return self;
}

+(instancetype)shareInstance
{
    static HistoryScanTextDao *dao;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dao = [[HistoryScanTextDao alloc]init];
    });
    
    return dao;
}

-(BOOL)insertModel:(NSDictionary *)dic
{
    NSString *sqlString  = _insertTableString;
    
    return [self addModel:dic withSqlString:sqlString];
}


-(NSArray <NSDictionary *>*)descendSelectHistoryCount:(NSInteger)count offset:(NSInteger)offset
{
    NSString *sqlString = [_selectTableString stringByAppendingFormat:@"%@,%@",@(offset),@(count)];
    
    return  [self selectModel:nil withSqlString:sqlString];
}

-(BOOL)deleteAllData
{
    NSString *sqlString =[NSString stringWithFormat:@"DELETE FROM %@",self.tableName];
    return [self deleteModel:nil withSqlString:sqlString];
    
}
@end
