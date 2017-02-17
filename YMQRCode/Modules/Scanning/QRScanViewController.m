//
//  QRScanViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/14.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRScanViewController.h"
#import "QRScanView.h"

#import <AVFoundation/AVFoundation.h>

@interface QRScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)QRScanView *scanView;
@property(nonatomic,strong)AVCaptureSession *captureSession;
@property (nonatomic,assign)QRScanViewType type;
@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initNavigation];
    [self initSubViews];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.captureSession startRunning];
    [self.scanView startAnimation];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.captureSession stopRunning];
    [self.scanView stopAnimation];
}

-(void)setType:(QRScanViewType)type
{
    _type = type;
    
    if (type == QRScanViewQRCodeType) {
        [self initScannerViewWithRectSize:CGSizeMake(260.f, 260.f) offseyY:(-43.0f)];
        self.scanView.tipString = @"将二维码放入框内，即可自动扫描";
        
        
    }else if (type == QRScanViewBarCodeType){
        [self initScannerViewWithRectSize:CGSizeMake(300.f, 180.f) offseyY:(-23.0f)];
        self.scanView.tipString = @"将条形码放入框内，即可自动扫描";
    }
}



#pragma mark - Navigation
-(void)initNavigation
{
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backBtn  sizeToFit];
    [backBtn addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    NSArray *SegmentedControlArray = @[@"二维码",@"条形码"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:SegmentedControlArray];
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedControl;
    //    右边留个帮助按钮
    
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateDisabled];
    [flashButton sizeToFit];
    
    [flashButton addTarget:self action:@selector(didTapFlashButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:flashButton];

    
}

-(UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}


-(void)initSubViews
{
    [self initCamera];
    
    [self setType:QRScanViewQRCodeType];
    
    [self initButtons];
}

-(void)initCamera
{
    
    self.captureSession = [[AVCaptureSession alloc]init];
    [self.captureSession beginConfiguration];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error == nil) {
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
        }
    }else{
        NSLog(@"input error = %@",error);
    }
    
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc]init];
    [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if([self.captureSession canAddOutput:captureOutput]){
        [self.captureSession addOutput:captureOutput];
        captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    }
    
    //添加预览画面
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    layer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:layer];
    
    [self.captureSession commitConfiguration];
    
}


-(void)initScannerViewWithRectSize: (CGSize)size offseyY:(NSInteger)offsetY
{
    if (self.scanView.superview) {
        [self.scanView removeFromSuperview];
    }
    
    self.scanView = [[QRScanView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:size offsetY:offsetY];
    
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:self.scanView atIndex:1];
    [self.scanView startAnimation];
}

-(void)initButtons
{
    NSInteger kWidth = self.view.bounds.size.width;
    //灯光按钮
    UIButton *flashLightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [flashLightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateNormal];
    [flashLightButton setTitle:@"开灯" forState:UIControlStateNormal];
    flashLightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [flashLightButton setImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateSelected];
    [flashLightButton setTitle:@"关灯" forState:UIControlStateSelected];
    
    flashLightButton.frame = CGRectMake(0, 0, 42 *375/kWidth, 66 *375/kWidth);
    flashLightButton.center = CGPointMake(kWidth/3, self.scanView.bottom +60*375/kWidth);
    [flashLightButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
    
    [flashLightButton setTitleEdgeInsets:UIEdgeInsetsMake(42 + 24, - 40, 0, 0)];
    
    [flashLightButton addTarget:self action:@selector(flashLightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashLightButton];
    
    //图片获取
    UIButton *pictureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [pictureButton setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
    pictureButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [pictureButton setTitle:@"相册" forState:UIControlStateNormal];
    pictureButton.frame = CGRectMake(0, 0, 42 *375/kWidth, 66 *375/kWidth);
    pictureButton.center = CGPointMake(kWidth*2/3, self.scanView.bottom +60*375/kWidth);
    [pictureButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
    
    [pictureButton setTitleEdgeInsets:UIEdgeInsetsMake(42 + 24, - 40, 0, 0)];
    [pictureButton addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pictureButton];
    
}

-(void)changeType:(UISegmentedControl *)segmentedControl
{
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.type = QRScanViewQRCodeType;
        
    }else{
        self.type = QRScanViewBarCodeType;
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didTapBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didTapFlashButton:(UIButton *)button
{
    button.selected = !button.selected;
}

-(void)flashLightClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode==AVCaptureTorchModeOff) {
        //闪光灯开启
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
    }else {
        //闪光灯关闭
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    
}

-(void)pictureClick:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //将来源设置为相册
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            NSLog(@"scannedResult = %@",scannedResult);
        }else{
            
        }
    }];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *qrCode = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        qrCode  = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        break;
    }
    
    if (self.type == QRScanViewBarCodeType) {
        NSLog(@"条形码ISBN = %@",qrCode);
        
    }else if (self.type == QRScanViewQRCodeType){
        NSLog(@"二维码内容为 = %@",qrCode);
    }
    
    
}

@end
