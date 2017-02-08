//
//  HomePageBodyView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageBodyView.h"
#import "HomePageHeaderView.h"



@interface HomePageBodyView ()<UITextViewDelegate>

//二维码填写区域
@property (nonatomic, strong)UILabel *textlabel;

@property (nonatomic, strong)UILabel *fillLabel;

@property (nonatomic, strong)UIView *textFileView;

@property (nonatomic, strong)UIScrollView *vCardScrollView;



@property (nonatomic, strong)UILabel *fillAddress;

@property (nonatomic, strong)UILabel *fillRemarks;

@property (assign ,nonatomic)BOOL isSelectHttp;

@property (assign ,nonatomic)BOOL isSelectText;

@property (assign ,nonatomic)BOOL isSelectVcard;

@property (assign ,nonatomic)BOOL isSelectTel;

@property (assign ,nonatomic)BOOL isSelectMessage;

@end

@implementation HomePageBodyView

{
    HomePageBodyType _type;
   
}


- (instancetype)initWithType:(HomePageBodyType)type;
{
    self = [super init];
    if (self) {
        _type = type;
        [self initSubView];
        
    }
    return self;
}

-(void)initSubView
{
    switch (_type) {
        case HomePageBodyHTTPType:
            if(!_isSelectHttp){
                
                [self codeFillContext];
                
                _textlabel.text = @"注意：填写网址的时候请输入http://或者https://完整的网址信息;如果你的网址过长，生成的二维码将不易被扫描";
                
                _textlabel.textColor = WORDSCOLOR;
                
                _fillLabel.text = @"http://或者https://";
                
                _viewType = @"http";
                
            }
            
            _isSelectHttp = YES;
            _isSelectText = NO;
            _isSelectTel = NO;
            _isSelectVcard = NO;
            _isSelectMessage = NO;
            
            break;
            
        case HomePageBodyTextType:
            if(!_isSelectText){
                
                [self codeFillContext];
                
                _viewType = @"文本";
                
                _fillLabel.text = @"支持输入基本的文本数据和网站";
                
                _textlabel.text = [NSString stringWithFormat:@"已输入字符：0个"];
                _textlabel.textColor = WORDSCOLOR;
            }
            
            _isSelectHttp = NO;
            _isSelectText = YES;
            _isSelectTel = NO;
            _isSelectVcard = NO;
            _isSelectMessage = NO;
            break;
            
        case HomePageBodyVCardType:
            if(!_isSelectVcard){
                
                [self vCardInterfaceSetup];
                
                _viewType = @"vCard";
                
            }
            
            
            _isSelectHttp = NO;
            _isSelectText = NO;
            _isSelectTel = NO;
            _isSelectVcard = YES;
            _isSelectMessage = NO;

            break;
        case HomePageBodyMessageType:
            
            if(!_isSelectMessage){
                
                [self messageFillContext];
                
                _fillLabel.text = @"短信内容";
                
                _textlabel.text = @"💻生成短信二维码，扫描二维码后将自动输入短信内容";
                
                _textlabel.textColor = WORDSCOLOR;
            }
            
            _isSelectHttp = NO;
            _isSelectText = NO;
            _isSelectTel = NO;
            _isSelectVcard = NO;
            _isSelectMessage = YES;
            
            break;
        case HomePageBodyTelPhoneType:
            
            if(!_isSelectTel){
                
                [self codeFillContext];
                
                _textlabel.text = @"☎️生成的电话号码二维码，扫描之后，手机可直接拨打扫描的电话号";
                _textlabel.textColor = WORDSCOLOR;
                _fillLabel.text = @"请输入家庭号码或手机号";
                
                _viewType = @"tel";
                
            }
            
            _codeTextView.keyboardType = UIKeyboardTypeNumberPad;
            
            _isSelectHttp = NO;
            _isSelectText = NO;
            _isSelectTel = YES;
            _isSelectVcard = NO;
            _isSelectMessage = NO;

            break;
        default:
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


-(void)codeFillContext{
    
    [_codeTextView removeFromSuperview];
    
    [_textlabel removeFromSuperview];
    
    [_textFileView removeFromSuperview];
    
    [_vCardScrollView removeFromSuperview];
    
    //二维码内容填写区域
    _codeTextView = [[UITextView alloc]init];
    
    _codeTextView.layer.cornerRadius = 10;
    _codeTextView.delegate = self;
    _codeTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    
    [self addSubview:_codeTextView];
    
    _fillLabel = [[UILabel alloc]init];
    _fillLabel.font = [UIFont systemFontOfSize:13];
    _fillLabel.textColor = WORDSCOLOR;
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    [self addSubview:_textlabel];
    
    NSLog(@" ------SCREENWIDTH    %f ",SCREENWIDTH);
    
    [_codeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset((SCREENWIDTH - 240)/4);
        
        make.top.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 120));
    }];
    
    [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_offset(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 30));
        
        make.top.equalTo(_codeTextView.mas_bottom).offset(1);
        
        make.centerX.equalTo(_codeTextView.mas_centerX);
    }];
    
    
    [_fillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        
        make.left.equalTo(_codeTextView.mas_left).offset(6);
        
        make.top.equalTo(_codeTextView.mas_top).offset(2);
    }];
    
}

