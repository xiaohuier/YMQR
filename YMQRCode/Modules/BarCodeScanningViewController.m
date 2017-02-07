//
//  BarCodeScanningViewController.m
//  BarCode
//
//  Created by junhaoshen on 16/12/30.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "BarCodeScanningViewController.h"
#import "BarCodeReadingView.h"

@interface BarCodeScanningViewController ()<CAAnimationDelegate>

@property(nonatomic,strong)UIButton *flashLightButton;
@property(nonatomic,strong)UILabel  *flashLightLable;
@property(nonatomic,strong)UIButton *backbutton;

@end

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define readerBackViewTopHeight (HEIGHT)/6
#define readerBackViewleftRectWidth (WIDTH)/7

@implementation BarCodeScanningViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(id)initWithIsQRCode:(BOOL)isQRCode
{
    if (self=[super init]) {
        self.isQRCode=isQRCode;
    }
    
    return self;
}

-(void)appBecameActive{
    [self viewWillAppear:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self  resumeAnimation];
    
    isScaning = YES;
    
    [super viewWillAppear:animated];
    
    [self.captureSession startRunning];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecameActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    _line.frame = CGRectMake(readerBackViewleftRectWidth, readerBackViewTopHeight+10, readerBackViewleftRectWidth*5, 2);
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建视图
-(void)createView{
    
    BarCodeReadingView * backview = [[BarCodeReadingView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backview.topRectHeight = readerBackViewTopHeight;
    backview.leftRectWidth = readerBackViewleftRectWidth;
    backview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backview];
    
    //扫码线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(readerBackViewleftRectWidth, readerBackViewTopHeight+10, readerBackViewleftRectWidth*5, 2)];
    _line.image = [UIImage imageNamed:@"扫描线"];
    [self.view addSubview:_line];
    
    //扫码说明
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, readerBackViewleftRectWidth*5+readerBackViewTopHeight+10, WIDTH, 24)];
    label.text = @"把二维码放入框内，可自动搜索";
    label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.6];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    //灯光按钮
    self.flashLightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.flashLightButton setBackgroundImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateNormal];
    [self.flashLightButton setBackgroundImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateSelected];
    self.flashLightButton.frame=CGRectMake(0, 0, 42.0/320*WIDTH, 42.0/320*WIDTH);
    self.flashLightButton.center = CGPointMake(WIDTH/2, HEIGHT/5*4);
    [self.flashLightButton addTarget:self action:@selector(flashLightClick) forControlEvents:UIControlEventTouchUpInside];
    
    //灯光标题
    self.flashLightLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.flashLightButton.frame.origin.y+self.flashLightButton.frame.size.height, WIDTH, 24)];
    self.flashLightLable.text = @"开灯";
    self.flashLightLable.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.flashLightLable.textAlignment = NSTextAlignmentCenter;
    self.flashLightLable.lineBreakMode = NSLineBreakByWordWrapping;
    self.flashLightLable.numberOfLines = 2;
    self.flashLightLable.font=[UIFont systemFontOfSize:12];
    self.flashLightLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.flashLightButton];
    [self.view addSubview:self.flashLightLable];
    
    
//    //假导航
//    self.backbutton= [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.backbutton setBackgroundImage:[UIImage imageNamed:@"扫码返回"] forState:UIControlStateHighlighted];
//    [self.backbutton setBackgroundImage:[UIImage imageNamed:@"扫码返回"] forState:UIControlStateNormal];
//    
//    [self.backbutton setFrame:CGRectMake(15,26, 27.0/320*WIDTH, 27.0/320*WIDTH)];
//    [self.backbutton addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:self.backbutton];
    
    
}

#pragma mark - 扫描线动画
-(void)addLineAnimation
{
    CGFloat nu = (readerBackViewleftRectWidth * 5 - 15 );
    CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
    scanNetAnimation.keyPath = @"transform.translation.y";
    scanNetAnimation.toValue = @(nu);
    scanNetAnimation.duration = 3.0;
    scanNetAnimation.repeatCount = MAXFLOAT;
    scanNetAnimation.autoreverses =YES;
    [_line.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
}
- (void)resumeAnimation
{
    CAAnimation *anim = [_line.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _line.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        // 3. 要把偏移时间清零
        [_line.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_line.layer setBeginTime:beginTime];
        
        [_line.layer setSpeed:1.0];
        
    }else{
        [self addLineAnimation];
    }
    
}

//开启关闭闪光灯
-(void)flashLightClick{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode==AVCaptureTorchModeOff) {
        //闪光灯开启
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        self.flashLightButton.selected = YES;
        self.flashLightLable.text = @"关灯";
        
    }else {
        //闪光灯关闭
        
        [device setTorchMode:AVCaptureTorchModeOff];
        self.flashLightButton.selected = NO;
        self.flashLightLable.text =@"开灯";
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //相机界面的定制在self.view上加载即可
    BOOL Custom= [UIImagePickerController
                  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];//判断摄像头是否能用
    if (Custom) {
        [self initCapture];//启动摄像头
    }else{
        self.view.backgroundColor=[UIColor whiteColor];
    }
    
    [self createView];
    
    
    
}

#pragma mark 点击取消
- (void)pressCancelButton:(UIButton *)button
{
    self.isScanning = NO;
    [self.captureSession stopRunning];
    _line.frame = CGRectMake(readerBackViewleftRectWidth, 100+10, readerBackViewleftRectWidth*5, 2);
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark 开启相机
- (void)initCapture
{
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString*str=@"请在系统\"设置－隐私－相机\"中打开允许使用相机";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
        
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    AVCaptureDevice* inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    [self.captureSession addInput:captureInput];
    
    AVCaptureMetadataOutput*_output=[[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [self.captureSession addOutput:_output];
    _output.rectOfInterest = CGRectMake(100.0/HEIGHT, readerBackViewleftRectWidth/WIDTH, (WIDTH - readerBackViewleftRectWidth*2)/HEIGHT,(WIDTH - readerBackViewleftRectWidth*2)/WIDTH);
    
    if (_isQRCode) {
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
        
    }else{
        _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];
    }
    
    
    if (!self.captureVideoPreviewLayer) {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    self.captureVideoPreviewLayer.frame = self.view.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer: self.captureVideoPreviewLayer];
    
    self.isScanning = YES;
    
    [self.captureSession startRunning];
    
    
}





#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if (metadataObjects.count>0 && isScaning)
    {
        [self.captureSession stopRunning];
        isScaning = NO;
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        [self handleBarCodeWithCode:metadataObject.stringValue];
    }
    
}
#pragma mark -扫码处理
- (void)handleBarCodeWithCode:(NSString *)barCode
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"saomiao" message:barCode preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    isScaning = YES;
    
    [self.captureSession startRunning];
}
- (void)gotoSearchResultWithBarCode:(NSString *)barCode{
    
}

-(void)showDJproductDetailWithSkuId:(long)SKUId{
    
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
