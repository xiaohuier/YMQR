//
//  BarCodeReadingView.m
//  BarCode
//
//  Created by junhaoshen on 16/12/30.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "BarCodeReadingView.h"

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height
#define X self.frame.origin.x
#define Y self.frame.origin.y


@implementation BarCodeReadingView


- (void)drawRect:(CGRect)rect
{
    
    CGFloat leftRectHeight = WIDTH - self.leftRectWidth * 2;
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // .画上矩形
    CGContextAddRect(ctx, CGRectMake(0, 0, WIDTH, self.topRectHeight));
    
    // set : 同时设置为实心和空心颜色
    // setStroke : 设置空心颜色
    // setFill : 设置实心颜色
    [[UIColor whiteColor] setFill];
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0,0.6);
    //    CGContextSetAlpha(ctx, 0.6);
    
    // 2.左边矩形
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, self.topRectHeight, self.leftRectWidth, leftRectHeight));
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0,0.6);
    
    CGContextFillPath(ctx);
    
    // 3.右边矩形
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(self.leftRectWidth + leftRectHeight, self.topRectHeight, self.leftRectWidth, leftRectHeight));
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0,0.6);
    
    CGContextFillPath(ctx);
    
    // 4.下矩形
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, self.topRectHeight+ leftRectHeight, WIDTH, HEIGHT - self.topRectHeight - leftRectHeight));
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0,0.6);
    
    CGContextFillPath(ctx);
    
    // 4.扫描框
    CGContextFillPath(ctx);
    [[UIColor whiteColor] setStroke];
    
    CGContextAddRect(ctx, CGRectMake(self.leftRectWidth, self.topRectHeight, leftRectHeight, leftRectHeight));
    
    //    CGContextSetRGBStrokeColor(ctx, 0, 255, 255,0.6);
    
    CGContextStrokePath(ctx);
    
    // 5.红线
    
    CGContextFillPath(ctx);
    CGContextSetLineWidth(ctx, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {239/255.0, 69/255.0, 65/255.0, 1.0};//颜色元素
    CGColorRef color=CGColorCreate(colorspace,components);//这两行创建颜色
    CGContextSetStrokeColorWithColor(ctx, color);
    //上左
    CGContextMoveToPoint(ctx, self.leftRectWidth, self.topRectHeight);//设置线段的起始点
    
    CGContextAddLineToPoint(ctx, self.leftRectWidth + 30, self.topRectHeight);//设置线段的终点
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    CGContextStrokePath(ctx);
    
    //上右
    CGContextMoveToPoint(ctx, self.leftRectWidth + leftRectHeight - 30, self.topRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //下左
    CGContextMoveToPoint(ctx, self.leftRectWidth, self.topRectHeight+leftRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth + 30, self.topRectHeight+leftRectHeight);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //下右
    CGContextMoveToPoint(ctx, self.leftRectWidth + leftRectHeight - 30, self.topRectHeight+leftRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight+leftRectHeight);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //竖向红线
    //上左
    CGContextMoveToPoint(ctx, self.leftRectWidth, self.topRectHeight);//设置线段的起始点
    
    CGContextAddLineToPoint(ctx, self.leftRectWidth, self.topRectHeight+30);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //上右
    CGContextMoveToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight+30);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //下左
    CGContextMoveToPoint(ctx, self.leftRectWidth, self.topRectHeight+leftRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth , self.topRectHeight+leftRectHeight-30);//设置线段的终点
    CGContextStrokePath(ctx);
    
    //下右
    CGContextMoveToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight+leftRectHeight);
    CGContextAddLineToPoint(ctx, self.leftRectWidth + leftRectHeight, self.topRectHeight+leftRectHeight-30);//设置线段的终点
    CGContextStrokePath(ctx);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
