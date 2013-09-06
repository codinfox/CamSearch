//
//  ImageSelectView.h
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCaptureViewController;

@interface ImageSelectView : UIView

- (CGRect)selectedRect;
- (void)setConfineRect: (CGRect)rect;

@end
