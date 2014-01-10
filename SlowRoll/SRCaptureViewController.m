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
#import "SRCameraRoll.h"
#import "UIColor+SRColors.h"
#import "UIImage+SRColor.h"

static NSString *photosLeftKeypath = @"cameraRoll.unusedPhotos";

@interface SRCaptureViewController ()

@property (retain) SRCaptureSessionManager *captureManager;
@property (nonatomic, strong) SRCameraRoll *cameraRoll;

@property (nonatomic, strong) UIButton *captureButton;
@property (nonatomic, strong) UILabel *rollStatsLabel;

@end

@implementation SRCaptureViewController

- (id)initWithCameraRoll:(SRCameraRoll *)cameraRoll
{
    if (self = [super init]) {
        _cameraRoll = cameraRoll;
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor grayColor];
    
    NSInteger captureButtonHeight = 50;
    NSInteger bottomPadding = 15;
    UIButton *captureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [captureButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]] forState:UIControlStateNormal];
    [captureButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:.2]] forState:UIControlStateDisabled];
    captureButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    captureButton.frame = CGRectMake(self.view.frame.size.width/2 - captureButtonHeight/2,
                                      self.view.frame.size.height-captureButtonHeight-bottomPadding,
                                      captureButtonHeight,
                                      captureButtonHeight);
    captureButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    captureButton.layer.borderWidth = 1;
    captureButton.layer.cornerRadius = captureButtonHeight/2;
    captureButton.layer.masksToBounds = YES;
    [captureButton addTarget:self action:@selector(captureStillImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captureButton];
    self.captureButton = captureButton;
    
    UILabel *rollStatsLabel = [UILabel new];
    rollStatsLabel.font = [UIFont systemFontOfSize:11];
    rollStatsLabel.numberOfLines = 0;
    rollStatsLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:rollStatsLabel];
    self.rollStatsLabel = rollStatsLabel;
    
    CameraRollStateType rollState = [SRCameraRoll cameraRollStateTypeForAPIState:self.cameraRoll.state];
    if (rollState == CameraRollStateTypeActive) {
        self.captureManager = [SRCaptureSessionManager new];
        CGRect layerRect = [[[self view] layer] bounds];
        [self.captureManager addVideoInput];
        [self.captureManager addStillImageOutput];
        [self.captureManager.previewLayer setBounds:layerRect];
        [self.captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        [self.view.layer addSublayer:self.captureManager.previewLayer];
        
        [self.captureManager.captureSession startRunning];
    } else {
        [self setupFinishedView];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showMoreOptions)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.captureManager.captureSession startRunning];
    [self addObserver:self forKeyPath:photosLeftKeypath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.captureManager.captureSession stopRunning];
    [self removeObserver:self forKeyPath:photosLeftKeypath];
}

#pragma mark - custom view methods
- (void)updateRollStatsLabel
{
    NSInteger horizontalPadding = 10;
    NSInteger bottomPadding = 15;
    
    self.rollStatsLabel.text = [NSString stringWithFormat:@"Photos Left: %@\nRoll Size: %@\nPrint Type: %@", [self.cameraRoll.unusedPhotos stringValue], [self.cameraRoll.maxPhotos stringValue], self.cameraRoll.printType];
    [self.rollStatsLabel sizeToFit];
    self.rollStatsLabel.frame = CGRectMake(self.view.frame.size.width-self.rollStatsLabel.frame.size.width-horizontalPadding,
                                      self.view.frame.size.height-self.rollStatsLabel.frame.size.height-bottomPadding,
                                      self.rollStatsLabel.frame.size.width,
                                      self.rollStatsLabel.frame.size.height);
}

- (void)setupFinishedView
{
    UIButton *purchaseOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [purchaseOrderButton setBackgroundColor:[UIColor SRGreen]];
    [purchaseOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchaseOrderButton setTitle:@"Order Now!" forState:UIControlStateNormal];
    purchaseOrderButton.layer.cornerRadius = 4;
    
    NSInteger buttonWidth = self.view.frame.size.width/2;
    NSInteger buttonHeight = 50;
    purchaseOrderButton.frame = CGRectMake(self.view.frame.size.width/2 - buttonWidth/2,
                                           self.view.frame.size.height/2 - buttonHeight/2,
                                           buttonWidth,
                                           buttonHeight);
    [self.view addSubview:purchaseOrderButton];
    
    self.captureButton.enabled = NO;
}

- (void)showMoreOptions
{
    UIViewController *viewController = [UIViewController new];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(dismissMoreOptions)];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController] animated:YES completion:nil];
}

- (void)dismissMoreOptions
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - camera
- (void)captureStillImage
{
    self.cameraRoll.unusedPhotos = @([self.cameraRoll.unusedPhotos integerValue]-1);
    [self animateFlash];
}

- (void)animateFlash
{
    CALayer *flashLayer = [CALayer layer];
    flashLayer.frame = self.captureManager.previewLayer.frame;
    flashLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [self.captureManager.previewLayer.superlayer addSublayer:flashLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    [animation setDuration:.5];
    animation.toValue = @0;
    animation.fromValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [flashLayer addAnimation:animation forKey:@"alpha"];
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self) {
        if ([keyPath isEqualToString:photosLeftKeypath]) {
            [self updateRollStatsLabel];
        }
    }
}

@end
