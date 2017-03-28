//
//  SqlModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@interface SqlModel : BaseModel



@property (nonatomic,copy)NSString *creatTableString;

@property (nonatomic,copy)NSString *insertTableString;

@property (nonatomic,copy)NSString *deleteTableString;

@property (nonatomic,copy)NSString *updataTableString;

@property (nonatomic,copy)NSString *selectTableString;

@end
