//
//  GuideScrollView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideScrollView : UIScrollView
@property (nonatomic,readonly)NSArray<UIImage *>*imageArray;
@property (nonatomic,strong)UIButton *startButton;

-(instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray<UIImage *> *)image;

@end
