//
//  SRCameraRoll.m
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRCameraRoll.h"


@implementation SRCameraRoll

@dynamic maxPhotos;
@dynamic name;
@dynamic rollID;
@dynamic unusedPhotos;
@dynamic participants;
@dynamic purchaseOrders;

+ (NSDictionary *)JSONRepresentation
{
    return @{@"roll_id" : @"rollID",
             @"max_photos" : @"maxPhotos",
             @"unused_photos" : @"unusedPhotos"};
}

@end
