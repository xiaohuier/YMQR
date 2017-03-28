//
//  VCardModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@interface VCardModel : BaseModel


@property(nonatomic,strong)NSString *vcard;

@property(nonatomic,strong)NSString *fn;

@property(nonatomic,strong)NSString *org;

@property(nonatomic,strong)NSString *adr;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *tel;

@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *email;

@property(nonatomic,strong)NSString *note;

@end