-(void)messageFillContext{
    
    [_codeTextView removeFromSuperview];
    
    [_textlabel removeFromSuperview];
    
    [_textFileView removeFromSuperview];
    
    [_vCardScrollView removeFromSuperview];
    
    _viewType = @"message";
    
    _textFileView = [[UIView alloc]init];
    _textFileView.layer.cornerRadius = 5;
    _textFileView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [self addSubview:_textFileView];
    
    [_textFileView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        
        make.left.equalTo(self.mas_left).offset((SCREENWIDTH - 240)/4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 35));
        
    }];
    
    _textFile = [[UITextField alloc]init];
    _textFile.placeholder = @"电话号码";
    _textFile.font = [UIFont systemFontOfSize:13];
    [self.textFileView addSubview:_textFile];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:150.0/255 green:150.0/255 blue:150.0/255 alpha:1];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_textFile.placeholder attributes:dict];
    [_textFile setAttributedPlaceholder:attribute];
    
    
    [_textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_textFileView.mas_top).offset(2);
        
        make.left.equalTo(_textFileView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    //二维码内容填写区域
    _codeTextView = [[UITextView alloc]init];
    _codeTextView.delegate = self;
    _codeTextView.layer.cornerRadius = 5;
    _codeTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    
    [self addSubview:_codeTextView];
    
    _fillLabel = [[UILabel alloc]init];
    _fillLabel.font = [UIFont systemFontOfSize:13];
    _fillLabel.textColor = WORDSCOLOR;
    [_codeTextView addSubview:_fillLabel];
    
    _textlabel = [[UILabel alloc]init];
    _textlabel.font = [UIFont systemFontOfSize:10];
    _textlabel.numberOfLines = 0;
    [self addSubview:_textlabel];
    
    [_codeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset((SCREENWIDTH - 240)/4);
        
        make.top.equalTo(_textFileView.mas_bottom).offset(5);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 90));
    }];
    
    [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_offset(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 30));
        
        make.top.equalTo(_codeTextView.mas_bottom).offset(1);
        
        make.centerX.equalTo(_codeTextView.mas_centerX);
    }];
    
    
    [_fillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        
        make.left.equalTo(_codeTextView.mas_left).offset(6);
        
        make.top.equalTo(_codeTextView.mas_top).offset(2);
    }];
    
    
    
}

