//
//  MessageModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property(nonatomic,strong)NSString *sms;

@property(nonatomic,strong)NSString *body;
@end
