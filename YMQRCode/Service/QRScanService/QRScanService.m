//
//  QRScanService.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRScanService.h"
#import <AFNetworking.h>

@implementation QRScanService

+(void)fetchBookWithISBN: (NSString *)ISBN completionHandle:(void (^)(HistoryBookModel *bookmodel))completionHandle
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",ISBN]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        id dic =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutableDic = [dic mutableCopy];
            
            if ([dic[@"tags"] isKindOfClass:[NSArray class]] )
            {
                NSArray *tags = [self arrayToString:dic[@"tags"] with:@"name"];
                [mutableDic setObject:tags forKey:@"tags"];
            }
            
             HistoryBookModel *bookModel = [[HistoryBookModel alloc]initWithDictionary:mutableDic];
            completionHandle(bookModel);
        }
       
    }];
    [task resume];

}
+(NSArray *)arrayToString:(NSArray *)array with:(NSString *)key
{
    NSMutableArray *MutableArray = @[].mutableCopy;
    
    if (array.count == 0) {
        return @[];
    }else{
        for (NSDictionary *dic in array) {
            [MutableArray addObject: dic[key]];
        }
        return MutableArray.copy;
    }
}
@end
