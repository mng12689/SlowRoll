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
    // create object manager
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseURLString]];
    
    NSLog(@"%@",[RKObjectManager sharedManager].baseURL);
    
    // integrate RestKit with Core Data
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error;
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"SlowRoll.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }
    [managedObjectStore createManagedObjectContexts];
    manager.managedObjectStore = managedObjectStore;
    
    // add request descriptors for requests
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForSRCameraRoll]];
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForSRRollParticipant]];
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForSRPurchaseOrder]];
    
    // add response descriptors for requests
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForSRCameraRoll]];
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForSRRollParticipant]];
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForSRPurchaseOrder]];
    
    // add routes for requests
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRCameraRoll]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRPurchaseOrder]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRRollPartipicant]];
}

#pragma mark - mappings
+ (RKEntityMapping *)mappingForSRCameraRoll
{
    RKManagedObjectStore *managedObjectStore = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"SRCameraRoll" inManagedObjectStore:managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{@"roll_id" : @"rollID",
                                                  @"max_photos" : @"maxPhotos",
                                                  @"unused_photos" : @"unusedPhotos"}];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"participants" mapping:[SRRestKitManager mappingForSRRollParticipant]];
    return mapping;
}

+ (RKEntityMapping *)mappingForSRRollParticipant
{
    RKManagedObjectStore *managedObjectStore = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"SRRollParticipant" inManagedObjectStore:managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{@"participant_id" : @"participantID",
                                                  @"display_name" : @"displayName",
                                                  @"max_photos" : @"maxPhotos",
                                                  @"unused_photos" : @"unusedPhotos",
                                                  @"user_id" : @"user_id"}];
    
    NSEntityDescription *rollParticipantEntity = [NSEntityDescription entityForName:@"SRRollParticipant" inManagedObjectContext:[[[RKObjectManager sharedManager] managedObjectStore] mainQueueManagedObjectContext]];
    NSRelationshipDescription *cameraRollRelationship = [rollParticipantEntity relationshipsByName][@"cameraRoll"];
    RKConnectionDescription *connection = [[RKConnectionDescription alloc] initWithRelationship:cameraRollRelationship attributes:@{@"rollID": @"rollID"}];
    [mapping addConnection:connection];
    return mapping;
}

+ (RKEntityMapping *)mappingForSRPurchaseOrder
{
    RKManagedObjectStore *managedObjectStore = [RKObjectManager sharedManager].managedObjectStore;
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"SRPurchaseOrder" inManagedObjectStore:managedObjectStore];
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

#pragma mark - request descriptors
+ (NSArray *)requestDescriptorsForSRCameraRoll
{
    RKRequestDescriptor *postDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SRRestKitManager mappingForSRCameraRoll]
                                                                                objectClass:[NSObject class]
                                                                                rootKeyPath:@"cameraRoll"
                                                                                     method:RKRequestMethodPOST];
    RKRequestDescriptor *updateDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SRRestKitManager mappingForSRCameraRoll]
                                                                                  objectClass:[NSObject class]
                                                                                  rootKeyPath:@"cameraRoll"
                                                                                       method:RKRequestMethodPUT];
    return @[postDescriptor, updateDescriptor];
}

+ (NSArray *)requestDescriptorsForSRRollParticipant
{
    RKRequestDescriptor *postDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SRRestKitManager mappingForSRRollParticipant]
                                                                                objectClass:[NSObject class]
                                                                                rootKeyPath:@"rollParticipant"
                                                                                     method:RKRequestMethodPOST];
    RKRequestDescriptor *updateDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SRRestKitManager mappingForSRRollParticipant]
                                                                                  objectClass:[NSObject class]
                                                                                  rootKeyPath:@"rollParticipant"
                                                                                       method:RKRequestMethodPUT];
    return @[postDescriptor, updateDescriptor];
}

+ (NSArray *)requestDescriptorsForSRPurchaseOrder
{
    RKRequestDescriptor *postDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SRRestKitManager mappingForSRPurchaseOrder]
                                                                                objectClass:[NSObject class]
                                                                                rootKeyPath:@"purchaseOrder"
                                                                                     method:RKRequestMethodPOST];
    return @[postDescriptor];
}

#pragma mark - response descriptors
+ (NSArray *)responseDescriptorsForSRCameraRoll
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SRRestKitManager mappingForSRCameraRoll]
                                                                                    method:RKRequestMethodAny
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:statusCodes];
    return @[descriptor];
}

+ (NSArray *)responseDescriptorsForSRRollParticipant
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SRRestKitManager mappingForSRRollParticipant]
                                                                                    method:RKRequestMethodAny
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:statusCodes];
    return @[descriptor];
}

+ (NSArray *)responseDescriptorsForSRPurchaseOrder
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SRRestKitManager mappingForSRPurchaseOrder]
                                                                                    method:RKRequestMethodAny
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:statusCodes];
    return @[descriptor];
}

@end
