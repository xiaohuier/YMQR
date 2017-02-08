//
//  QRCodeProduceViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRCodeProduceViewController.h"

#import "UIImage+QRCode.h"

#import "QRCodeImageStyleViewController.h"


@interface QRCodeProduceViewController ()
@property (nonatomic,strong)UIImage *qrCodeImage;
@end

@implementation QRCodeProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    
    BACK_COLOR_WHITE
    
    BACK_TITLE
    
    self.title = @"二维码生成";
    
     [self initSubview];
}

-(void)initSubview
{
    if (self.textString.length == 0) {
        
        UILabel *labelWords = [[UILabel alloc]init];
        
        labelWords.text = @"未填写二维码内容，无法生成二维码";
        
        labelWords.textAlignment = NSTextAlignmentCenter;
        
        labelWords.textColor = WORDSCOLOR;
        
        [self.view addSubview:labelWords];
        
        [labelWords mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(300, 30));
            
            make.top.equalTo(self.view.mas_top).offset(50);
            
            make.centerX.equalTo(self.view.mas_centerX);
     
        }];
        
        return;
    }
    
    self.qrCodeImage = [UIImage creatQRCodeImageWithString:self.textString WidthAndHeight:300];
    
    UIImageView *qrCodeImageView = [[UIImageView alloc]init];
    qrCodeImageView.image = self.qrCodeImage;
    
    [self.view addSubview:qrCodeImageView];
    
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(245, 245));
        
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(self.view.mas_top).offset(54);
        
    }];
    
    _smallImage = [[UIImageView alloc]init];
    
    _smallImage.layer.masksToBounds = YES;
    
    _smallImage.layer.cornerRadius = 10;
    
    [qrCodeImageView addSubview:_smallImage];

    [_smallImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        make.center.equalTo(qrCodeImageView);
    }];

    UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [styleButton setTitle:@"选择二维码样式" forState:UIControlStateNormal];
    
    styleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    styleButton.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];
    
    [self.view addSubview:styleButton];
    
    [styleButton addTarget:self action:@selector(styleOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(230, 45));
        
        make.centerX.equalTo(qrCodeImageView.mas_centerX);
        
        make.top.equalTo(qrCodeImageView.mas_bottom).offset(18);
        
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [saveButton setTitle:@"保存图中二维码" forState:UIControlStateNormal];
    
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    saveButton.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];
    
    [self.view addSubview:saveButton];
    
    [saveButton addTarget:self action:@selector(saveImageOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(qrCodeImageView.mas_centerX);
        
        make.top.equalTo(styleButton.mas_bottom).offset(15);
        
    }];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareButton setTitle:@"分享图中二维码" forState:UIControlStateNormal];
    
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    shareButton.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];
    
    [self.view addSubview:shareButton];
    
    [shareButton addTarget:self action:@selector(shareImageOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(@[saveButton,shareButton,styleButton]);
        
        make.centerX.equalTo(qrCodeImageView.mas_centerX);
        
        make.top.equalTo(saveButton.mas_bottom).offset(15);
        
    }];
    

    
}
//二维码样式选择
-(void)styleOnClick:(id)sender
{
    QRCodeImageStyleViewController *styleView = [[QRCodeImageStyleViewController alloc]initWithQRCodeImage:self.qrCodeImage];
    
    
//    styleView.delegate = self;
    
    
    
    [self.navigationController pushViewController:styleView animated:NO];
    
}

-(void)saveImageOnClick:(id)sender
{
    if (self.qrCodeImage) {
        [UIImage saveImageToAlbum:self.qrCodeImage completionHandler:^(BOOL success, NSError *error) {
            
            UIAlertController *alertController;
            
            if (success) {
                
                alertController = [UIAlertController alertControllerWithTitle:nil message:@"图片保存成功" preferredStyle:UIAlertControllerStyleAlert];

            }else{
                 alertController = [UIAlertController alertControllerWithTitle:nil message:@"图片保存失败" preferredStyle:UIAlertControllerStyleAlert];
            }
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
    
}

-(void)shareImageOnClick:(id)sender
{
    
    
    ShareView * shareView =[[[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self options:nil]lastObject];
    
    shareView.shareImage = [UIImage imageNamed:@"Close_fx"];
    
    shareView.titleString = @"二维码的邀请";
    
    shareView.contentString = @"我正在用二维码生成与扫描！";
    
    shareView.weiboString = [NSString stringWithFormat:@"我正在用二维码生成与扫描"];
    
    [shareView shareViewController:self];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
