//
//  SRRollParticipant.h
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SRCameraRoll;

@interface SRRollParticipant : NSManagedObject

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSNumber * maxPhotos;
@property (nonatomic, retain) NSNumber * participantID;
@property (nonatomic, retain) NSNumber * rollID;
@property (nonatomic, retain) NSNumber * unusedPhotos;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) SRCameraRoll *cameraRoll;

@end
