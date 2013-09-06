//
//  CSCaptureViewController.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "CSCaptureViewController.h"
#import "ImageSelectView.h"
#import "ImageCutting.h"
#import "NetConn.h"
#import "CSResultListViewController.h"

@interface CSCaptureViewController ()

@end

@implementation CSCaptureViewController {
    ImageSelectView * isv;
    ImageCutting * ic;
    UIAlertView * av;
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
    
    ic = nil;
    av = nil;
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
    if (ic == nil) {
        ic = [[ImageCutting alloc] initWithImageView:self.imageView];
        [isv setConfineRect:[ic scaleFrame]];
    }
    
    if (self.editButton.style != UIBarButtonItemStyleDone) {
        self.editButton.style = UIBarButtonItemStyleDone;
        isv.userInteractionEnabled = YES;
        self.doneButton.enabled = NO;
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
//    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil] show];
//    UIImage * image = [ic cropImageWithRect:isv.selectedRect];
    
    [self sendRequest];
    [self showWaitingView];
}

- (void)sendRequest {
    dispatch_queue_t reqQueue = dispatch_queue_create("netConn", NULL);
    dispatch_async(reqQueue, ^{
        NetConn * conn = [[NetConn alloc] initWithImage:self.image];
        [conn send];
        [conn retrieve];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestDidProcessed];
        });
    });
}

- (void)showWaitingView {
    UIActivityIndicatorView * indicator;
    if (av == nil) {
        av = [[UIAlertView alloc] initWithTitle:@"Request is being processed.\nPlease wait ..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        NSLog(@"%f", av.frame.size.width);
        [av show];
        indicator.center = CGPointMake(av.frame.size.width/2 - 15, av.frame.size.height - 60);
        [indicator startAnimating];
        [av addSubview:indicator];
        indicator = nil;
    } else {
        [av show];
    }
//    indicator.center = CGPointMake(av.frame.size.width/2, 100);
//    NSLog(@"%f", av.frame.size.width);

}

- (void)requestDidProcessed {
    [self dismissWaitingView];
    CSResultListViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"resultList"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)dismissWaitingView {
    [av dismissWithClickedButtonIndex:0 animated:YES];
}


@end
