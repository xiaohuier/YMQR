//
//  BaseModel.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/6.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    NSParameterAssert(![dic isEqual:@{}]);
    
    self = [[self class]mj_objectWithKeyValues:dic];
    
    return self;
}

-(NSString *)description
{
    NSDictionary *dic = [self mj_keyValues];
    return dic.description;
}

-(BOOL)isNull
{
    NSParameterAssert(0);
    //子类必须重载这个方法
    return nil;
}

-(BOOL)isFull
{
    NSParameterAssert(0);
     //子类必须重载这个方法
    return nil;
}

+(NSArray *)modelArrayFromDictArray: (NSArray *)array
{
    NSParameterAssert(array.count);
    
    return  [[[self class] alloc]mj_objectArrayWithKeyValuesArray:array];
}

-(instancetype)initWithReultSet:(FMResultSet *)resultSet
{
    NSDictionary *dic = resultSet.resultDictionary;
    return [[[self class]alloc]initWithDictionary:dic];
}

-(NSDictionary *)modelToDic
{
    return self.mj_keyValues.copy;
}
@end
