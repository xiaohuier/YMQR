//
//  HistoryScanBookDao.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/23.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryScanBookDao.h"

@implementation HistoryScanBookDao
{
    NSString *_selectTableString;
    NSString *_insertTableString;
    NSString *_creatTableString;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.tableName = @"TB_History_Book";
        
        _creatTableString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY autoincrement,doubanId TEXT,isbn10 TEXT,isbn13 TEXT,title TEXT,image TEXT,publisher TEXT,pubdate TEXT,price TEXT,summary TEXT,author TEXT,translator TEXT,tags TEXT,date datetime)",self.tableName];
        
        _insertTableString = [NSString stringWithFormat:@"INSERT INTO %@ (doubanId,isbn10,isbn13,title,image,publisher,pubdate,price,summary,author,translator,tags,date) VALUES (:doubanId,:isbn10,:isbn13,:title,:image,:publisher,:pubdate,:price,:summary,:author,:translator,:tags,datetime('now','+8 hour'))",self.tableName];
        
        _selectTableString = [NSString stringWithFormat:@"SELECT * FROM %@ order by id desc limit ",self.tableName];
        
        BOOL success =   [self creatDataBase:_creatTableString];
        
        NSParameterAssert(success);
        
        
    }
    return self;
}

+(instancetype)shareInstance
{
    static HistoryScanBookDao *dao;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dao = [[HistoryScanBookDao alloc]init];
    });
    
    return dao;
}

-(BOOL)insertModel:(NSDictionary *)dic
{
    NSString *sqlString  = _insertTableString;
    NSMutableDictionary *mutableDic = [dic mutableCopy];
    
    NSString *tags = [self arrayString:dic[@"tags"]];
    [mutableDic setObject:tags forKey:@"tags"];
    NSString *translator = [self arrayString:dic[@"translator"]];
    [mutableDic setObject:translator forKey:@"translator"];
    NSString *author = [self arrayString:dic[@"author"]];
    [mutableDic setObject:author forKey:@"author"];
    
    return [self addModel:mutableDic.copy withSqlString:sqlString];
}


-(NSArray <NSDictionary *>*)descendSelectHistoryCount:(NSInteger)count offset:(NSInteger)offset
{
    NSString *sqlString = [_selectTableString stringByAppendingFormat:@"%@,%@",@(offset),@(count)];
    
    return  [self selectModel:nil withSqlString:sqlString];
}

-(NSString *)arrayString:(NSArray *)array
{
    NSString *string = @"";
    for (int i =0; i<array.count; i++)
    {
        string = [string stringByAppendingFormat:@"%@,",array[i]];
    }
    return string;
}

-(BOOL)deleteAllData
{
    NSString *sqlString =[NSString stringWithFormat:@"DELETE FROM %@",self.tableName];
    return [self deleteModel:nil withSqlString:sqlString];
    
}
@end
