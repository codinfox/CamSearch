//
//  NetConn.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-6.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "NetConn.h"
#import "ImageCutting.h"

@implementation NetConn {
    UIImage * _image;
}

- (id)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

- (void)send {
    NSString * base64 = [ImageCutting convertImageToBase64:_image];
//    NSLog(@"%@", base64);
}

- (NSArray *)retrieve {
    return nil;
}

@end
