//
//  HomePageHeaderView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageBodyView.h"

@protocol HomePageHeaderDelegate <NSObject>

-(void)homePageHeaderButtonChangeType: (QRStringType)homePageBodyType;

@end



@interface HomePageHeaderView : UIView

@property (nonatomic,assign)QRStringType homePageBodyType;

@property (nonatomic ,assign)id <HomePageHeaderDelegate> delegate;




@end
