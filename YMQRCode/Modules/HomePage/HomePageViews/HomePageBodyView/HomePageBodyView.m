//
//  HomePageBodyView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageBodyView.h"

#import "HomePageTelPhoneView.h"
#import "HomePageVCardView.h"
#import "HomePageTextView.h"
#import "HomePageHttpView.h"
#import "HomePageMessageView.h"

@interface HomePageBodyView ()
@property (nonatomic,copy)NSString *textString;
@end

@implementation HomePageBodyView

+(instancetype)bodyViewWithType:(HomePageBodyType)type
{
    switch (type) {
        case HomePageBodyHTTPType:
            return [[HomePageHttpView alloc]init];
            break;
        case HomePageBodyTextType:
            return [[HomePageTextView alloc]init];
            break;
        case HomePageBodyVCardType:
            return [[HomePageVCardView alloc]init];
            break;
        case HomePageBodyTelPhoneType:
            return [[HomePageTelPhoneView alloc]init];
            break;
        case HomePageBodyMessageType:
            return [[HomePageMessageView alloc]init];
            break;
    }
}

-(BOOL)isNULL
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "" for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"HomePageViewException" reason:msg userInfo:nil];
}

//-(NSString *)textString
//{
//    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "" for the class %@",sel_getName(_cmd),self];
//    @throw [NSException exceptionWithName:@"HomePageViewException" reason:msg userInfo:nil];
//}

@end
