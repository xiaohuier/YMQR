//
//  BaseModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/6.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+MJKeyValue.h>
#import <FMDB.h>

@interface BaseModel : NSObject

//@property (nonatomic,strong)NSArray *allKeys;
//
//@property (nonatomic,strong)NSArray *allvalues;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

-(NSString *)description;

-(instancetype)initWithReultSet:(FMResultSet *)resultSet;

+(NSArray *)modelArrayFromDictArray: (NSArray *)array;

-(NSDictionary *)modelToDic;



-(BOOL)isNull;

-(BOOL)isFull;


@end
