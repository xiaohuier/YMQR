//
//  QRCodeProduceViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRCodeProduceViewController.h"

#import "UIImage+QRCode.h"
#import "ShareView.h"
#import "QRCodeImageStyleViewController.h"

#import "ShareView.h"

@interface QRCodeProduceViewController ()
@property (nonatomic,strong) UIImageView *qrCodeImageView;
@property (nonatomic,strong) UIImage *qrCodeImage;
@end

@implementation QRCodeProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    
    self.title = @"二维码生成";
    
    [self initSubview];
    
    [self creatQRCodeImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.qrCodeImageView.image = [YMQRCodeAppService shareInstance].QRCodeImage;
    
    self.smallImageView.image = [YMQRCodeAppService shareInstance].cutImage;
    
}

-(void)creatQRCodeImage
{
    self.qrCodeImage = [UIImage creatQRCodeImageWithString:self.textString WidthAndHeight:300];
    
    [YMQRCodeAppService shareInstance].originalQRCodeImage =  self.qrCodeImage;
    
    [YMQRCodeAppService shareInstance].QRCodeImage = self.qrCodeImage;
    
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
    
    self.qrCodeImageView = [[UIImageView alloc]init];
    [self.view addSubview:self.qrCodeImageView];
    
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(245, 245));
        
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(self.view.mas_top).offset(54);
        
    }];
    
    _smallImageView = [[UIImageView alloc]init];
    
    _smallImageView.layer.masksToBounds = YES;
    
    _smallImageView.layer.cornerRadius = 10;
    
    [self.qrCodeImageView addSubview:_smallImageView];
    
    [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        make.center.equalTo(self.qrCodeImageView);
    }];
    
    
    
    UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [styleButton setTitle:@"选择二维码样式" forState:UIControlStateNormal];
    
    styleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    styleButton.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];
    
    [self.view addSubview:styleButton];
    
    [styleButton addTarget:self action:@selector(styleOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(230, 45));
        
        make.centerX.mas_equalTo(self.qrCodeImageView.mas_centerX);
        
        make.top.mas_equalTo(self.qrCodeImageView.mas_bottom).offset(18);
        
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [saveButton setTitle:@"保存图中二维码" forState:UIControlStateNormal];
    
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    saveButton.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1];
    
    [self.view addSubview:saveButton];
    
    [saveButton addTarget:self action:@selector(saveImageOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.qrCodeImageView.mas_centerX);
        
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
        
        make.centerX.equalTo(self.qrCodeImageView.mas_centerX);
        
        make.top.equalTo(saveButton.mas_bottom).offset(15);
        
    }];
    
}

//二维码样式选择
-(void)styleOnClick:(id)sender
{
    if (self.qrCodeImage) {
        QRCodeImageStyleViewController *styleView = [[QRCodeImageStyleViewController alloc]init];
        
        [self.navigationController pushViewController:styleView animated:NO];
    }
    
}

-(void)saveImageOnClick:(id)sender
{
    if (self.qrCodeImage) {
        
        UIImage *saveImage = [UIImage imageForView:self.qrCodeImageView];
        
        [UIImage saveImageToAlbum:saveImage completionHandler:^(BOOL success, NSError *error) {
            
            UIAlertController *alertController;
            
            if (success) {
                
                alertController = [UIAlertController alertControllerWithTitle:nil message:@"图片保存成功" preferredStyle:UIAlertControllerStyleAlert];
                
            }else{

                NSString *err = [NSString stringWithFormat:@"%@",error];
                
                if([err rangeOfString:@"Code=2047"].location !=NSNotFound){
                    
                    alertController = [UIAlertController alertControllerWithTitle:@"图片保存失败" message:@"请选择允许访问相册权限后再次点击保存" preferredStyle:UIAlertControllerStyleAlert];
                    
                }else{
                    
                    alertController = [UIAlertController alertControllerWithTitle:nil message:@"图片保存失败" preferredStyle:UIAlertControllerStyleAlert];
                    
                }


            }
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
    
}

-(void)shareImageOnClick:(id)sender
{
    
//    ShareView * shareView =[[[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self options:nil]lastObject];
//    
//    shareView.shareImage = [UIImage imageNamed:@"Close_fx"];
//    
//    shareView.titleString = @"二维码的邀请";
//    
//    shareView.urlString = @"16156";
//    
//    shareView.contentString = @"我正在用二维码生成与扫描！";
//    
//    shareView.weiboString = [NSString stringWithFormat:@"我正在用二维码生成与扫描"];
//    
//    [shareView shareViewController:self];
    
    NSArray *activityItems =@[self.qrCodeImage];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:vc animated:TRUE completion:nil];

}

@end
