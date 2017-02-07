//
//  ShareView.m
//
//
//  Created by zyh on 14-9-5.
//  Mr_Zhaohy 修改 2015-05
//  Copyright (c) 2014年 com.erongdu.QZW. All rights reserved.
//

#import "ShareView.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@implementation ShareView

-(void)shareViewController:(UIViewController*)viewController
{
    
    shareView =[[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    shareView.backgroundColor = [UIColor colorWithRed:45.f/255 green:45.f/255 blue:45.f/255 alpha:.0f];

    //基于window弹出
     AppDelegate  *shareapp=(AppDelegate *)[UIApplication sharedApplication].delegate;
   
    [shareapp.window.rootViewController.view addSubview:shareView];
    //基于视图控制器弹出
    //[viewController.view addSubview:shareView];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    
    [tapGestureRecognizer addTarget:self action:@selector(exit)];
    
    [shareView addGestureRecognizer:tapGestureRecognizer];
    
    self.frame = CGRectMake(0, shareView.bounds.size.height, shareView.frame.size.width, self.frame.size.height);
    
    [shareView addSubview: self];
    
    [UIView animateWithDuration:.3f animations:^{
        
        shareView.backgroundColor = [UIColor colorWithRed:45.f/255 green:45.f/255 blue:45.f/255 alpha:.6f];

        if (self.isSelect) {
            
            self.frame = CGRectMake(0, shareView.bounds.size.height-self.frame.size.height, shareView.frame.size.width, self.frame.size.height);
            
        }else{
            
            self.QRcodeImg.hidden = YES;
            
            self.labelWords.hidden = YES;
            
            self.share.hidden = NO;
            
         
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, shareView.frame.size.width, 50)];
            
            if (IS_IPHONE_4_OR_LESS) {
                
                label.font = [UIFont systemFontOfSize:18];
                
            }else{
                
                label.font = [UIFont systemFontOfSize:21];
            }
            
            
            label.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
            
            label.text = @"分享到";
            
            
            
            label.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:label];
            
            self.frame = CGRectMake(0, shareView.bounds.size.height - self.frame.size.height + 200, shareView.frame.size.width, self.frame.size.height - 200);
        }
        
        
        
    }];

    [self interfaceSetup];
    
    
}
- (IBAction)clickshare:(id)sender
{
    UIButton* shareBtn = (UIButton*)sender;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    //图片
    [message setThumbImage:self.shareImage];
    //标题
    message.title = self.titleString;
    //内容
    message.description = self.contentString;
    
    WXWebpageObject *ext1 =[WXWebpageObject object];
    
    //链接
    ext1.webpageUrl=self.urlString;
    
    message.mediaObject=ext1;
    
    req.bText = NO;
    
    req.message = message;

    if (shareBtn.tag ==100)
    {
        //微信

        NSLog(@"--------%d",[WXApi isWXAppInstalled]);
        
        if ([WXApi isWXAppInstalled]) {
            
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有安装微信，不能使用此功能!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }

    }
    else if (shareBtn.tag == 110)
    {
        //朋友圈
        if ([WXApi isWXAppInstalled]) {
            
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有安装微信，不能使用此功能!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
        }

    }
    else
    {
        //QQ好友
        WBMessageObject *message = [WBMessageObject message];
        
        message.text = self.weiboString;
        
        WBImageObject * data = [[WBImageObject alloc]init];
        
        data.imageData = UIImageJPEGRepresentation(self.shareImage, 1);
        
        message.imageObject = data;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        
        request.userInfo = nil;
        
        [WeiboSDK sendRequest:request];

    }
    
    [self exit];
}



- (IBAction)exitButton:(id)sender {
    
    [self exit];
    
    
    
}

-(void)interfaceSetup{
    
    // 1.创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.还原滤镜默认属性
    [filter setDefaults];
    
    // 3.设置需要生成二维码的数据到滤镜中
    // OC中要求设置的是一个二进制数据
    NSData *data;
    
    data = [@"https://itunes.apple.com/cn/app/mi-jin-she-quan-wen-jian-li/id1111162244?mt=8" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"InputMessage"];
    
    // 4.从滤镜从取出生成好的二维码图片
    CIImage *ciImage = [filter outputImage];
    
    self.QRcodeImg.image = [self createNonInterpolatedUIImageFormCIImage:ciImage size:300];
    
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
    
}



-(void)exit
{
    [UIView animateWithDuration:.3f animations:^{
        self.frame = CGRectMake(0, shareView.bounds.size.height, self.frame.size.width, self.frame.size.height);
        shareView.alpha = 0 ;
    }];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3f];
    [shareView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3f];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
