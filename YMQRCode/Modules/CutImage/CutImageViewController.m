//
//  CutImageViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "CutImageViewController.h"
#import "CutImageView.h"

#import "UIImage+QRCode.h"

@interface CutImageViewController ()
@property (nonatomic,strong)UIImage *cutImage;
@property (nonatomic,strong)CutImageView *cutImageView;
@end

@implementation CutImageViewController

-(instancetype)initWithCutImage:(UIImage *)cutImage
{
    if (self = [super init]) {
        self.cutImage = cutImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
    
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)initSubView
{
    _cutImageView = [[CutImageView alloc]init];
    _cutImageView.image = self.cutImage;
    
    [self.view addSubview:_cutImageView];
    if (self.cutImage.size.width >self.cutImage.size.height) {
        NSInteger height = self.view.frame.size.width * self.cutImage.size.height /self.cutImage.size.width;
        [_cutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.view);
            make.height.mas_equalTo(height);
        }];
    }else{
        NSInteger width = self.view.frame.size.height * self.cutImage.size.width /self.cutImage.size.height;
        [_cutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(width);
        }];
    }
    
    UIButton *originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    originalButton.frame = CGRectMake(30, self.view.bounds.size.height -50 -64, 100, 30);
    originalButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [originalButton setTitle:@"保存整张图片" forState:UIControlStateNormal];
    
    [originalButton addTarget:self action:@selector(originalImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:originalButton];
    
    UIButton *cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cutButton.frame = CGRectMake(self.view.bounds.size.width - 130, self.view.bounds.size.height - 50 -64, 100, 30);
    cutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cutButton setTitle:@"保存裁剪图片" forState:UIControlStateNormal];
    
    [cutButton addTarget:self action:@selector(cutImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cutButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)originalImage:(id)sender
{


    UIImage *newImage = [self.cutImage getCroppedImage:CGRectMake(0, 0, self.cutImage.size.width, self.cutImage.size.height)];
    
    [self saveImageToAppSever:newImage];
    
    [self pop];
}

-(void)cutImage:(id)sender
{
    
    CGFloat scale =  self.cutImage.size.width/self.cutImageView.bounds.size.width;
    CGRect imageRect = CGRectMake(_cutImageView.clearRect.origin.x *scale, _cutImageView.clearRect.origin.y *scale, _cutImageView.clearRect.size.width *scale, _cutImageView.clearRect.size.height *scale);
    UIImage *newImage = [self.cutImage getCroppedImage:imageRect];
    
    [self saveImageToAppSever:newImage];

    [self pop];
}

-(void)saveImageToAppSever: (UIImage *)cutImage
{
    [YMQRCodeAppService shareInstance].cutImage = cutImage;
}


-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
