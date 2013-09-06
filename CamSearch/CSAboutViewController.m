//
//  CSAboutViewController.m
//  CamSearch
//
//  Created by Zhihao Li on 13-9-5.
//  Copyright (c) 2013年 Zhihao Li. All rights reserved.
//

#import "CSAboutViewController.h"

@interface CSAboutViewController ()

@end

@implementation CSAboutViewController

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
    [self configVersionLabel];
}

- (void)configVersionLabel {
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"version %@ build %@", version, build];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)escape {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
