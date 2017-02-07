//
//  BarCodeScanningViewController.h
//  BarCode
//
//  Created by junhaoshen on 16/12/30.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>



@interface BarCodeScanningViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL isScaning;
    NSTimer * timer;
    UIImageView*_line;
}

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, assign) BOOL isScanning;

@property (nonatomic)BOOL isQRCode;

//初始化函数
-(id)initWithIsQRCode:(BOOL)isQRCode;

@end
