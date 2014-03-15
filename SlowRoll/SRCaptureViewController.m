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
#import "UIFont+SRFonts.h"
#import "SRDeliveryOptionsViewController.h"

static NSString *photosLeftKeypath = @"cameraRoll.unusedPhotos";
static NSString *rollStateKeypath = @"cameraRoll.state";

@interface SRCaptureViewController ()

@property (retain) SRCaptureSessionManager *captureManager;
@property (nonatomic, strong) SRCameraRoll *cameraRoll;

@property (nonatomic, strong) UIView *captureViewFrame;
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
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    static NSInteger captureButtonHeight = 50;
    static NSInteger bottomPadding = 15;
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
    captureButton.layer.cornerRadius = captureButton.frame.size.height/2;
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
        self.captureViewFrame = [[UIView alloc] initWithFrame:self.view.bounds];
        self.captureViewFrame.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:self.captureViewFrame];
        [self.view sendSubviewToBack:self.captureViewFrame];
        
        self.captureManager = [SRCaptureSessionManager new];
        CGRect layerRect = [[[self view] layer] bounds];
        [self.captureManager addVideoInput];
        [self.captureManager addStillImageOutput];
        [self.captureManager.previewLayer setBounds:layerRect];
        [self.captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        [self.captureViewFrame.layer addSublayer:self.captureManager.previewLayer];
    } else {
        [self setupFinishedView];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showMoreOptions)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.captureManager.captureSession startRunning];
    [self addObserver:self forKeyPath:photosLeftKeypath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:rollStateKeypath options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.captureManager.captureSession stopRunning];
    [self removeObserver:self forKeyPath:photosLeftKeypath];
    [self removeObserver:self forKeyPath:rollStateKeypath];
}

#pragma mark - custom view methods
- (void)updateRollStatsLabel
{
    static NSInteger horizontalPadding = 10;
    static NSInteger bottomPadding = 15;
    
    self.rollStatsLabel.text = [NSString stringWithFormat:@"Photos Left: %@\nRoll Size: %@\nPrint Type: %@", [self.cameraRoll.unusedPhotos stringValue], [self.cameraRoll.maxPhotos stringValue], self.cameraRoll.printType];
    [self.rollStatsLabel sizeToFit];
    self.rollStatsLabel.frame = CGRectMake(self.view.frame.size.width-self.rollStatsLabel.frame.size.width-horizontalPadding,
                                      self.view.frame.size.height-self.rollStatsLabel.frame.size.height-bottomPadding,
                                      self.rollStatsLabel.frame.size.width,
                                      self.rollStatsLabel.frame.size.height);
}

- (void)setupFinishedView
{
    NSInteger buttonWidth = self.view.frame.size.width;
    static NSInteger buttonHeight = 50;
    UIButton *purchaseOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - buttonWidth/2,
                                                                              self.view.frame.size.height/2 - buttonHeight/2,
                                                                              buttonWidth,
                                                                              buttonHeight)];
    [purchaseOrderButton addTarget:self action:@selector(presentPurchaseOrderStack) forControlEvents:UIControlEventTouchUpInside];
    [purchaseOrderButton setBackgroundColor:[UIColor SRGreen]];
    [purchaseOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchaseOrderButton setTitle:@"Order Now!" forState:UIControlStateNormal];
    purchaseOrderButton.titleLabel.font = [UIFont futuraFontWithSize:26];
    
    [self.view addSubview:purchaseOrderButton];
    
    self.captureButton.enabled = NO;
    
    UIFont *completeLabelFont = [UIFont futuraFontWithSize:22];
    UILabel *completeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, purchaseOrderButton.frame.origin.y-60, self.view.frame.size.width, completeLabelFont.lineHeight)];
    completeLabel.textColor = [UIColor whiteColor];
    completeLabel.font = completeLabelFont;
    completeLabel.textAlignment = NSTextAlignmentCenter;
    completeLabel.text = NSLocalizedString(@"roll finished", @"label on capture vc view to warn user that roll is already finished");
    [self.view addSubview:completeLabel];
}

- (void)transitionToFinishedView
{
    [UIView animateWithDuration:.5 animations:^{
        self.captureViewFrame.alpha = 0;
    } completion:^(BOOL finished) {
        [self.captureViewFrame removeFromSuperview];
        self.captureViewFrame = nil;
        self.captureManager = nil;
        [UIView animateWithDuration:.5 animations:^{
            [self setupFinishedView];
        }];
    }];
}

- (void)showMoreOptions
{
    // placeholder for more options vc
    UIViewController *viewController = [UIViewController new];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(dismissModal)];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController] animated:YES completion:nil];
}

- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentPurchaseOrderStack
{
    SRDeliveryOptionsViewController *deliveryOptionsVC = [SRDeliveryOptionsViewController new];
    deliveryOptionsVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModal)];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:deliveryOptionsVC] animated:YES completion:nil];
}

#pragma mark - camera
- (void)captureStillImage
{
    self.cameraRoll.unusedPhotos = @([self.cameraRoll.unusedPhotos integerValue]-1);
    [self animateFlash];
    if ([self.cameraRoll.unusedPhotos integerValue] <= 0) {
        self.cameraRoll.state = CameraRollAPIStateFinished;
    }
}

- (void)animateFlash
{
    UIView *flashView = [[UIView alloc] initWithFrame:self.captureViewFrame.bounds];
    flashView.backgroundColor = [UIColor whiteColor];
    [self.captureViewFrame addSubview:flashView];
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        flashView.alpha = 0;
    } completion:^(BOOL finished) {
        [flashView removeFromSuperview];
    }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self) {
        if ([keyPath isEqualToString:photosLeftKeypath]) {
            [self updateRollStatsLabel];
        } else if ([keyPath isEqualToString:rollStateKeypath]) {
            if ([self.cameraRoll.state isEqualToString:CameraRollAPIStateFinished]) {
                [self transitionToFinishedView];
            }
        }
    }
}

@end
