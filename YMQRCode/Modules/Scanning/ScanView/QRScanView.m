//
//  QRScanView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/14.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "QRScanView.h"

#define minX (self.frame.size.width - self.rectSize.width)/2
#define maxX  minX + self.rectSize.width
#define minY  (self.frame.size.height - self.rectSize.height)/2 +_offsetY
#define maxY  self.rectSize.height +minY

@interface QRScanView ()
/**扫描区域大小*/
@property(nonatomic,assign)CGSize rectSize;
/**扫描区域相对于View中心点的偏移量，向下为正*/
@property(nonatomic,assign)float offsetY;
/**动画的扫描线*/
@property(nonatomic,strong)UIImageView *animationLine;
/**是否反向扫描*/
@property(nonatomic,getter=isAnmimationAutoReverse)BOOL anmimationAutoReverse;
/**是不是在动画*/
@property(nonatomic,getter=isAnmimating)BOOL animating;
/**二维码还是条形码*/
@property (nonatomic,assign)QRScanViewType type;
@end

@implementation QRScanView

-(instancetype)initWithFrame:(CGRect)frame
                    rectSize:(CGSize)size
                     offsetY:(CGFloat)offsetY
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rectSize =size;
        self.offsetY =offsetY;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //计算基准坐标
    
    //绘制半透明黑色区域
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, minY));
    CGContextFillRect(context, CGRectMake(0, minY, minX, self.rectSize.height));
    CGContextFillRect(context, CGRectMake(0, maxY, self.frame.size.width, self.frame.size.height- maxY));
    CGContextFillRect(context, CGRectMake(maxX, minY, minX, self.rectSize.height));
    
    //绘制中间区域的白色边框
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    
    CGContextAddRect(context, CGRectMake(minX, minY, self.rectSize.width, self.rectSize.height));
    
    CGContextStrokePath(context);
    
    //绘制中间区域的四个角落
    CGFloat cornerLineLength = 30.0f;
    CGFloat cornerLineThick = 2.0f;
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed: 239/255.0 green:69/255.0 blue:65/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, cornerLineThick);
    
    CGContextMoveToPoint(context, minX + cornerLineLength - cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, minY +cornerLineLength - cornerLineThick);
    
    CGContextMoveToPoint(context, minX + cornerLineLength - cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, maxY -cornerLineLength + cornerLineThick);
    
    CGContextMoveToPoint(context, maxX - cornerLineLength + cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY +cornerLineLength - cornerLineThick);
    
    CGContextMoveToPoint(context, maxX - cornerLineLength + cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, maxY -cornerLineLength + cornerLineThick);
    
    CGContextStrokePath(context);

}

-(UIImageView *)animationLine
{
    
    if (_animationLine == nil) {
        _animationLine = [[UIImageView alloc]initWithFrame:CGRectMake(minX, minY, self.rectSize.width, 2.0f)];
        _animationLine.image = [UIImage imageNamed:@"扫描线"];
        [self addSubview:_animationLine];
    }
    return _animationLine;
}

-(void)startAnimation
{
    if (self.isAnmimating) {
        return;
    }
    self.animating = YES;
    [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (_anmimationAutoReverse) {
            self.animationLine.frame =CGRectMake(minX, minY, self.rectSize.width, 2.0f);
        }else{
            self.animationLine.frame =CGRectMake(minX, maxY, self.rectSize.width, 2.0f);
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.animating = !self.animating;
            self.anmimationAutoReverse = !self.anmimationAutoReverse;
            [self startAnimation];
        }else{
            [self stopAnimation];
        }
    }];
}

-(void)stopAnimation
{
    self.animating = NO;
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    self.anmimationAutoReverse = NO;
    
}

-(void)initTips
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.foregroundColor =  [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1].CGColor;
    textLayer.backgroundColor = [UIColor clearColor].CGColor;
    textLayer.wrapped = YES;
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    NSString *text = self.tipString;
    
    //font
    UIFont *font = [UIFont systemFontOfSize:12];
    CGFontRef fontRef = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);//
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    
    textLayer.frame = CGRectMake((self.frame.size.width - size.width)/2, maxY + 10, size.width, size.height);
    [self.layer addSublayer:textLayer];
    
    self.bottom = CGRectGetMaxY(textLayer.frame);
    textLayer.string = text;
   
}

-(void)changeType:(QRScanViewType)type
{
    
    self.type = type;
    
    [self setNeedsDisplay];
}

-(void)setTipString:(NSString *)tipString
{
    _tipString = tipString;
    [self initTips];
}


@end
