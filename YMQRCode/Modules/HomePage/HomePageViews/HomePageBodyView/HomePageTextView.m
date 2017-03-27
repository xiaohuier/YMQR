//
//  HomePageTextView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/13.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageTextView.h"
@interface HomePageTextView()<UITextViewDelegate>
@end
@implementation HomePageTextView
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
    _fillLabel.text = @"支持输入基本的文本数据和网站";
    _fillLabel.textColor = WORDSCOLOR;
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    _textlabel.text = [NSString stringWithFormat:@"已输入字符：0个"];
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
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        
        make.left.equalTo(_codeTextView.mas_left).offset(6);
        
        make.top.equalTo(_codeTextView.mas_top).offset(2);
    }];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length !=0&&range.location == 0) {
        
        _textlabel.text = [NSString stringWithFormat:@"已输入字符: 1个"];
        
    }else if(range.location != 0&&text.length !=0){
        
        _textlabel.text = [NSString stringWithFormat:@"已输入字符: %lu个",(unsigned long)range.location+1];
        
    }else if (text.length ==0){
        
        _textlabel.text = [NSString stringWithFormat:@"已输入字符: %lu个",(unsigned long)range.location];
        
    }
    
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
    
    NSDictionary *dic = @{@"text":_codeTextView.text};
    
    NSString *textString = [dic yy_modelToJSONString];
    
    return  textString;
    
}

@end
