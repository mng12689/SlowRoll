//
//  SRCameraRoll.h
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SRNetworkingProtocol.h"

@interface SRCameraRoll : NSManagedObject <SRNetworkingProtocol>

@property (nonatomic, retain) NSNumber * maxPhotos;
@property (nonatomic, retain) NSNumber * rollID;
@property (nonatomic, retain) NSNumber * unusedPhotos;
@property (nonatomic, retain) NSSet *participants;
@property (nonatomic, retain) NSManagedObject *purchaseOrders;
@end

@interface SRCameraRoll (CoreDataGeneratedAccessors)

- (void)addParticipantsObject:(NSManagedObject *)value;
- (void)removeParticipantsObject:(NSManagedObject *)value;
- (void)addParticipants:(NSSet *)values;
- (void)removeParticipants:(NSSet *)values;

@end
