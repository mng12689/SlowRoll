//
//  SRPurchaseOrder.h
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SRCameraRoll;

@interface SRPurchaseOrder : NSManagedObject

@property (nonatomic, retain) NSString * printType;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) SRCameraRoll *cameraRoll;

@end
