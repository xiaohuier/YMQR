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
    MoveTopLineType,
    MoveLeftLineType,
    MoveRightLineType,
    MoveBottomLineType,
    TouchMoveType,
    NoMoveType,
};

@implementation CutImageView
{
    MoveType _moveType;
}
-(instancetype)init
{
    if (self = [super init]) {
        _clearRect = CGRectMake(0, 0, 100, 100);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.image drawInRect:rect];
    
    CGContextAddRect(context, _clearRect);
    
    //给rect画虚线边框
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat lengths[] = {4,4};
    
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextStrokePath(context);
//    画周围的黑色遮罩
    
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

-(void)pan:(UIPanGestureRecognizer *)pan
{
    
    CGPoint translatePoint = [pan translationInView:self];//移动的距离
    
    CGPoint point = [pan locationInView:self];//pan手势识别到的的点的位置
    
    if (self.touchMoveLength == 0) {
        self.touchMoveLength = 20;
    }
    if (self.cutImageRectMin.height == 0 &&self.cutImageRectMin.width == 0) {
        self.cutImageRectMin = CGSizeMake(50, 50);
    }
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _moveType = [self judgeMoveType:point];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGRect clearRect = _clearRect;
        switch (_moveType) {
            case MoveTopLineType:
                
                clearRect.size = CGSizeMake(clearRect.size.width - translatePoint.y, clearRect.size.height - translatePoint.y);
                clearRect.origin = CGPointMake(clearRect.origin.x + translatePoint.y, clearRect.origin.y + translatePoint.y);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case MoveRightLineType:
                clearRect.size = CGSizeMake(clearRect.size.width +translatePoint.x, clearRect.size.height+translatePoint.x);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case MoveLeftLineType:
                clearRect.size = CGSizeMake(clearRect.size.width -translatePoint.x, clearRect.size.height  - translatePoint.x);
                clearRect.origin = CGPointMake(clearRect.origin.x + translatePoint.x, clearRect.origin.y + translatePoint.x);
                [pan setTranslation:CGPointZero inView:self];
                [self setNeedsDisplay];
                break;
            case MoveBottomLineType:
                clearRect.size = CGSizeMake(clearRect.size.width+ translatePoint.y, clearRect.size.height + translatePoint.y);
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
    CGRect moveRect = CGRectMake(_clearRect.origin.x + self.touchMoveLength, _clearRect.origin.y + self.touchMoveLength, _clearRect.size.width - self.touchMoveLength*2, _clearRect.size.height - self.touchMoveLength * 2);
    
    //缩放的rect，分为四个，因为方向值不一样，所以符号得不一样
    
    CGRect leftRect  = CGRectMake(_clearRect.origin.x - self.touchMoveLength, _clearRect.origin.y - self.touchMoveLength, 2*self.touchMoveLength, _clearRect.size.height + 2*self.touchMoveLength);
    
    
    CGRect topRect  = CGRectMake(_clearRect.origin.x - self.touchMoveLength, _clearRect.origin.y - self.touchMoveLength, _clearRect.size.width + 2*self.touchMoveLength,2* self.touchMoveLength);
    
    CGRect rightRect  = CGRectMake(_clearRect.origin.x +_clearRect.size.width - self.touchMoveLength, _clearRect.origin.y - self.touchMoveLength, 2*self.touchMoveLength, _clearRect.size.height + 2*self.touchMoveLength);
    
    CGRect bottomRect  = CGRectMake(_clearRect.origin.x - self.touchMoveLength, _clearRect.origin.y +_clearRect.size.height - self.touchMoveLength, _clearRect.size.width + 2*self.touchMoveLength,2* self.touchMoveLength);
    
    
    if (CGRectContainsPoint(moveRect, touchPoint)) {
        return  TouchMoveType;
    }
    if (CGRectContainsPoint(leftRect, touchPoint)) {
        return  MoveLeftLineType;
    }
    if (CGRectContainsPoint(topRect, touchPoint)) {
        return  MoveTopLineType;
    }
    if (CGRectContainsPoint(rightRect, touchPoint)) {
        return MoveRightLineType;
    }
    if (CGRectContainsPoint(bottomRect, touchPoint)) {
        return  MoveBottomLineType;
    }else{
        return NoMoveType;
    }
    
}

@end
