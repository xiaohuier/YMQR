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

-(UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:11/255.0 green:95/255.0 blue:255/255.0 alpha:1];
    
    [self initSubView];
    
    self.view.backgroundColor = [UIColor grayColor];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
}

-(void)initSubView
{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:self.cutImage];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    if (self.cutImage.size.width > self.cutImage.size.height) {
        NSInteger height = (self.view.frame.size.width -20) * self.cutImage.size.height /self.cutImage.size.width;
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.view);
            make.height.mas_equalTo(height);
        }];
    }else{
        NSInteger width = self.view.frame.size.height * self.cutImage.size.width /self.cutImage.size.height;
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(width);
        }];
    }
    
    _cutImageView = [[CutImageView alloc]init];
    _cutImageView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:_cutImageView];
    [_cutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    UIButton *originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    originalButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [originalButton setTitle:@"使用整张图片" forState:UIControlStateNormal];
    [originalButton addTarget:self action:@selector(originalImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:originalButton];
    [originalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
        make.right.equalTo(self.view.mas_right).offset(-30);
        
        make.top.equalTo(self.view.mas_bottom).offset(-50);
        
    }];
    
    
    UIButton *cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cutButton setTitle:@"使用裁剪图片" forState:UIControlStateNormal];
    
    [cutButton addTarget:self action:@selector(cutImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cutButton];
    [cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
        make.left.equalTo(self.view.mas_left).offset(30);
        
        make.top.equalTo(self.view.mas_bottom).offset(-50);
        
    }];
    
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
