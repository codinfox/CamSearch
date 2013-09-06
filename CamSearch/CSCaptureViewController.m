//
//  CSCaptureViewController.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "CSCaptureViewController.h"
#import "ImageSelectView.h"

@interface CSCaptureViewController ()

@end

@implementation CSCaptureViewController {
    ImageSelectView * isv;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imageView.image = self.image;
    self.doneButton.enabled = NO;
    
    isv = [[ImageSelectView alloc] initWithFrame:CGRectMake(0, 44, 320, 480)];
    [self.view addSubview:isv];
    isv.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.imageView = nil;
    self.editButton = nil;
    self.doneButton = nil;
    self.image = nil;
}

- (IBAction)escape {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editPressed:(id)sender {
    if (self.editButton.style != UIBarButtonItemStyleDone) {
        self.editButton.style = UIBarButtonItemStyleDone;
        isv.userInteractionEnabled = YES;
        return;
    }
    self.editButton.style = UIBarButtonItemStyleBordered;
    isv.userInteractionEnabled = NO;
    [self refreshDoneButtonStatus];
    
}

- (void)refreshDoneButtonStatus {
    if (isv.selectedRect.size.height != 0 && isv.selectedRect.size.width != 0) {
        self.doneButton.enabled = YES;
        return;
    }
    self.doneButton.enabled = NO;
}

- (IBAction)donePressed:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil] show];
}
@end
