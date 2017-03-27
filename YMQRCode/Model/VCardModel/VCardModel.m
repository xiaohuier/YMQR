//
//  VCardModel.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "VCardModel.h"

@implementation VCardModel
-(void)miao
{
    NSDictionary *dic = @{@"123":@"456"};
    id jsonObj = [dic yy_modelToJSONObject];
    
}
@end
