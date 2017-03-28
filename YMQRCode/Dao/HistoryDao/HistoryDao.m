//
//  HistoryDao.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/9.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryDao.h"


@implementation HistoryDao
{
    NSString *_selectTableString;
    
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.tableName = @"TB_History";
        
        NSString *creatTableString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY autoincrement,imagePath TEXT,jsonString TEXT,type TEXT,date datetime)",self.tableName];
        
        NSString *insertTableString = [NSString stringWithFormat:@"INSERT INTO %@ (imagePath,jsonString,type,date) VALUES (:imagePath,:jsonString,:type,datetime('now','+8 hour'))",self.tableName];
        
        _selectTableString = [NSString stringWithFormat:@"SELECT * FROM %@ order by id desc limit ",self.tableName];
        
        NSDictionary *dic = @{@"creatTableString" :creatTableString,
                              @"insertTableString":insertTableString,
                              @"deleteTableString":@"",
                              @"updataTableString":@"",
                              @"selectTableString":@""};
        
        self.sqlStringModel  = [[SqlModel alloc]initWithDictionary:dic];
        
        BOOL success =   [self creatDataBase:self.sqlStringModel.creatTableString];
        
        NSParameterAssert(success);
        
        
    }
    return self;
}

+(instancetype)shareInstance
{
    static HistoryDao *dao;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dao = [[HistoryDao alloc]init];
    });
    
    return dao;
}

-(BOOL)insertModel:(NSDictionary *)dic
{
    NSString *sqlString  = self.sqlStringModel.insertTableString;
    
    return [self addModel:dic withSqlString:sqlString];
}


-(NSArray <NSDictionary *>*)descendSelectHistoryCount:(NSInteger)count offset:(NSInteger)offset
{
    NSString *sqlString = [_selectTableString stringByAppendingFormat:@"%@,%@",@(offset),@(count)];
    
    return  [self selectModel:nil withSqlString:sqlString];
}

@end
