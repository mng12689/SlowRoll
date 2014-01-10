//
//  SRCaptureViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 6/14/13.
//  Copyright (c) 2013 Michael Ng. All rights reserved.
//

#import "SRCaptureViewController.h"
#import "SRCaptureSessionManager.h"
#import <AVFoundation/AVFoundation.h>

@interface SRCaptureViewController ()

@property (retain) SRCaptureSessionManager *captureManager;
//@property (nonatomic,strong) SRRoll *roll;

@end

@implementation SRCaptureViewController

- (id)initWithRoll
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
	self.captureManager = [SRCaptureSessionManager new];
    CGRect layerRect = [[[self view] layer] bounds];
    [self.captureManager addVideoInput];
    [self.captureManager addStillImageOutput];
	[self.captureManager.previewLayer setBounds:layerRect];
	[self.captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
	[self.view.layer addSublayer:self.captureManager.previewLayer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 10, 100, 100);
    [button setTitle:@"Hello" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    takePhotoButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    takePhotoButton.bounds = CGRectMake(0, 0, 50, 50);
    takePhotoButton.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-(button.bounds.size.height/2));
    [takePhotoButton setTitle:@"Take" forState:UIControlStateNormal];
    [takePhotoButton addTarget:self action:@selector(captureStillImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoButton];
    
    UILabel *rollCount = [UILabel new];
    rollCount.backgroundColor = [UIColor clearColor];
    rollCount.text = @"32";
    [rollCount sizeToFit];
    rollCount.center = CGPointMake(self.view.bounds.size.width-10, self.view.bounds.size.height-(button.bounds.size.height/2));
    [self.view addSubview:rollCount];
    
	[self.captureManager.captureSession startRunning];
    self.view.backgroundColor = [UIColor redColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.captureManager.captureSession startRunning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.captureManager.captureSession stopRunning];
}

- (void)captureStillImage
{
    
}

@end
