//
//  SRRestKitManager.m
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRRestKitManager.h"
#import <RestKit/RestKit.h>
#import "SRAppDelegate.h"

static NSString *baseURLString = @"localhost:9000/";

@implementation SRRestKitManager

+ (void)initializeRestKit
{
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseURLString]];
    NSLog(@"%@",[RKObjectManager sharedManager].baseURL);
    
    NSManagedObjectModel *mainMOM = [((SRAppDelegate *)[[UIApplication sharedApplication] delegate]) managedObjectModel];
    RKManagedObjectStore *store = [[RKManagedObjectStore alloc] initWithManagedObjectModel:mainMOM];
    manager.managedObjectStore = store;
    
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRCameraRoll]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRPurchaseOrder]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRRollPartipicant]];
}

#pragma mark - mappings
+ (RKEntityMapping *)mappingForSRCameraRoll
{
    RKEntityMapping *mapping = [RKEntityMapping mappingForClass:[NSObject class]];
    [mapping addAttributeMappingsFromDictionary:@{@"roll_id" : @"rollID",
                                                  @"max_photos" : @"maxPhotos",
                                                  @"unused_photos" : @"unusedPhotos"}];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"participants" mapping:[SRRestKitManager mappingForSRRollParticipant]];
    return mapping;
}

+ (RKEntityMapping *)mappingForSRRollParticipant
{
    RKEntityMapping *mapping = [RKEntityMapping mappingForClass:[NSObject class]];
    [mapping addAttributeMappingsFromDictionary:@{@"participant_id" : @"participantID",
                                                  @"display_name" : @"displayName",
                                                  @"max_photos" : @"maxPhotos",
                                                  @"unused_photos" : @"unusedPhotos",
                                                  @"user_id" : @"user_id"}];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"cameraRoll" mapping:[SRRestKitManager mappingForSRCameraRoll]];
    return mapping;
}

+ (RKEntityMapping *)mappingForSRPurchaseOrder
{
    RKEntityMapping *mapping = [RKEntityMapping mappingForClass:[NSObject class]];
    [mapping addAttributeMappingsFromDictionary:@{@"print_type" : @"printType",
                                                  @"state" : @"state",
                                                  @"user_id" : @"userID"}];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"cameraRoll" mapping:[SRRestKitManager mappingForSRCameraRoll]];
    return mapping;
}

#pragma mark - routes
+ (NSArray *)routesForSRCameraRoll
{
    RKRoute *getRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"/cameraRolls/:rollID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"cameraRolls" method:RKRequestMethodPOST];
    RKRoute *updateRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"cameraRolls/:rollID" method:RKRequestMethodPUT];
    return @[getRoute,postRoute,updateRoute];
}

+ (NSArray *)routesForSRRollPartipicant
{
    RKRoute *getRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"/rollParticipants/:participantID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"rollParticipants" method:RKRequestMethodPOST];
    RKRoute *updateRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"rollParticipants/:participantID" method:RKRequestMethodPUT];
    return @[getRoute,postRoute,updateRoute];}

+ (NSArray *)routesForSRPurchaseOrder
{
    RKRoute *getRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"/purchaseOrders/:orderID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[NSObject class] pathPattern:@"purchaseOrders" method:RKRequestMethodPOST];
    return @[getRoute,postRoute];
}

@end
