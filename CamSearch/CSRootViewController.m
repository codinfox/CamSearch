//
//  CSRootViewController.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-9.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "CSRootViewController.h"

@interface CSRootViewController ()

@end

@implementation CSRootViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.logo.frame;
        frame.origin.y = 66;
        self.logo.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
//            vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:vc animated:NO completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.logo = nil;
}

@end
