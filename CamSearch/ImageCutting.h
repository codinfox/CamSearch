//
//  ImageCutting.h
//  CamSearch
//
//  Created by Zhihao Li on 13-9-6.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCutting : NSObject

- (id)initWithImageView: (UIImageView *)imageView;

+ (NSString *)convertImageToBase64: (UIImage *)image;

- (CGFloat)scaleRatio;
- (CGRect)scaleFrame;
- (UIImage *)cropImageWithRect: (CGRect)rect;

@end
