//
//  QRCodeImageStyleViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRCodeImageStyleViewController.h"

#import "ColorsBtnView.h"
#import "UIImage+QRCode.h"

#import "CutImageViewController.h"



@interface QRCodeImageStyleViewController ()<ColorsBtnViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//二维码的图片
@property (nonatomic ,strong) UIImage *qrCodeImage;

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
                        @(QRImageTypeBuild),
                        @(QRImageTypeDefult)]mutableCopy];
    }
    return _typeArray;
}

-(void)setQrCodeImage:(UIImage *)qrCodeImage
{
    _qrCodeImage = qrCodeImage;
    
    
    [self.qrCodeImgView setImage:_qrCodeImage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    [self initSubView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setQRCodeViewImage];
}


-(void)initNavigation
{
    self.title = @"二维码样式";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 22);
    
    [rightButton addTarget:self action:@selector(saveBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTitleColor:[UIColor colorWithRed:51/255.0 green:135/255.0 blue:236/255.0 alpha:1] forState:UIControlStateNormal];
    
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];;
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

-(void)initSubView
{
    _qrCodeImgView = [[UIImageView alloc]init];
    
    [self.view addSubview:_qrCodeImgView];
    
    [_qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(65);
        
        make.right.mas_equalTo(-65);
        
        make.height.mas_equalTo(_qrCodeImgView.mas_width);
        
        make.top.mas_equalTo(50);
        
    }];
    
    
    self.smallImageView = [[UIImageView alloc]init];
    
    self.smallImageView.layer.masksToBounds = YES;
    
    self.smallImageView.layer.cornerRadius = 10;
    
    [_qrCodeImgView addSubview: self.smallImageView];
    
    [ self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        make.center.equalTo(_qrCodeImgView);
        
    }];
    
    
    ColorsBtnView *colorsBtnView = [[ColorsBtnView alloc]init];
    colorsBtnView.delegate = self;
    
    [self.view addSubview:colorsBtnView];
    [colorsBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_qrCodeImgView.mas_bottom).offset(40);
        make.left.mas_equalTo(43);
        make.right.mas_equalTo(-43);
        make.height.mas_equalTo(135);
    }];
    
    
    UIButton *imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [imgButton setBackgroundImage:[UIImage imageNamed:@"selectImg"] forState:UIControlStateNormal];
    [imgButton addTarget:self action:@selector(addImageOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imgButton];
    
    [imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(31);
        
        make.size.mas_equalTo(CGSizeMake(154, 50));
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-85);
        
        
    }];
    
    UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [styleButton setBackgroundImage:[UIImage imageNamed:@"styleImg"] forState:UIControlStateNormal];
    
    [styleButton addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:styleButton];
    
    [styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-31);
        
        make.size.mas_equalTo(CGSizeMake(154, 50));
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-85);
        
    }];
    
    UILabel *wordsLabel = [[UILabel alloc]init];
    
    wordsLabel.font = [UIFont systemFontOfSize:10];
    
    wordsLabel.text = @"温馨提示：选择完二维码样式后，请点击右上角\"完成\"，以完成保存。";
    
    wordsLabel.textColor = WORDSCOLOR
    
    [self.view addSubview:wordsLabel];
    
    [wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(imgButton.mas_left).offset(0);
        
        make.right.equalTo(styleButton.mas_right).offset(8);
        
        make.top.equalTo(imgButton.mas_bottom).offset(10);
        
        make.size.height.mas_equalTo(20);
        
    }];
    
    
}

-(void)setQRCodeViewImage
{
    self.qrCodeImage = [YMQRCodeAppService shareInstance].QRCodeImage;
    
    UIImage *cutImage = [YMQRCodeAppService shareInstance].cutImage;
    if (cutImage) {
        self.smallImageView.image = cutImage;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveBack:(id)sender
{
    [YMQRCodeAppService shareInstance].QRCodeImage = _qrCodeImage;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ColorsBtnViewDelegate
-(void)colorsButtonOnClick:(UIColor *)clickColor
{
    if (self.smallImageView.isHidden == YES)
    {
        self.smallImageView.hidden = NO;
    }
    
    if(clickColor)
    {
        UIImage *originalQRCodeImage = [YMQRCodeAppService shareInstance].originalQRCodeImage;
        
        self.qrCodeImage = [UIImage imageColorToTransparent:originalQRCodeImage withColor:clickColor];
    }
}

-(void)changeType:(id)sender
{
    
    if (self.smallImageView.isHidden == NO)
    {
        self.smallImageView.hidden = YES;
    }
    
    self.type = [self.typeArray.firstObject intValue];
    [self.typeArray removeObjectAtIndex:0];
    UIImage *backgroundImage = nil;
    CGRect rect;
    UIColor *color;
    
    switch (self.type) {
        case QRImageTypeMario:
            backgroundImage = [UIImage imageNamed:@"Mario"];
            rect = CGRectMake(125, 80, 250, 250);
            color = [UIColor colorWithRed:150/255.0 green:71/255.0 blue:18/255.0 alpha:1.0];
            break;
        case QRImageTypeDish:
            backgroundImage = [UIImage imageNamed:@"Dish"];
            rect = CGRectMake(125, 125, 250, 250);
            color = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
            break;
        case QRImageTypeBread:
            backgroundImage = [UIImage imageNamed:@"Bread"];
            rect = CGRectMake(125, 125, 250, 250);
            color = [UIColor colorWithRed:96/255.0 green:56/255.0 blue:19/255.0 alpha:1.0];
            break;
        case QRImageTypeLeaf:
            backgroundImage = [UIImage imageNamed:@"Leaf"];
            rect = CGRectMake(125, 125, 250, 250);
            color = [UIColor colorWithRed:84/255.0 green:199/255.0 blue:87/255.0 alpha:1.0];
            break;
        case QRImageTypeBuild:
            backgroundImage = [UIImage imageNamed:@"Build"];
            rect = CGRectMake(125, 125, 250, 250);
            color = [UIColor colorWithRed:45/255.0 green:58/255.0 blue:85/255.0 alpha:1.0];
            break;
        default:
            
            if (self.smallImageView.isHidden == YES)
            {
                self.smallImageView.hidden = NO;
            }
            
            self.qrCodeImage = [YMQRCodeAppService shareInstance].originalQRCodeImage;
            return;
            break;
    }
    
    UIImage *originalQRCodeImage = [YMQRCodeAppService shareInstance].originalQRCodeImage;
    
    UIImage *image = [UIImage imageColorToTransparent:originalQRCodeImage withColor:color];
    
    rect = CGRectMake(rect.origin.x + 5, rect.origin.y + 5, rect.size.width -10, rect.size.height -10);
    
    self.qrCodeImage =  [backgroundImage addImage:image withRect:rect];
    
}

-(void)addImageOnClick:(id)sender
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    UIAlertAction *selectCamera = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *selectAlbum = [UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [actionSheet addAction:selectCamera];
    [actionSheet addAction:selectAlbum];
    [actionSheet addAction:cancel];
    
    
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    CutImageViewController *cutImageVC = [[CutImageViewController alloc]initWithCutImage:image];
    
    [self.navigationController pushViewController:cutImageVC animated:NO];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
