//
//  HomePageTelPhoneView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/13.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageTelPhoneView.h"
@interface HomePageTelPhoneView ()<UITextViewDelegate>

@end
@implementation HomePageTelPhoneView
{
    UIView *_textFileView;
    UITextField *_textFile;
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
    _fillLabel.text = @"请输入家庭号码或手机号";
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    _textlabel.text = @"☎️生成的电话号码二维码，扫描之后，手机可直接拨打扫描的电话号";
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

-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        
        [_fillLabel setHidden:NO];
        
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
       
    if (text.length != 0) {
        
        [_fillLabel setHidden:YES];
        
    }
    return YES;
}

-(BOOL)isNullString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string  isEqualToString:@"null"]) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
}


-(NSString *)textString
{
    
        
    //        NSDictionary *dic = @{@"text":_codeTextView.text};
    //
    //        NSString *textString = [dic yy_modelToJSONString];
    
    NSString *textString;
    
    if (![self isNullString:_codeTextView.text]){
        
        textString = [NSString stringWithFormat:@"tel:%@",_codeTextView.text];
        
    }else{
        
        textString = @"";
    }
    
    return  textString;
        
}
@end
