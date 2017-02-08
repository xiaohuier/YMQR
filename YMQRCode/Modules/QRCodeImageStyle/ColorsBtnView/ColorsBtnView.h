//
//  ColorsBtnView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorsBtnViewDelegate<NSObject>
-(void)colorsButtonOnClick:(UIColor *)clickColor;
@end

@interface ColorsBtnView : UIView
@property (nonatomic,weak)id<ColorsBtnViewDelegate> delegate;
@end
