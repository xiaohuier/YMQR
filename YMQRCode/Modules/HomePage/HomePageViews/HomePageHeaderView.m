//
//  HomePageHeaderView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "HomePageBodyView.h"


@implementation HomePageHeaderView

{
    UIButton *_httpButton;
    UIButton *_textButton;
    UIButton *_vCardButton;
    UIButton *_telButton;
    UIButton *_messageButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.homePageBodyType = HomePageBodyHTTPType;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    //    二维码生成内容按钮
    //    网址
    _httpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_httpButton addTarget:self action:@selector(buttonOnCilck:) forControlEvents:UIControlEventTouchUpInside];
    _httpButton.tag = 1000;
    [_httpButton setImage:[UIImage imageNamed:@"httpImg"] forState:UIControlStateNormal];
    [_httpButton setTitle:@"网址" forState:UIControlStateNormal];
    [_httpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _httpButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_httpButton];

    
    //    文本
    _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_textButton addTarget:self action:@selector(buttonOnCilck:) forControlEvents:UIControlEventTouchUpInside];
    _textButton.tag = 1001;
    [_textButton setImage:[UIImage imageNamed:@"textImg"] forState:UIControlStateNormal];
    [_textButton setTitle:@"文本" forState:UIControlStateNormal];
    [_textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _textButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_textButton];
    
    //    名片
    _vCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vCardButton addTarget:self action:@selector(buttonOnCilck:) forControlEvents:UIControlEventTouchUpInside];
    _vCardButton.tag = 1002;
    [_vCardButton setImage:[UIImage imageNamed:@"card"] forState:UIControlStateNormal];
    [_vCardButton setTitle:@"名片" forState:UIControlStateNormal];
    [_vCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _vCardButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_vCardButton];
    
    //    电话
    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telButton addTarget:self action:@selector(buttonOnCilck:) forControlEvents:UIControlEventTouchUpInside];
    _telButton.tag = 1003;
    [_telButton setImage:[UIImage imageNamed:@"iphoneImg"] forState:UIControlStateNormal];
    [_telButton setTitle:@"电话" forState:UIControlStateNormal];
    [_telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _telButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_telButton];
    
    //    信息
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton addTarget:self action:@selector(buttonOnCilck:) forControlEvents:UIControlEventTouchUpInside];
    _messageButton.tag = 1004;
    [_messageButton setImage:[UIImage imageNamed:@"messageImg"] forState:UIControlStateNormal];
    [_messageButton setTitle:@"信息" forState:UIControlStateNormal];
    [_messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_messageButton];
    

    
}

-(void)buttonOnCilck:(UIButton *)button
{
    switch (button.tag) {
        case 1000:
            self.homePageBodyType = HomePageBodyHTTPType;
            break;
        case 1001:
            self.homePageBodyType = HomePageBodyTextType;
            break;
        case 1002:
            self.homePageBodyType = HomePageBodyVCardType;
            break;
        case 1003:
            self.homePageBodyType = HomePageBodyTelPhoneType;
            break;
        case 1004:
            self.homePageBodyType = HomePageBodyMessageType;
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(homePageHeaderButtonChangeType:)]) {
        [self.delegate homePageHeaderButtonChangeType:self.homePageBodyType];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    UIButton *lastButton;
    
    CGSize size = CGSizeMake(60, 85);
    NSInteger left = 42.5 * self.frame.size.width / 375.0 ;
    NSInteger top =  18;
    NSInteger wInterval = 55 * self.frame.size.width / 375.0 ;
    NSInteger hInterval = 14;
    
    [_httpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(top);
        make.size.mas_equalTo(size);
    }];
    lastButton = _httpButton;
    
    [_textButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lastButton.mas_right).offset(wInterval);
        make.top.mas_equalTo(top);
        make.size.mas_equalTo(size);
    }];
    lastButton = _textButton;
    
    [_vCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lastButton.mas_right).offset(wInterval);
        make.top.mas_offset(top);
        make.size.mas_equalTo(size);
    }];
    lastButton = _vCardButton;
    
    [_telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_httpButton);
        make.top.mas_equalTo(_httpButton.mas_bottom).offset(hInterval);
        make.size.mas_equalTo(size);
    }];
    lastButton = _telButton;
    
    
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lastButton.mas_right).offset(wInterval);
        make.top.mas_equalTo(lastButton.mas_top);
        make.size.mas_equalTo(size);
    }];
    
    CGSize titleSize = _httpButton.titleLabel.bounds.size;
    CGSize imageSize = _httpButton.imageView.bounds.size;

    
    [_httpButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height , 0)];
    [_httpButton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + 20.0, -(imageSize.width), 0, 0)];
    
    [_textButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height , 0)];
    [_textButton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + 20.0, -(imageSize.width), 0, 0)];
    
    [_vCardButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height , 0)];
    [_vCardButton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + 20.0, -(imageSize.width), 0, 0)];
    
    [_telButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height , 0)];
    [_telButton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + 20.0, -(imageSize.width), 0, 0)];
    
    [_messageButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height , 0)];
    [_messageButton setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + 24.0, -(imageSize.width), 0, 0)];
 
}
@end
