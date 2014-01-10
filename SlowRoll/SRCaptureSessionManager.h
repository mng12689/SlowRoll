//
//  SRCaptureSessionManager.h
//  SlowRoll
//
//  Created by Michael Ng on 6/14/13.
//  Copyright (c) 2013 Michael Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVCaptureSession,AVCaptureVideoPreviewLayer,AVCaptureStillImageOutput;

@interface SRCaptureSessionManager : NSObject

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;

- (void)addVideoInput;
- (void)addStillImageOutput;
- (void)captureStillImageWithCompletionHandler:(void(^)(NSData *imageData))completionHandler;

@end
