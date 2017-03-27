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
@property (nonatomic,assign)QRStringType type;
@end

@implementation HomePageBodyView

+(instancetype)bodyViewWithType:(QRStringType)type
{
    HomePageBodyView *view;
    switch (type) {
        case QRStringHTTPType:
            view = [[HomePageHttpView alloc]init];
            view.type = type;
            break;
        case QRStringTextType:
           view = [[HomePageTextView alloc]init];
            view.type = type;
            break;
        case QRStringVCardType:
            view = [[HomePageVCardView alloc]init];
            view.type = type;
            break;
        case QRStringTelPhoneType:
            view = [[HomePageTelPhoneView alloc]init];
            view.type = type;
            break;
        case QRStringMessageType:
            view = [[HomePageMessageView alloc]init];
            view.type = type;
            break;
    }
    return view;
    
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
