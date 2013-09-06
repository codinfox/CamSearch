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
    
    CGContextSetFillColorWithColor( _context, [UIColor clearColor].CGColor );
    CGContextClearRect(_context, rect);

}

#pragma mark - Gestures
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    _beginPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    _endPoint = [touch locationInView:self];
    if (_endPoint.x < 0 || _endPoint.x > 320 || _endPoint.y < 0 || _endPoint.y > 480) {
        return;
    }
//    NSLog(@"x=%f, y=%f\n",_endPoint.x, _endPoint.y);
    [self setNeedsDisplay];
}

- (CGRect)selectedRect {
    return _selectedRect;
}


@end
