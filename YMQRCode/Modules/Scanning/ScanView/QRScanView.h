//
//  QRScanView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/14.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanView : UIView
-(instancetype)initWithFrame:(CGRect)frame
                    rectSize:(CGSize)size
                     offsetY:(CGFloat)offsetY;

-(void)startAnimation;

-(void)stopAnimation;

@property (nonatomic,copy)NSString *tipString;

@property (nonatomic,assign)NSInteger bottom;
@end
