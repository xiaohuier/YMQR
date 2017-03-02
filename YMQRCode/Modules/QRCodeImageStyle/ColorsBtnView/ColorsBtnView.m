//
//  ColorsBtnView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "ColorsBtnView.h"

@implementation ColorsBtnView
{
    NSMutableArray<UIButton *> *_btnArray;
    NSArray <UIColor *>*_colorArray;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        _btnArray = [NSMutableArray array];
        [self initSubView];
    }
    return self;
}


-(void)initSubView
{
    _colorArray = @[RGB(251, 20, 37),RGB(252, 147, 37),RGB(41, 145, 255),RGB(159, 36, 233),RGB(48, 218, 169),RGB(50, 197, 66),RGB(255, 255, 37),RGB(252, 0, 138),RGB(144, 92, 17),RGB(252, 109, 113),RGB(78, 249, 253),RGB(0, 0, 0)];
    for (int i = 0; i<12; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = _colorArray[i];
        [btn addTarget:self action:@selector(colorsButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_btnArray addObject:btn];
    }
}

-(void)colorsButtonOnClick:(UIButton *)button
{
    
    NSInteger index = [_btnArray indexOfObject:button];
    UIColor *color = [_colorArray objectAtIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(colorsButtonOnClick:)]) {
        [self.delegate colorsButtonOnClick:color];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger interval = 5;
    
    NSInteger width = (self.frame.size.width - 5 * interval)/6;
    
    CGSize size = CGSizeMake(width, width);
     UIView *lastView = self;
    for (int i = 0; i<_btnArray.count; i++) {
        UIButton *btn = [_btnArray objectAtIndex:i];
        if (i== 0) {
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView).offset(interval);
                make.top.mas_equalTo(lastView.mas_top).offset(interval);
                make.size.mas_equalTo(size);
            }];
        }else if (i==6){
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(interval);
                make.top.mas_equalTo(lastView.mas_bottom).offset(interval);
                make.size.mas_equalTo(size);
            }];
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).offset(interval);
                make.top.mas_equalTo(lastView);
                make.size.mas_equalTo(size);
            }];
        }
        
        lastView = btn;
    }
    
}
@end
