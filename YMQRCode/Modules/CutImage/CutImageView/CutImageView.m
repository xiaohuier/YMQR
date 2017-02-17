//
//  CutImageView.m
//  YMQRCode
//
//  Created by 周正东 on 2017/2/8.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "CutImageView.h"

typedef NS_ENUM(NSInteger,MoveType)
{
    MoveTopLeftType,//左上角
    MoveBottomLeftType,//左下角
    MoveTopRightType,//右上角
    MoveBottomRightType,//右下角
    TouchMoveType,
    NoMoveType
};

@implementation CutImageView

{
    MoveType _moveType;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        
        self.touchMoveLength = 10;
        self.cutImageRectMin = CGSizeMake(50, 50);
        
    }
    return self;
}

-(CGRect)clearRect
{
    if (_clearRect.size.height<50||_clearRect.size.width<50) {
        _clearRect = CGRectMake(self.center.x -100, self.center.y -100, 200, 200);
    }
    return _clearRect;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self clearRect];
    
    [self drawClearRect];
    
    [self drawbackground:rect];
    
    //画4个圆环
    CGPoint ArcCenter1 = CGPointMake(CGRectGetMinX(_clearRect), CGRectGetMinY(_clearRect));
    [self drawCircleWithPoint:ArcCenter1];
    
    CGPoint ArcCenter2 = CGPointMake(CGRectGetMinX(_clearRect), CGRectGetMaxY(_clearRect));
    [self drawCircleWithPoint:ArcCenter2];
    
    CGPoint ArcCenter3 = CGPointMake(CGRectGetMaxX(_clearRect), CGRectGetMinY(_clearRect));
    [self drawCircleWithPoint:ArcCenter3];
    
    CGPoint ArcCenter4 = CGPointMake(CGRectGetMaxX(_clearRect), CGRectGetMaxY(_clearRect));
    [self drawCircleWithPoint:ArcCenter4];
    
    
}

-(void)drawClearRect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextAddRect(context, self.clearRect);
    
    //给rect画虚线边框
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat lengths[] = {4,4};
    
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextStrokePath(context);
    
    CGContextSetLineDash(context, 0, NULL, 0);
    
}

-(void)drawbackground:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.6);
    
    CGRect clips2[] =
    {
        CGRectMake(0, 0, rect.size.width, _clearRect.origin.y),
        CGRectMake(0, _clearRect.origin.y,_clearRect.origin.x, rect.size.height-_clearRect.origin.y),
        CGRectMake(_clearRect.origin.x, _clearRect.origin.y + _clearRect.size.height , rect.size.width - _clearRect.origin.x,rect.size.height - _clearRect.origin.y - _clearRect.size.height),
        CGRectMake(_clearRect.origin.x + _clearRect.size.width,_clearRect.origin.y,rect.size.width -_clearRect.origin.x - _clearRect.size.width,_clearRect.size.height)
    };
    
    CGContextClipToRects(context, clips2, sizeof(clips2) / sizeof(clips2[0]));
    
    CGContextFillRect(context, self.bounds);
    
}

-(void)drawCircleWithPoint:(CGPoint)point
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat lineWidth = 2.0f;
    CGContextAddArc(context, point.x, point.y, _touchMoveLength, 0, 2*M_PI, 1);
    CGContextSetLineWidth(context,lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    
    CGContextAddArc(context, point.x, point.y, _touchMoveLength -lineWidth/2, 0, 2*M_PI, 1);
    CGContextFillPath(context);
    
}


