//
//  YMQRCodeAppService.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/9.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "YMQRCodeAppService.h"
#import "HistoryTextDao.h"

#import "UIImage+QRCode.h"

@interface YMQRCodeAppService ()

@property (nonatomic,strong)NSString *imageName;

@property (nonatomic,strong)NSString *imagePath;

@end

@implementation YMQRCodeAppService

+(instancetype)shareInstance
{
    static YMQRCodeAppService *appService= nil;
    if (appService == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            appService = [[YMQRCodeAppService alloc]init];
        });
    }
    return appService;
}

-(void)setQRCodeImage:(UIImage *)QRCodeImage
{
    _QRCodeImage = QRCodeImage;
    
    BOOL success =   [self saveQRCodeImage:_QRCodeImage WithCutImage:_cutImage];
    
    NSParameterAssert(success);
}

-(void)setCutImage:(UIImage *)cutImage
{
    _cutImage = cutImage;
}

-(BOOL)saveQRCodeImage:(UIImage *)qrCodeImage WithCutImage:(UIImage *)cutImage
{
    NSData *imageData;
    if (cutImage !=nil)
    {
        CGRect rect = CGRectMake((qrCodeImage.size.width - cutImage.size.width)/2, (qrCodeImage.size.height - cutImage.size.height)/2, cutImage.size.width, cutImage.size.height);
        UIImage *newImage = [qrCodeImage addImage:cutImage withRect:rect];
        imageData = UIImagePNGRepresentation(newImage);
    }else{
        imageData = UIImagePNGRepresentation(qrCodeImage);
    }
    
    NSError *error;
    
    NSString *path = [[[self class]imageFolder ]stringByAppendingString:[self imagePath]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class]imageFolder]])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:[[self class]imageFolder] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSParameterAssert(!error);
    
    
    BOOL success = [imageData writeToFile:path atomically:YES];
    
    return success;
    
}

/*文件夹名字*/
+(NSString *)imageFolder
{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docsdir stringByAppendingString:@"/HistoryImage"];
    return path;
}

-(NSString *)imagePath
{
    NSParameterAssert(_imageName);
    
    _imagePath = [NSString stringWithFormat:@"/%@.png",_imageName];
    
    return _imagePath ;
    
}

-(void)setOriginalQRCodeImage:(UIImage *)originalQRCodeImage
{
    _originalQRCodeImage = originalQRCodeImage;
    
    _imageName = [[self class] getUuid];
    
    
}

-(BOOL)insertToDataBaseWithType:(NSUInteger)type jsonString:(NSString *)jsonString
{
    NSParameterAssert(self.imagePath);
    
    NSDictionary *dic = @{@"type":@(type),@"jsonString":jsonString,@"imagePath":_imagePath};
    
    return [[HistoryTextDao shareInstance]insertModel:dic];
    
}

+(NSString *)getUuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_string_ref);
    
    return uuid;
}

@end