-(void)vCardInterfaceSetup{
    
    [_codeTextView removeFromSuperview];
    
    [_textlabel removeFromSuperview];
    
    [_textFileView removeFromSuperview];
    
    _vCardScrollView = [[UIScrollView alloc]init];
    
    _vCardScrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_vCardScrollView];
    
    [_vCardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        
        make.left.offset((SCREENWIDTH - 240)/4);
        
        make.width.mas_offset(SCREENWIDTH-(SCREENWIDTH - 240)/2);
        
        make.bottom.mas_equalTo(0);
        
    }];
    
    _vCardScrollView.contentSize = CGSizeMake(0, 450);
    
    //UIView
    UIView *nameView = [[UIView alloc]init];
    nameView.layer.cornerRadius = 5;
    nameView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:nameView];
    
    
    UIView *mailView = [[UIView alloc]init];
    mailView.layer.cornerRadius = 5;
    mailView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:mailView];
    
    UIView *telView = [[UIView alloc]init];
    telView.layer.cornerRadius = 5;
    telView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:telView];
    
    UIView *positionView = [[UIView alloc]init];
    positionView.layer.cornerRadius = 5;
    positionView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:positionView];
    
    UIView *companyView = [[UIView alloc]init];
    companyView.layer.cornerRadius = 5;
    companyView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:companyView];
    
    UIView *urlView = [[UIView alloc]init];
    urlView.layer.cornerRadius = 5;
    urlView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:urlView];
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_vCardScrollView.mas_left).offset(0);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 31));
        
        make.top.equalTo(_vCardScrollView.mas_top).offset(0);
    }];
    
    [mailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView);
        
        make.top.equalTo(nameView.mas_top).offset(40);
    }];
    
    [telView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView);
        
        make.top.equalTo(mailView.mas_top).offset(40);
    }];
    
    [positionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView);
        
        make.top.equalTo(telView.mas_top).offset(40);
    }];
    
    [companyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView);
        
        make.top.equalTo(positionView.mas_top).offset(40);
    }];
    
    [urlView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView);
        
        make.size.equalTo(@[nameView,mailView,telView,positionView,companyView]);
        
        make.top.equalTo(companyView.mas_top).offset(40);
    }];
    
    
    //UITextField
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:150.0/255 green:150.0/255 blue:150.0/255 alpha:1];
    //    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_urlTextfiled.placeholder attributes:dict];
    //    [_urlTextfiled setAttributedPlaceholder:attribute];
    
    _nameTextfiled = [[UITextField alloc]init];
    _nameTextfiled.placeholder = @"姓名";
    _nameTextfiled.font = [UIFont systemFontOfSize:13];
    [nameView addSubview:_nameTextfiled];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_nameTextfiled.placeholder attributes:dict];
    [_nameTextfiled setAttributedPlaceholder:attribute];
    
    _mailTextfiled = [[UITextField alloc]init];
    _mailTextfiled.placeholder = @"电子邮件地址";
    _mailTextfiled.font = [UIFont systemFontOfSize:13];
    [mailView addSubview:_mailTextfiled];
    NSAttributedString *attribute2 = [[NSAttributedString alloc] initWithString:_mailTextfiled.placeholder attributes:dict];
    [_mailTextfiled setAttributedPlaceholder:attribute2];
    
    _telTextfiled = [[UITextField alloc]init];
    _telTextfiled.placeholder = @"联系电话";
    _telTextfiled.keyboardType = UIKeyboardTypeNumberPad;
    _telTextfiled.font = [UIFont systemFontOfSize:13];
    [telView addSubview:_telTextfiled];
    NSAttributedString *attribute3 = [[NSAttributedString alloc] initWithString:_telTextfiled.placeholder attributes:dict];
    [_telTextfiled setAttributedPlaceholder:attribute3];
    
    _positionTextfiled = [[UITextField alloc]init];
    _positionTextfiled.placeholder = @"公司职位";
    _positionTextfiled.font = [UIFont systemFontOfSize:13];
    [positionView addSubview:_positionTextfiled];
    NSAttributedString *attribute4 = [[NSAttributedString alloc] initWithString:_positionTextfiled.placeholder attributes:dict];
    [_positionTextfiled setAttributedPlaceholder:attribute4];
    
    _companyTextfiled = [[UITextField alloc]init];
    _companyTextfiled.placeholder = @"公司名称";
    _companyTextfiled.font = [UIFont systemFontOfSize:13];
    [companyView addSubview:_companyTextfiled];
    NSAttributedString *attribute5 = [[NSAttributedString alloc] initWithString:_companyTextfiled.placeholder attributes:dict];
    [_companyTextfiled setAttributedPlaceholder:attribute5];
    
    _urlTextfiled = [[UITextField alloc]init];
    _urlTextfiled.placeholder = @"主页地址";
    _urlTextfiled.font = [UIFont systemFontOfSize:13];
    [urlView addSubview:_urlTextfiled];
    NSAttributedString *attribute6 = [[NSAttributedString alloc] initWithString:_urlTextfiled.placeholder attributes:dict];
    [_urlTextfiled setAttributedPlaceholder:attribute6];
    
    
    _addressTextView = [[UITextView alloc]init];
    _addressTextView.delegate = self;
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:_addressTextView];
    
    _fillAddress = [[UILabel alloc]init];
    _fillAddress.text = @"联系地址";
    _fillAddress.font = [UIFont systemFontOfSize:13];
    _fillAddress.textColor = WORDSCOLOR;
    [_addressTextView addSubview:_fillAddress];
    
    _remarksTextView = [[UITextView alloc]init];
    _remarksTextView.delegate = self;
    _remarksTextView.layer.cornerRadius = 5;
    _remarksTextView.backgroundColor = [UIColor colorWithRed:225.0/255 green:222.0/255 blue:225.0/255 alpha:1];
    [_vCardScrollView addSubview:_remarksTextView];
    
    _fillRemarks = [[UILabel alloc]init];
    _fillRemarks.text = @"备注";
    _fillRemarks.font = [UIFont systemFontOfSize:13];
    _fillRemarks.textColor = WORDSCOLOR;
    [_remarksTextView addSubview:_fillRemarks];
    
    [_nameTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameView.mas_top).offset(2);
        
        make.left.equalTo(nameView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    [_mailTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mailView.mas_top).offset(2);
        
        make.left.equalTo(mailView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    [_telTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(telView.mas_top).offset(2);
        
        make.left.equalTo(telView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    [_positionTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(positionView.mas_top).offset(2);
        
        make.left.equalTo(positionView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    [_companyTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(companyView.mas_top).offset(2);
        
        make.left.equalTo(companyView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    [_urlTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(urlView.mas_top).offset(2);
        
        make.left.equalTo(urlView.mas_left).offset(4);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2 - 4, 31));
        
    }];
    
    
    
    [_addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView.mas_left);
        
        make.top.equalTo(urlView.mas_bottom).offset(10);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 90));
    }];
    
    
    [_fillAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        
        make.left.equalTo(_addressTextView.mas_left).offset(6);
        
        make.top.equalTo(_addressTextView.mas_top).offset(2);
    }];
    
    [_remarksTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameView.mas_left);
        
        make.top.equalTo(_addressTextView.mas_bottom).offset(10);
        
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-(SCREENWIDTH - 240)/2, 90));
    }];
    
    
    [_fillRemarks mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        
        make.left.equalTo(_remarksTextView.mas_left).offset(6);
        
        make.top.equalTo(_remarksTextView.mas_top).offset(2);
    }];
    
}


