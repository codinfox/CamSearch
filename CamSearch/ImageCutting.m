//
//  ImageCutting.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-6.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "ImageCutting.h"
#import "NSData+Base64.h"

@implementation ImageCutting {
    UIImageView * _imageView;
}

+ (NSString *)convertImageToBase64:(UIImage *)image {
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString * base64 = [imageData base64EncodingWithLineLength:0];
    return base64;
}

- (id)initWithImageView:(UIImageView *)imageView {
    if (self = [super init]) {
        _imageView = imageView;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGFloat)scaleRatio {
    CGFloat ratio = 0;
    
    CGRect frame = _imageView.frame;
    CGSize size = _imageView.image.size;
    
    if (size.width / size.height > frame.size.width / frame.size.height) {
        ratio = frame.size.width / size.width;
    } else {
        ratio = frame.size.height / size.height;
    }
    
    NSLog(@"ratio: %f", ratio);
    
    return ratio;
}

- (CGRect)scaleFrame {
    CGFloat ratio = [self scaleRatio];
    CGSize size = _imageView.image.size;
    size.height *= ratio;
    size.width *= ratio;
    CGPoint origin = CGPointMake(_imageView.frame.size.width/2 - size.width/2, _imageView.frame.size.height/2 - size.height/2);
    CGRect frame;
    frame.origin = origin;
    frame.size = size;
    return frame;
}

- (UIImage *)cropImageWithRect: (CGRect)rect {
    CGRect frame = [self scaleFrame];
    CGFloat ratio = [self scaleRatio];
    
    rect.origin.x -= frame.origin.x;
    rect.origin.y -= frame.origin.y;
    
    rect.origin.x /= ratio;
    rect.origin.y /= ratio;
    rect.size.height /= ratio;
    rect.size.width /= ratio;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(_imageView.image.CGImage, rect);
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

@end
