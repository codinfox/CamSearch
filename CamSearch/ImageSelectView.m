//
//  ImageSelectView.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "ImageSelectView.h"

@implementation ImageSelectView {
    CGPoint _beginPoint;
    CGPoint _endPoint;
    CGRect _selectedRect;
    CGRect _confineRect;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.5;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)r
{
    CGContextRef _context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(_beginPoint.x, _beginPoint.y, _endPoint.x - _beginPoint.x, _endPoint.y - _beginPoint.y);
    
    _selectedRect = rect;
    
    CGContextSetFillColorWithColor(_context, [UIColor blackColor].CGColor);
    CGContextFillRect(_context, r);
    
//    CGContextSetFillColorWithColor( _context, [UIColor clearColor].CGColor );
    CGContextClearRect(_context, rect);
    
    CGContextAddRect(_context,rect);
    CGContextSetLineWidth(_context, 3);
    CGContextSetRGBStrokeColor(_context, 1, 1, 1, 1);
    CGContextStrokePath(_context);
    

}

#pragma mark - Gestures
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_confineRect, point)) {
        _beginPoint = point;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_confineRect, point)) {
        _endPoint = point;
        [self setNeedsDisplay];
    }
}

- (CGRect)selectedRect {
    return _selectedRect;
}

- (void)setConfineRect:(CGRect)rect {
    _confineRect = rect;
    _beginPoint = rect.origin;
}




@end
