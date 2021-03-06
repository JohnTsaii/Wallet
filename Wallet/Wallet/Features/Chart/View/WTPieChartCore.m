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
    
    NSTimeInterval _lastPreTime;
    NSTimeInterval _moveTime;
    NSTimeInterval _endTime;
    
    CGFloat _velocity;
    NSTimer *_timer;
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
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat begin = self.beignAngle;
    for (WTPieChartPiece *obj in self.pieces) {
        NSInteger index = [self.pieces indexOfObject:obj];
        [self createArcWithColor:[self colorWithIndex:index] ctx:ctx rect:rect begin:begin delta:obj.delta];
        begin += obj.delta;
    }
}

- (UIColor *)colorWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return [UIColor colorWithRed:0.9 green:0 blue:0 alpha:1.0];
            break;
        case 1:
            return [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1.0];
            break;
        case 2:
            return [UIColor colorWithRed:0.9 green:1 blue:0 alpha:1.0];
            break;
        case 3:
            return [UIColor colorWithRed:0.4 green:1 blue:0 alpha:1.0];
            break;
        case 4:
            return [UIColor colorWithRed:0 green:1 blue:0 alpha:1.0];
            break;
        case 5:
            return [UIColor colorWithRed:0 green:1 blue:0.5 alpha:1.0];
            break;
        case 6:
            return [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0];
            break;
        case 7:
            return [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1.0];
            break;
        case 8:
            return [UIColor colorWithRed:0 green:0 blue:1 alpha:1.0];
            break;
        case 9:
            return [UIColor colorWithRed:0.5 green:0 blue:1 alpha:1.0];
            break;
        case 10:
            return [UIColor colorWithRed:1 green:0 blue:1 alpha:1.0];
            break;
        case 11:
            return [UIColor colorWithRed:1 green:0 blue:0.5 alpha:1.0];
            break;
        case 12:
            return [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            break;
        case 13:
            return [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            break;
        case 14:
            return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            break;
        default:
            return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
            break;
    }
}

- (void)createArcWithColor:(UIColor *)color ctx:(CGContextRef)ctx rect:(CGRect)rect begin:(CGFloat)begin delta:(CGFloat)delta
{
    CGFloat size = MIN(rect.size.height, rect.size.width);
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = size / 2;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRelativeArc(path, nil, center.x, center.y, radius, begin, delta);
    CGPathAddLineToPoint(path, nil, center.x, center.y);
    
    [color setFill];
    CGContextSetLineWidth(ctx, 1);
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathFill);
    
    CGPathRelease(path);
}

#pragma mark - touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_timer invalidate];
    _lastPreTime = [[NSDate date] timeIntervalSince1970];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_moveTime != 0) {
        _lastPreTime = _moveTime;
    }
    _moveTime = [[NSDate date] timeIntervalSince1970];
    UITouch *touch = touches.anyObject;
    CGPoint center = CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]));
    CGPoint currentPoint = [touch locationInView:self.superview];
    CGPoint prePoint = [touch previousLocationInView:self.superview];
    
    //calculate angle
    //反正切函数
    CGFloat angle = atan2f(currentPoint.y - center.y, currentPoint.x - center.x) - atan2f(prePoint.y - center.y, prePoint.x - center.x);
    [self changeAngle: angle];
    
    _velocity = angle / (_moveTime - _lastPreTime);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _endTime = [[NSDate date] timeIntervalSince1970];
    if (_endTime - _moveTime > 0.02) {
        return;
    }
    
    NSMutableDictionary *userinfo = @{@"v":@(_velocity),@"clockwise":@(_velocity>0?YES:NO)}.mutableCopy;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(step:) userInfo:userinfo repeats:YES];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}

- (void)step:(NSTimer *)timer
{
    CGFloat cvelocity = [timer.userInfo[@"v"] floatValue];
    bool clockwise = [timer.userInfo[@"clockwise"] boolValue];
    CGFloat s = cvelocity * 0.025;
    cvelocity = cvelocity -  _velocity * 0.04;
    
    if (clockwise && cvelocity < 0) {
        [timer invalidate];
        return;
    }
    else if (!clockwise && cvelocity > 0){
        [timer invalidate];
        return;
    }
    [timer.userInfo setObject:@(cvelocity) forKey:@"v"];
    [self changeAngle:s];
}

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

@end
