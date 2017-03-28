//
//  HistoryService.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/15.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryService.h"

@implementation HistoryService
+(NSArray <HistoryTextModel *>*)selectHistoryTextCount:(NSInteger)count offset:(NSInteger)offset
{
   NSArray <NSDictionary *>* array = [[HistoryTextDao shareInstance]descendSelectHistoryCount:count offset:offset];
    
    NSMutableArray <HistoryTextModel *>* mutableArray = @[].mutableCopy;
    
    for (NSDictionary *dic in array) {
        HistoryTextModel *model = [[HistoryTextModel alloc]initWithDictionary:dic];
        [mutableArray addObject:model];
    }
    return mutableArray.copy;
}



+(NSArray <HistoryBookModel *>*)selectHistoryScanBookCount:(NSInteger)count offset:(NSInteger)offset
{
    NSArray <NSDictionary *>* array = [[HistoryScanBookDao shareInstance]descendSelectHistoryCount:count offset:offset];
    
    NSMutableArray <HistoryBookModel *>* mutableArray = @[].mutableCopy;
    
    for (NSDictionary *dic in array) {
        NSMutableDictionary *mutableDic = dic.mutableCopy;
        NSMutableArray *stringArray;
        
        NSString *tags = dic[@"tags"];
        stringArray = [tags componentsSeparatedByString:@","].mutableCopy;
        [stringArray removeLastObject];
        [mutableDic setObject:stringArray forKey:@"tags"];
        
        NSString *translator = dic[@"translator"];
        stringArray = [translator componentsSeparatedByString:@","].mutableCopy;
        [stringArray removeLastObject];
        [mutableDic setObject:stringArray forKey:@"translator"];
        
        NSString *author = dic[@"author"];
        stringArray = [author componentsSeparatedByString:@","].mutableCopy;
        [stringArray removeLastObject];
        [mutableDic setObject:stringArray forKey:@"author"];
        
        HistoryBookModel *model = [[HistoryBookModel alloc]initWithDictionary:mutableDic];
        [mutableArray addObject:model];
    }
    return mutableArray.copy;
}

+(NSArray <HistoryTextModel *>*)selectHistoryScanTextCount:(NSInteger)count offset:(NSInteger)offset
{
    NSArray <NSDictionary *>* array = [[HistoryScanTextDao shareInstance]descendSelectHistoryCount:count offset:offset];
    
    NSMutableArray <HistoryTextModel *>* mutableArray = @[].mutableCopy;
    
    for (NSDictionary *dic in array) {
        HistoryTextModel *model = [[HistoryTextModel alloc]initWithDictionary:dic];
        [mutableArray addObject:model];
    }
    return mutableArray.copy;
}

@end
