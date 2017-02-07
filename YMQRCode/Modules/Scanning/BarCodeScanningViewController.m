//
//  BarCodeScanningViewController.m
//  BarCode
//
//  Created by junhaoshen on 16/12/30.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "BarCodeScanningViewController.h"
#import "BarCodeReadingView.h"
//#import "CardViewController.h"

@interface BarCodeScanningViewController ()<CAAnimationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton *flashLightButton;
@property(nonatomic,strong)UILabel  *flashLightLable;

@property(nonatomic,strong)UIButton *pictureButton;
@property(nonatomic,strong)UILabel  *pictureLable;

@property(nonatomic,assign)BOOL isStop;

@end

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
    
    BACK_TITLE
    
    BACK_COLOR_WHITE
    
    self.title = @"二维码扫描";
    
    self.navigationController.navigationBarHidden = NO;
    
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
    label.textColor = WORDSCOLOR;
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
    self.flashLightButton.frame=CGRectMake(0, 0, 50.0/375*WIDTH, 50.0/375*WIDTH);
    self.flashLightButton.center = CGPointMake(WIDTH/3, CGRectGetMaxY(label.frame) + 60.0/375*WIDTH);
    [self.flashLightButton addTarget:self action:@selector(flashLightClick) forControlEvents:UIControlEventTouchUpInside];
    
    //灯光标题
    self.flashLightLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.flashLightButton.frame.size.width, 24)];
    self.flashLightLable.center = CGPointMake(self.flashLightButton.center.x, self.flashLightButton.center.y+self.flashLightButton.frame.size.height);
    self.flashLightLable.text = @"开灯";
    self.flashLightLable.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.flashLightLable.textAlignment = NSTextAlignmentCenter;
    self.flashLightLable.lineBreakMode = NSLineBreakByWordWrapping;
    self.flashLightLable.numberOfLines = 2;
    self.flashLightLable.font=[UIFont systemFontOfSize:12];
    self.flashLightLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.flashLightButton];
    [self.view addSubview:self.flashLightLable];
    
    //图片获取
    self.pictureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.pictureButton setBackgroundImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
    self.pictureButton.frame=CGRectMake(0, 0, self.flashLightButton.frame.size.width, self.flashLightButton.frame.size.height);
    self.pictureButton.center = CGPointMake(WIDTH - WIDTH/3, CGRectGetMaxY(label.frame) + 60.0/375*WIDTH);
    [self.pictureButton addTarget:self action:@selector(pictureClick) forControlEvents:UIControlEventTouchUpInside];
    
    //图片获取标题
    self.pictureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.flashLightButton.frame.size.width, 24)];
    self.pictureLable.center = CGPointMake(self.pictureButton.center.x, self.pictureButton.center.y+self.pictureButton.frame.size.height);
    self.pictureLable.text = @"相册";
    self.pictureLable.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.pictureLable.textAlignment = NSTextAlignmentCenter;
    self.pictureLable.lineBreakMode = NSLineBreakByWordWrapping;
    self.pictureLable.numberOfLines = 2;
    self.pictureLable.font=[UIFont systemFontOfSize:12];
    self.pictureLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.pictureButton];
    [self.view addSubview:self.pictureLable];

    
   
}

#pragma mark - 扫描线动画
-(void)addLineAnimation
{
    CGFloat nu = (readerBackViewleftRectWidth * 5 - 15 );
    CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
    scanNetAnimation.keyPath = @"transform.translation.y";
    scanNetAnimation.toValue = @(nu);
    scanNetAnimation.duration = 2.0;
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

- (void)ac_pause :(CALayer *)layer
{
    CFTimeInterval localTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = localTime;
}

- (void)ac_resume :(CALayer *)layer
{
    CFTimeInterval lastLocalTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval localTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.beginTime = localTime - lastLocalTime;
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

//获取相册图片
-(void)pictureClick{
    
    UIImagePickerController *imagrPicker = [[UIImagePickerController alloc]init];
    imagrPicker.delegate = self;
    imagrPicker.allowsEditing = YES;
    //将来源设置为相册
    imagrPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagrPicker animated:YES completion:nil];
    
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
            //通过对话框的形式呈现
            [self alertControllerMessage:scannedResult andBool:YES];
            
        }else{
            [self alertControllerMessage:@"未找到图中的二维码" andBool:NO];
        }
    }];
}

//封装一个方法
-(void)alertControllerMessage:(NSString *)message andBool:(BOOL)isYes {

    [self.captureSession stopRunning];
    [self ac_pause:_line.layer];
    
    
    if (isYes) {
        
        if ([message hasPrefix:@"http://"]||[message hasPrefix:@"https://"]||[message hasPrefix:@"sms:"]||[message hasPrefix:@"tel:"]){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.captureSession startRunning];

            }];
            
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message]];
                
            }];
            
            [alert addAction:sure];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([message hasPrefix:@"BEGIN:VCARD"]){
            
//            CardViewController *card = [[CardViewController alloc]init];
//            
//            card.cardMessage = message;
//            
//            [self.navigationController pushViewController:card animated:NO];
            
        }else{
            
            UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string=message;
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"文本内容已剪切到粘贴板" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.captureSession startRunning];
                
                
                [self ac_resume:_line.layer];
            }];
            
            [alert addAction:sure];
            [self presentViewController:alert animated:YES completion:nil];
            
        }

    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.captureSession startRunning];
            
        }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
//    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"拨打此电话" message:_textString preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    UIAlertAction *play = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:400-966-0800"]];
//        
//        
//    }];
//    
//    [alertController addAction:cancel];
//    
//    [alertController addAction:play];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        
            
        }];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [alertController addAction:alertAction];
        
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
