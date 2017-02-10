//
//  UIImage+QRCode.h
//  YMQRCode
//
//  Created by 周正东 on 2017/2/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/**通过字符串创建二维码图片
 string
 图片的宽高
 return image
*/
+(UIImage *)creatQRCodeImageWithString:(NSString *)string WidthAndHeight:(CGFloat)widthAndHeight;

/**保存图片到系统相册*/
+(void)saveImageToAlbum:(UIImage *)image completionHandler:(void(^)(BOOL success, NSError *error))completionHandler;

/**传入一个颜色，把图片的颜色集体改变*/
+ (UIImage*)imageColorToTransparent:(UIImage*)image withColor:(UIColor *)color;
/**把2个image合并*/
-(UIImage *)addImage:(UIImage *)image withRect: (CGRect)rect;


/**设置image的大小*/
+(UIImage *)setupWithImage:(UIImage *)images imageSize:(CGSize)size;

//最终决定截取图片的大小
- (UIImage *)getCroppedImage :(CGRect)imageRect;

/**把一个view转化成image*/
+(UIImage *)imageForView:(UIView *)view;
@end
