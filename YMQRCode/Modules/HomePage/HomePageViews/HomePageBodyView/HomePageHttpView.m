//
//  HomePageHttpView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/13.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageHttpView.h"

@interface HomePageHttpView ()<UITextViewDelegate>

@end

@implementation HomePageHttpView

{
    UITextView *_codeTextView;
    UILabel *_fillLabel;
    UILabel *_textlabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    //二维码内容填写区域
    _codeTextView = [[UITextView alloc]init];
    
    _codeTextView.layer.cornerRadius = 10;
    _codeTextView.delegate = self;
    _codeTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    
    [self addSubview:_codeTextView];
    
    _fillLabel = [[UILabel alloc]init];
    _fillLabel.font = [UIFont systemFontOfSize:13];
    _fillLabel.textColor = WORDSCOLOR;
    _fillLabel.text = @"http://或者https://";
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    _textlabel.text = @"注意：填写网址的时候请输入http://或者https://完整的网址信息;如果你的网址过长，生成的二维码将不易被扫描";
    _textlabel.textColor = WORDSCOLOR;
    [self addSubview:_textlabel];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    [_codeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo((width - 240)/4);
        
        make.right.mas_equalTo(0 - (width - 240)/4);
        
        make.top.mas_equalTo(self.mas_top);
        
        make.height.mas_equalTo(120);
    }];
    
    [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_codeTextView.mas_bottom).offset(1);
        
        make.left.mas_equalTo(_codeTextView.mas_left);
        
        make.right.mas_equalTo(_codeTextView.mas_right);
        
//        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    
    
    [_fillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_codeTextView.mas_left).offset(6);
        
        make.right.mas_equalTo(_codeTextView.mas_right).offset(-6);
        
        make.top.mas_equalTo(_codeTextView.mas_top).offset(2);
        
        make.height.mas_equalTo(25);
        
    }];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location == 0) {
        
        [_fillLabel setHidden:NO];
        
    }
    
    if (text.length != 0) {
        
        [_fillLabel setHidden:YES];
        
    }
    return YES;
}

-(BOOL)isNULL
{
    if (_codeTextView.text.length==0) {
        return NO;
    }else{
        return YES;
    }
}

-(NSString *)textString
{
    return _codeTextView.text;
}
@end
