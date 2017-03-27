//
//  DataBaseHelper.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "DataBaseHelper.h"
#import <FMDB.h>

@implementation DataBaseHelper

+(NSString *)dbFolder
{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docsdir stringByAppendingString:@"/db"];
    return path;
}

+(NSString *)dbPath
{
    
    NSString *dbPath = [[[self class] dbFolder] stringByAppendingString:@"/YMQRcode.sqlite"];
    return dbPath;
    
}

+(FMDatabase *)buildDataBase
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class] dbPath]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[[self class]dbFolder] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSLog(@"DataBase = %@\n------------------------------------",[[self class]dbPath]);
    
    FMDatabase *db = [FMDatabase databaseWithPath:[[self class] dbPath]];
    if (![db open]) {
        return nil;
    }
    [db close];
    
    return db;
}



@end
