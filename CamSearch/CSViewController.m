//
//  CSViewController.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "CSViewController.h"
#import "CSAboutViewController.h"
#import "CSCaptureViewController.h"

@interface CSViewController () <UIActionSheetDelegate>

@end

@implementation CSViewController {
    BOOL isCameraAvailable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        isCameraAvailable = NO;
    } else {
        isCameraAvailable = YES;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Access to your image from ..." delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet addButtonWithTitle:@"Photo Library"];
    NSInteger cancelIdx = 1;
    if (isCameraAvailable) {
        [actionSheet addButtonWithTitle:@"Camera"];
        cancelIdx = 2;
    }
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:cancelIdx];


    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

- (IBAction)showAbout {
    CSAboutViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
//    [UIView transitionFromView:self.view toView:vc.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop completion:nil];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 1 && isCameraAvailable) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if (actionSheet.cancelButtonIndex != buttonIndex) {
        [self showImagePickerForSourceType:sourceType];
    }
}

#pragma mark - 

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        CSCaptureViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"capture"];
        vc.image = image;
        
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:nil];

    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
