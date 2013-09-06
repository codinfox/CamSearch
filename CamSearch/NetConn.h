//
//  NetConn.h
//  CamSearch
//
//  Created by Zhihao Li on 13-9-6.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetConn : NSObject

- (id)initWithImage: (UIImage *)image;
- (void)send;
- (NSArray *)retrieve;

@end