#pragma UItextViewDelegate的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([_viewType isEqualToString:@"文本"]){
        
        if (text.length !=0&&range.location == 0) {
            
            _textlabel.text = [NSString stringWithFormat:@"已输入字符: 1个"];
            
        }else if(range.location != 0&&text.length !=0){
            
            _textlabel.text = [NSString stringWithFormat:@"已输入字符: %lu个",(unsigned long)range.location+1];
            
        }else if (text.length ==0){
            
            _textlabel.text = [NSString stringWithFormat:@"已输入字符: %lu个",(unsigned long)range.location];
            
        }
        
    }
    
    if (textView == _addressTextView) {
        
        if (range.location == 0) {
            
            [_fillAddress setHidden:NO];
            
        }
        
        if (text.length != 0) {
            
            [_fillAddress setHidden:YES];
            
        }
        
    }else if ( textView == _remarksTextView){
        
        if (range.location == 0) {
            
            [_fillRemarks setHidden:NO];
            
        }
        
        if (text.length != 0) {
            
            [_fillRemarks setHidden:YES];
            
        }
        
    }else{
        
        if (range.location == 0) {
            
            [_fillLabel setHidden:NO];
            
        }
        
        if (text.length != 0) {
            
            [_fillLabel setHidden:YES];
            
        }
    }
    
    return YES;
}






@end
