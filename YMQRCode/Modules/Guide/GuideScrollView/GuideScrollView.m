//
//  GuideScrollView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "GuideScrollView.h"
@interface GuideScrollView()
@property (nonatomic,strong)NSArray<UIImage *>*imageArray;
@end
@implementation GuideScrollView

-(instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray<UIImage *> *)images
{
    if (self = [super initWithFrame:frame]) {
        self.imageArray = images;
        
        [self initSubView];
    }
    return self;
}
-(void)initSubView
{
    for (int i = 0; i < 3; i ++)
    {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imageview setImage:self.imageArray[i]];
        imageview.userInteractionEnabled = YES;
        [self addSubview:imageview];
        
        if (i == 2)
        {
            self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];//在最后imageview上加载一个透明的button
            [self.startButton setTitle:nil forState:UIControlStateNormal];
            [self.startButton setFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
            [imageview addSubview:self.startButton];
        }
    }
}
@end
