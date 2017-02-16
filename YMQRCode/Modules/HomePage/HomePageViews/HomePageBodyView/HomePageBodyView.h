//
//  HomePageBodyView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageBodyView : UIView

+(instancetype)bodyViewWithType:(HomePageBodyType)type;

-(BOOL)isNULL;

@property (nonatomic,copy,readonly)NSString *textString;

@end
