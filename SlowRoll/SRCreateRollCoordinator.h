//
//  SRCreateRollCoordinator.h
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRCameraRoll;

@interface SRCreateRollCoordinator : NSObject

@property (nonatomic, strong, readonly) SRCameraRoll *cameraRollDraft;

- (void)createCameraRoll:(NSError **)error;

@end
