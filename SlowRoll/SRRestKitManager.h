//
//  SRRestKitManager.h
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RKEntityMapping;

@interface SRRestKitManager : NSObject

+ (void)initializeRestKit;

+ (RKEntityMapping *)mappingForSRCameraRoll;
+ (RKEntityMapping *)mappingForSRRollParticipant;
+ (RKEntityMapping *)mappingForSRPurchaseOrder;

@end
