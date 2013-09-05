//
//  CSCaptureViewController.h
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSCaptureViewController : UIViewController

@property (nonatomic, strong) UIImage * image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)escape;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
- (IBAction)editPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
