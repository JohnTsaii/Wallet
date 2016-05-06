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
    //test
    CGPoint beign;
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
    beign = [touch locationInView:self];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint move = [touch locationInView:self];
    
    [self changeAngle:M_PI/180];
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

@end
