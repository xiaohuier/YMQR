//
//  QRCodeImageStyleViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRCodeImageStyleViewController.h"

@interface QRCodeImageStyleViewController ()
@property (nonatomic,strong)UIImage *qrCodeImage;

@property (strong ,nonatomic) UIImageView *qrCodeImgView;
@property (strong ,nonatomic) UIImageView *smallImageView;
@property (strong ,nonatomic) NSMutableArray *typeArray;
@property (assign ,nonatomic) QRImageType type;
@property (strong ,nonatomic) NSArray *arrayColor;

@end

@implementation QRCodeImageStyleViewController

-(NSMutableArray *)typeArray
{
    if (_typeArray.count == 0) {
        _typeArray = [@[@(QRImageTypeMario),
                        @(QRImageTypeDish),
                        @(QRImageTypeBread),
                        @(QRImageTypeLeaf),
                        @(QRImageTypeBuild),@(QRImageTypeDefult)]mutableCopy];
    }
    return _typeArray;
}

-(instancetype)initWithQRCodeImage:(UIImage *)qrCodeImage
{
    if (self = [super init]) {
        self.qrCodeImage = qrCodeImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self initSubView];
   
}



-(void)initNavigation
{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 22);
    
    [rightButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTitleColor:[UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1] forState:UIControlStateNormal];
    
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];;
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

-(void)initSubView
{
    _qrCodeImgView = [[UIImageView alloc]init];
    
    _qrCodeImgView.image = self.qrCodeImage;
    
    [self.view addSubview:_qrCodeImgView];
    
    [_qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(65);
        
        make.right.equalTo(self.view.mas_right).offset(-65);
        
        make.size.height.equalTo(_qrCodeImgView.mas_width);
        
        make.top.equalTo(self.view.mas_top).offset(50);
        
    }];

    
    self.smallImageView = [[UIImageView alloc]init];
    
    self.smallImageView.layer.masksToBounds = YES;
    
    self.smallImageView.layer.cornerRadius = 10;
    
    [_qrCodeImgView addSubview: self.smallImageView];
    
    [ self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        make.center.equalTo(_qrCodeImgView);
    }];
    
    
    
    [_qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(65);
        
        make.right.equalTo(self.view.mas_right).offset(-65);
        
        make.size.height.equalTo(_qrCodeImgView.mas_width);
        
        make.top.equalTo(self.view.mas_top).offset(50);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
