//
//  CutImageView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutImageView : UIView

@property (nonatomic,assign)NSInteger touchMoveLength;

@property (nonatomic,assign)CGSize cutImageRectMin;

@property (nonatomic,assign)CGRect clearRect;

@end
