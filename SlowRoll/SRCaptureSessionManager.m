//
//  SRCaptureSessionManager.m
//  SlowRoll
//
//  Created by Michael Ng on 6/14/13.
//  Copyright (c) 2013 Michael Ng. All rights reserved.
//

#import "SRCaptureSessionManager.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@implementation SRCaptureSessionManager

- (id)init
{
	if ((self = [super init])) {
		self.captureSession = [AVCaptureSession new];
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
	}
	return self;
}

- (void)dealloc {
    
	[self.captureSession stopRunning];
    self.captureSession = nil;
	self.previewLayer = nil;
}

- (void)addVideoInput
{
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([self.captureSession canAddInput:videoIn])
				[self.captureSession addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}

- (void)addStillImageOutput
{
    self.stillImageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    self.stillImageOutput.outputSettings = outputSettings;
    [self.captureSession addOutput:self.stillImageOutput];
}

- (void)captureStillImageWithCompletionHandler:(void(^)(NSData *imageData))completionHandler
{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    if (videoConnection) {
        [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                             completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                                 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                                 completionHandler(imageData);
                                                             }];
    }
}

@end
