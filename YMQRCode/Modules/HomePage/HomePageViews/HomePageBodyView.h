//
//  HomePageBodyView.h
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageBodyView : UIView 

@property (nonatomic ,assign)int bodyWidth;
@property (nonatomic ,assign)int bodyHeight;

@property (nonatomic, strong)NSString *viewType;

@property (nonatomic, strong)UITextView *codeTextView;

@property (nonatomic, strong)UITextField *textFile;

//名片信息
@property (nonatomic, strong)UITextField *nameTextfiled;

@property (nonatomic, strong)UITextField *mailTextfiled;

@property (nonatomic, strong)UITextField *telTextfiled;

@property (nonatomic, strong)UITextField *positionTextfiled;

@property (nonatomic, strong)UITextField *companyTextfiled;

@property (nonatomic, strong)UITextField *urlTextfiled;

@property (nonatomic, strong)UITextView *addressTextView;

@property (nonatomic, strong)UITextView *remarksTextView;

- (instancetype)initWithType:(HomePageBodyType)type;

@end
