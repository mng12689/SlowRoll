//
//  SRRollParticipant.m
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRRollParticipant.h"
#import "SRCameraRoll.h"


@implementation SRRollParticipant

@dynamic displayName;
@dynamic maxPhotos;
@dynamic participantID;
@dynamic rollID;
@dynamic unusedPhotos;
@dynamic userID;
@dynamic cameraRoll;

+ (NSDictionary *)JSONRepresentation
{
    return @{@"participant_id" : @"participantID",
             @"display_name" : @"displayName",
             @"max_photos" : @"maxPhotos",
             @"unused_photos" : @"unusedPhotos",
             @"user_id" : @"user_id",
             @"roll_id" : @"rollID"};
}

@end
