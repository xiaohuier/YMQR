//
//  HomePageMessageView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/13.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageMessageView.h"

@interface HomePageMessageView ()<UITextViewDelegate>

@end

@implementation HomePageMessageView

{
    UITextField *_textFiled;
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
    
    _textFiled = [[UITextField alloc]init];
    _textFiled.placeholder = @"  电话号码";
    _textFiled.layer.cornerRadius = 5;
    _textFiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _textFiled.font = [UIFont systemFontOfSize:13];
    [self addSubview:_textFiled];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:150.0/255 green:150.0/255 blue:150.0/255 alpha:1];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_textFiled.placeholder attributes:dict];
    [_textFiled setAttributedPlaceholder:attribute];

    //二维码内容填写区域
    _codeTextView = [[UITextView alloc]init];
    _codeTextView.delegate = self;
    _codeTextView.layer.cornerRadius = 5;
    _codeTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    
    [self addSubview:_codeTextView];
    
    _fillLabel = [[UILabel alloc]init];
    _fillLabel.text = @"短信内容";
    _fillLabel.font = [UIFont systemFontOfSize:13];
    _fillLabel.textColor = WORDSCOLOR;
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.text = @"💻生成短信二维码，扫描二维码后将自动输入短信内容";
    _textlabel.textColor = WORDSCOLOR;
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    [self addSubview:_textlabel];

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
     CGFloat width = CGRectGetWidth(self.bounds);
    
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(2);
        make.left.mas_equalTo((width - 240)/4);
        make.right.mas_equalTo(0-(width -240)/4);
        make.height.mas_equalTo(30);
        
    }];

    [_codeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textFiled.mas_bottom).offset(5);
        make.left.mas_equalTo((width - 240)/4);
        make.right.mas_equalTo(0-(width -240)/4);
        make.height.mas_equalTo(90);
    }];
    
    
    [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextView.mas_bottom).offset(1);
        make.left.mas_equalTo((width - 240)/4);
        make.right.mas_equalTo(-(width -240)/4);
        make.height.mas_equalTo(30);
//        make.bottom.mas_equalTo(0);

    }];
    
    
    [_fillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.mas_equalTo(6);
        make.right.mas_equalTo(0);
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
    if (_codeTextView.text.length==0||_textFiled.text.length == 0) {
        return NO;
    }else{
        return YES;
    }
}

-(NSString *)textString
{
    NSDictionary *dic = @{@"sms":_textFiled.text,
                          @"body":_codeTextView.text};
    NSString *textString = [dic yy_modelToJSONString];
    
    return  textString;
    
//    if (IOS9_1) {
//        
//       return  [NSString stringWithFormat:@"sms:%@&body=%@",_textFiled.text,_codeTextView.text];
//        
//    }else{
//        
//        return  [NSString stringWithFormat:@"sms:%@?body=%@",_textFiled.text,_codeTextView.text];
//    }
}
@end
