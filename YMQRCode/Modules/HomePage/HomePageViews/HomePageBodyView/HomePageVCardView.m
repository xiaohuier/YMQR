//
//  HomePageVCardView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/13.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageVCardView.h"
@interface HomePageVCardView ()<UITextViewDelegate>

@end

@implementation HomePageVCardView

{
    UIScrollView *_vCardScrollView;
    UITextField *_nameTextfiled;
    UITextField *_mailTextfiled;
    UITextField *_telTextfiled;
    UITextField *_positionTextfiled;
    UITextField *_companyTextfiled;
    UITextField *_urlTextfiled;
    UITextView *_addressTextView;
    UITextView *_remarksTextView;
    UILabel *_addressLabel;
    UILabel *_remarksLabel;
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
    _vCardScrollView = [[UIScrollView alloc]init];
    
    _vCardScrollView.alwaysBounceVertical = YES;
    _vCardScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:_vCardScrollView];
    
    //UITextField
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:150.0/255 green:150.0/255 blue:150.0/255 alpha:1];
    
    _nameTextfiled = [[UITextField alloc]init];
    _nameTextfiled.layer.cornerRadius = 5;
    _nameTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _nameTextfiled.placeholder = @"  姓名";
    _nameTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_nameTextfiled.placeholder attributes:dict];
    [_nameTextfiled setAttributedPlaceholder:attribute];
    [_vCardScrollView addSubview:_nameTextfiled];
    
    _mailTextfiled = [[UITextField alloc]init];
    _mailTextfiled.layer.cornerRadius = 5;
    _mailTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _mailTextfiled.placeholder = @"  电子邮件地址";
    _mailTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute2 = [[NSAttributedString alloc] initWithString:_mailTextfiled.placeholder attributes:dict];
    [_mailTextfiled setAttributedPlaceholder:attribute2];
    [_vCardScrollView addSubview:_mailTextfiled];
    
    _telTextfiled = [[UITextField alloc]init];
    _telTextfiled.layer.cornerRadius = 5;
    _telTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _telTextfiled.placeholder = @"  联系电话";
    _telTextfiled.keyboardType = UIKeyboardTypeNumberPad;
    _telTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute3 = [[NSAttributedString alloc] initWithString:_telTextfiled.placeholder attributes:dict];
    [_telTextfiled setAttributedPlaceholder:attribute3];
    [_vCardScrollView addSubview:_telTextfiled];
    
    _positionTextfiled = [[UITextField alloc]init];
    _positionTextfiled.layer.cornerRadius = 5;
    _positionTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _positionTextfiled.placeholder = @"  公司职位";
    _positionTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute4 = [[NSAttributedString alloc] initWithString:_positionTextfiled.placeholder attributes:dict];
    [_positionTextfiled setAttributedPlaceholder:attribute4];
    [_vCardScrollView addSubview:_positionTextfiled];
    
    
    _companyTextfiled = [[UITextField alloc]init];
    _companyTextfiled.layer.cornerRadius = 5;
    _companyTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _companyTextfiled.placeholder = @"  公司名称";
    _companyTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute5 = [[NSAttributedString alloc] initWithString:_companyTextfiled.placeholder attributes:dict];
    [_companyTextfiled setAttributedPlaceholder:attribute5];
    [_vCardScrollView addSubview:_companyTextfiled];
    
    _urlTextfiled = [[UITextField alloc]init];
    _urlTextfiled.layer.cornerRadius = 5;
    _urlTextfiled.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _urlTextfiled.placeholder = @"  主页地址";
    _urlTextfiled.font = [UIFont systemFontOfSize:13];
    NSAttributedString *attribute6 = [[NSAttributedString alloc] initWithString:_urlTextfiled.placeholder attributes:dict];
    [_urlTextfiled setAttributedPlaceholder:attribute6];
    [_vCardScrollView addSubview:_urlTextfiled];
    
    _addressTextView = [[UITextView alloc]init];
    _addressTextView.font = [UIFont systemFontOfSize:13];
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _addressTextView.delegate = self;
    _addressTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:_addressTextView];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.text = @"联系地址";
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.textColor = WORDSCOLOR;
    [_addressTextView addSubview:_addressLabel];
    
    
    _remarksTextView = [[UITextView alloc]init];
    _remarksTextView.font = [UIFont systemFontOfSize:13];
    _remarksTextView.layer.cornerRadius = 5;
    _remarksTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    _remarksTextView.delegate = self;
    _remarksTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:_remarksTextView];
    
    _remarksLabel = [[UILabel alloc]init];
    _remarksLabel.text = @"备注";
    _remarksLabel.font = [UIFont systemFontOfSize:13];
    _remarksLabel.textColor = WORDSCOLOR;
    [_remarksTextView addSubview:_remarksLabel];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width =CGRectGetWidth(self.bounds);
    CGFloat left = (width - 240)/4;
    CGFloat right = - (width - 240)/4;
    
    
    UIView *lastView = _nameTextfiled;
    
    [_nameTextfiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_vCardScrollView.mas_top).offset(2);
        make.left.mas_equalTo(_vCardScrollView.mas_left).offset(left);
        make.right.mas_equalTo(self.mas_right).offset(right);
        make.height.mas_equalTo(30);
    }];
    
    [_mailTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(30);
    }];
    lastView = _mailTextfiled;
    
    [_telTextfiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(30);
    }];
    lastView = _telTextfiled;
    
    [_positionTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(30);
    }];
    lastView = _positionTextfiled;
    
    [_companyTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(30);
    }];
    lastView = _companyTextfiled;
    
    [_urlTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(30);
    }];
    lastView = _urlTextfiled;
    
    
    [_addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(90);
    }];
    lastView = _addressTextView;
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.top.mas_equalTo(6);
        make.right.mas_greaterThanOrEqualTo(-2);
    }];
    
    
    [_remarksTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(2);
        make.left.mas_equalTo(lastView.mas_left);
        make.right.mas_equalTo(lastView.mas_right);
        make.height.mas_equalTo(90);
    }];
    lastView = _remarksTextView;
    
    [_remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.top.mas_equalTo(6);
        make.right.mas_greaterThanOrEqualTo(-2);
    }];
    
    [_vCardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (IS_IPHONE_5||IS_IPHONE_4_OR_LESS) {
            
            make.left.mas_equalTo(0);
            
            make.right.mas_equalTo(0);
            
            make.top.mas_equalTo(0);
            
            make.height.mas_equalTo(160);
            
        }else{
            make.edges.mas_equalTo(0);
            
            make.bottom.mas_equalTo(lastView.mas_bottom).offset(0);
        }
    }];
    
    if (IS_IPHONE_5||IS_IPHONE_4_OR_LESS) {
    
        _vCardScrollView.contentSize = CGSizeMake(0, 390);
    
    }
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if(textView == _addressTextView&&textView.text.length == 0){
        
        [_addressLabel setHidden:NO];
            
    }else{
        
        if (textView.text.length == 0) {
            
            [_remarksLabel setHidden:NO];
            
        }
        
    }

}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView == _addressTextView){
       
        if (text.length != 0) {
            
            [_addressLabel setHidden:YES];
            
        }
        
    }else if (textView == _remarksTextView){
        
        if (text.length != 0) {
            
            [_remarksLabel setHidden:YES];
            
        }
        
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
//    NSDictionary *dic = @{@"VCARD":_nameTextfiled.text,
//                          @"FN":_companyTextfiled.text,
//                          @"ORG":_addressLabel.text,
//                          @"ADR":_positionTextfiled.text,
//                          @"TITLE":_positionTextfiled.text,
//                          @"TEL":_telTextfiled.text,
//                          @"URL":_urlTextfiled.text,
//                          @"EMAIL":_mailTextfiled.text,
//                          @"NOTE":_remarksTextView.text,
//                          };
//    NSString *textString = [dic yy_modelToJSONString];
    
    NSString *textString;
    
    if ([self isNullString:_nameTextfiled.text]&&[self isNullString:_companyTextfiled.text]&&[self isNullString:_addressTextView.text]&&[self isNullString:_positionTextfiled.text]&&[self isNullString:_telTextfiled.text]&&[self isNullString:_urlTextfiled.text]&&[self isNullString:_mailTextfiled.text]&&[self isNullString:_remarksTextView.text]){
        
        textString = @"";
        
    }else{
        
        textString = [NSString stringWithFormat:@"BEGIN:VCARD\nFN:%@\nORG:%@\nADR:%@\nTITLE:%@\nTEL:%@\nURL:%@\nEMAIL:%@\nNOTE:%@\nEND:VCARD",_nameTextfiled.text,_companyTextfiled.text,_addressTextView.text,_positionTextfiled.text,_telTextfiled.text,_urlTextfiled.text,_mailTextfiled.text,_remarksTextView.text];
        
    }

    return  textString;
    
}


@end
