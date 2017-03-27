//
//  HistoryModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/10.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@interface HistoryTextModel : BaseModel

@property (nonatomic,strong)NSString *date;

@property (nonatomic)QRStringType type;

@property (nonatomic,strong)NSString *jsonString;

@property (nonatomic,strong)NSString *imagePath;
@end
