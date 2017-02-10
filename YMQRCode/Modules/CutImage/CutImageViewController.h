//
//  CutImageViewController.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseViewController.h"

@interface CutImageViewController : BaseViewController

@property (nonatomic,readonly)UIImage *cutImage;

-(instancetype)initWithCutImage:(UIImage *)cutImage;

@end