-(void)pan:(UIPanGestureRecognizer *)pan
{
    
    CGPoint translatePoint = [pan translationInView:self];//移动的距离
    
    CGPoint point = [pan locationInView:self];//pan手势识别到的的点的位置
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _moveType = [self judgeMoveType:point];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGRect clearRect = _clearRect;
        
        CGFloat length;
        
        length = MAX(fabs(translatePoint.x), fabs(translatePoint.y));
        
        
        switch (_moveType) {
            case MoveTopLeftType:
                if (translatePoint.x > 0) {
                    length = - length;
                }
                
                clearRect.size = CGSizeMake(clearRect.size.width + length, clearRect.size.height + length);
                clearRect.origin = CGPointMake(clearRect.origin.x - length, clearRect.origin.y -length);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
                
            case MoveTopRightType:
                if (translatePoint.x > 0) {
                    length = - length;
                }
                
                clearRect = CGRectMake(clearRect.origin.x, clearRect.origin.y +length, clearRect.size.width - length, clearRect.size.height - length);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case MoveBottomLeftType:
                
                if (translatePoint.x < 0) {
                    length = - length;
                }
                NSLog(@"%f",length);
                clearRect = CGRectMake(clearRect.origin.x + length, clearRect.origin.y, clearRect.size.width - length, clearRect.size.height - length);
                
                
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case MoveBottomRightType:
                if (translatePoint.x < 0) {
                    length = - length;
                }
                
                clearRect.size = CGSizeMake(clearRect.size.width+ length, clearRect.size.height + length);
                
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case TouchMoveType:
                clearRect.origin = CGPointMake(clearRect.origin.x + translatePoint.x, clearRect.origin.y + translatePoint.y);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            default:
                break;
        }
        //判断clearRect不能出了self的范围
        if(CGRectContainsRect(self.bounds,clearRect)){
            //判断clearrect，不能小于最小值
            if (clearRect.size.width>=self.cutImageRectMin.width &&clearRect.size.height>=self.cutImageRectMin.height) {
                _clearRect = clearRect;
            }
        }
        
    }
}

-(MoveType)judgeMoveType:(CGPoint)touchPoint
{
    //在这个方位内的，就拖着透明方块动
    CGRect moveRect = _clearRect;
    
    //缩放的rect，分为四个，因为方向值不一样，所以符号得不一样
    
    CGPoint ArcCenter1 = CGPointMake(CGRectGetMinX(_clearRect), CGRectGetMinY(_clearRect));
    
    CGPoint ArcCenter2 = CGPointMake(CGRectGetMinX(_clearRect), CGRectGetMaxY(_clearRect));
    
    CGPoint ArcCenter3 = CGPointMake(CGRectGetMaxX(_clearRect), CGRectGetMinY(_clearRect));
    
    CGPoint ArcCenter4 = CGPointMake(CGRectGetMaxX(_clearRect), CGRectGetMaxY(_clearRect));
    
    CGRect Rect1  = CGRectMake(ArcCenter1.x-_touchMoveLength,ArcCenter1.y-_touchMoveLength,_touchMoveLength*2,_touchMoveLength*2);
    
    CGRect Rect2  = CGRectMake(ArcCenter2.x-_touchMoveLength,ArcCenter2.y-_touchMoveLength,_touchMoveLength*2,_touchMoveLength*2);
    
    CGRect Rect3  = CGRectMake(ArcCenter3.x-_touchMoveLength,ArcCenter3.y-_touchMoveLength,_touchMoveLength*2,_touchMoveLength*2);
    
    CGRect Rect4  = CGRectMake(ArcCenter4.x-_touchMoveLength,ArcCenter4.y-_touchMoveLength,_touchMoveLength*2,_touchMoveLength*2);
    
    //    UIView *view = [[UIView alloc]initWithFrame:Rect1];
    //    view.backgroundColor = [UIColor redColor];
    //    [self addSubview:view];
    //
    //    view = [[UIView alloc]initWithFrame:Rect2];
    //    view.backgroundColor = [UIColor yellowColor];
    //    [self addSubview:view];
    //
    //    view = [[UIView alloc]initWithFrame:Rect3];
    //    view.backgroundColor = [UIColor blueColor];
    //    [self addSubview:view];
    //
    //    view = [[UIView alloc]initWithFrame:Rect4];
    //    view.backgroundColor = [UIColor blackColor];
    //    [self addSubview:view];
    
    
    if (CGRectContainsPoint(Rect1, touchPoint)) {
        //        NSLog(@"MoveTopLeftType");
        return  MoveTopLeftType;
    }
    if (CGRectContainsPoint(Rect2, touchPoint)) {
        //        NSLog(@"MoveBottomLeftType");
        return  MoveBottomLeftType;
    }
    if (CGRectContainsPoint(Rect3, touchPoint)) {
        //        NSLog(@"MoveTopRightType");
        return MoveTopRightType;
    }
    if (CGRectContainsPoint(Rect4, touchPoint)) {
        //        NSLog(@"MoveBottomRightType");
        return MoveBottomRightType;
    }
    if (CGRectContainsPoint(moveRect, touchPoint)) {
        //        NSLog(@"TouchMoveType");
        return  TouchMoveType;
    }else{
        //        NSLog(@"NoMoveType");
        return NoMoveType;
    }
    
}



@end
