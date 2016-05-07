//
//  WTPieChartCore.m
//  Wallet
//
//  Created by xiaofeishen on 5/6/16.
//  Copyright © 2016 JohnTsai. All rights reserved.
//

#import "WTPieChartCore.h"

@interface WTPieChartCore ()
{
    NSInteger _currIndex;
    CGPoint _centerPoint;
    CGPoint _beginPoint;
}
@end

@implementation WTPieChartCore

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - draw
- (void)drawRect:(CGRect)rect
{
    _centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSArray<UIColor *> *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];
    CGFloat begin = self.beignAngle;
    for (WTPieChartPiece *obj in self.pieces) {
        NSInteger index = [self.pieces indexOfObject:obj];
        [self createArcWithColor:colors[index] ctx:ctx rect:rect begin:begin delta:obj.delta];
        begin += obj.delta;
    }
}

- (void)createArcWithColor:(UIColor *)color ctx:(CGContextRef)ctx rect:(CGRect)rect begin:(CGFloat)begin delta:(CGFloat)delta
{
    CGFloat size = MIN(rect.size.height, rect.size.width);
    CGFloat radius = size / 2;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRelativeArc(path, nil, radius, radius, radius, begin, delta);
    CGPathAddLineToPoint(path, nil, radius, radius);
    
    [color setFill];
    CGContextSetLineWidth(ctx, 1);
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathFill);
    
    CGPathRelease(path);
}

#pragma mark - touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    _beginPoint = [touch locationInView:self.superview];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint moved = [touch locationInView:self.superview];
    
    //calculate angle
    //余弦定理
    CGFloat a = 0, b = 0, c = 0, y = 0;
    a = sqrt((_beginPoint.x - moved.x) * (_beginPoint.x - moved.x) + (_beginPoint.y - moved.y) * (_beginPoint.y - moved.y));
    b = sqrt((_centerPoint.x - moved.x) * (_centerPoint.x - moved.x) + (_centerPoint.y - moved.y) * (_centerPoint.y - moved.y));
    c = sqrt((_beginPoint.x - _centerPoint.x) * (_beginPoint.x - _centerPoint.x) + (_beginPoint.y - _centerPoint.y) * (_beginPoint.y - _centerPoint.y));
    y = (b * b + c * c  - a * a) / 2 / b / c;
    
    CGFloat angle = acos(y);
    CGFloat x = [self crossCenter:_centerPoint begin:_beginPoint moved:moved];
    angle = x > 0 ? angle : - angle;
    [self changeAngle:angle];
    
    _beginPoint = moved;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}

- (void)changeAngle:(CGFloat)angle
{
    self.transform = CGAffineTransformRotate(self.transform, angle);
    WTPieChartPiece *obj = self.pieces.firstObject;
    obj.begin += angle;
    for (WTPieChartPiece *tmp in self.pieces) {
        if (tmp.begin + tmp.delta > M_PI * 2) {
            NSInteger index = [self.pieces indexOfObject:tmp];
            if (index != _currIndex) {
                _currIndex = index;
                [self.delegate wtPieChartCore:self slideInIndex:_currIndex];
            }
        }
    }
}

/**
 *  计算向量乘积 :
     知识点→
 *    设向量A = ( x1, y1 )，B = ( x2, y2 )
 *    |A×B| = x1*y2 - x2*y1 = |A|×|B|×sin(向量A到B的夹角)
 *    所以这个值的正负也就是A到B旋转角sin值的正负
 *    顺时针旋转角度0~180，sin>0
 *    顺时针旋转角度180~360或者说逆时针旋转0~180，sin<0
 */
- (float)crossCenter:(CGPoint)center begin:(CGPoint)begin moved:(CGPoint)moved
{
    CGPoint a = CGPointMake(begin.x - center.x, begin.y - center.y);
    CGPoint b = CGPointMake(moved.x - center.x, moved.y - center.y);
    
    return a.x * b.y - b.x * a.y;
}

@end
