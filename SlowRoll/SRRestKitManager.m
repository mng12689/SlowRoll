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
#import "SRNetworkingProtocol.h"
#import "SRCameraRoll.h"
#import "SRRollParticipant.h"
#import "SRPurchaseOrder.h"

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
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForClass:[SRCameraRoll class]
                                                                             rootKeyPath:@"cameraRoll"
                                                                             HTTPMethods:@[@(RKRequestMethodPOST),@(RKRequestMethodPUT)]]];
    
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForClass:[SRRollParticipant class]
                                                                             rootKeyPath:@"rollParticipant"
                                                                             HTTPMethods:@[@(RKRequestMethodPUT)]]];
    
    [manager addRequestDescriptorsFromArray:[SRRestKitManager requestDescriptorsForClass:[SRPurchaseOrder class]
                                                                             rootKeyPath:@"purchaseOrder"
                                                                             HTTPMethods:@[@(RKRequestMethodPOST)]]];
    // add response descriptors for requests
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForClass:[SRCameraRoll class]]];
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForClass:[SRRollParticipant class]]];
    [manager addResponseDescriptorsFromArray:[SRRestKitManager responseDescriptorsForClass:[SRPurchaseOrder class]]];
    
    // add routes for requests
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRCameraRoll]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRPurchaseOrder]];
    [manager.router.routeSet addRoutes:[SRRestKitManager routesForSRRollPartipicant]];
}

#pragma mark - mappings
+ (RKObjectMapping *)responseMappingForClass:(Class)class
{
    RKObjectMapping *mapping;
    if ([class isSubclassOfClass:[NSManagedObject class]]) {
        RKManagedObjectStore *managedObjectStore = [RKObjectManager sharedManager].managedObjectStore;
        mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass(class) inManagedObjectStore:managedObjectStore];
    } else {
        mapping = [[RKObjectMapping alloc] initWithClass:class];
    }
    
    NSDictionary *JSONRepresentation;
    if ([class conformsToProtocol:nil]) {
        JSONRepresentation = [class JSONRepresentation];
    }
    [mapping addAttributeMappingsFromDictionary:JSONRepresentation];
    return mapping;
}

+ (RKObjectMapping *)requestMappingForClass:(Class)class
{
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    NSDictionary *JSONRepresentation;
    if ([class conformsToProtocol:@protocol(SRNetworkingProtocol)]) {
        JSONRepresentation = [class JSONRepresentation];
    }
    [mapping addAttributeMappingsFromArray:[JSONRepresentation allValues]];
    
    return mapping;
}

/*+ (RKEntityMapping *)mappingForSRCameraRoll
{
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"participants" mapping:[SRRestKitManager mappingForSRRollParticipant]];
    
    return mapping;
}

+ (RKEntityMapping *)mappingForSRRollParticipant
{
    
    NSEntityDescription *rollParticipantEntity = [NSEntityDescription entityForName:@"SRRollParticipant" inManagedObjectContext:[[[RKObjectManager sharedManager] managedObjectStore] mainQueueManagedObjectContext]];
    NSRelationshipDescription *cameraRollRelationship = [rollParticipantEntity relationshipsByName][@"cameraRoll"];
    RKConnectionDescription *connection = [[RKConnectionDescription alloc] initWithRelationship:cameraRollRelationship attributes:@{@"rollID": @"rollID"}];
    [mapping addConnection:connection];
    return mapping;
}*/

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
    RKRoute *getRoute = [RKRoute routeWithClass:[SRCameraRoll class] pathPattern:@"/cameraRolls/:rollID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[SRCameraRoll class] pathPattern:@"cameraRolls" method:RKRequestMethodPOST];
    RKRoute *updateRoute = [RKRoute routeWithClass:[SRCameraRoll class] pathPattern:@"cameraRolls/:rollID" method:RKRequestMethodPUT];
    return @[getRoute,postRoute,updateRoute];
}

+ (NSArray *)routesForSRRollPartipicant
{
    RKRoute *getRoute = [RKRoute routeWithClass:[SRRollParticipant class] pathPattern:@"/rollParticipants/:participantID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[SRRollParticipant class] pathPattern:@"rollParticipants" method:RKRequestMethodPOST];
    RKRoute *updateRoute = [RKRoute routeWithClass:[SRRollParticipant class] pathPattern:@"rollParticipants/:participantID" method:RKRequestMethodPUT];
    return @[getRoute,postRoute,updateRoute];}

+ (NSArray *)routesForSRPurchaseOrder
{
    RKRoute *getRoute = [RKRoute routeWithClass:[SRPurchaseOrder class] pathPattern:@"/purchaseOrders/:orderID" method:RKRequestMethodGET];
    RKRoute *postRoute = [RKRoute routeWithClass:[SRPurchaseOrder class] pathPattern:@"purchaseOrders" method:RKRequestMethodPOST];
    return @[getRoute,postRoute];
}

#pragma mark - request descriptors
+ (NSArray *)requestDescriptorsForClass:(Class)class rootKeyPath:(NSString *)rootKeyPath HTTPMethods:(NSArray *)requestMethods
{
    NSMutableArray *descriptors = [NSMutableArray array];
    RKObjectMapping *mapping = [SRRestKitManager requestMappingForClass:[class class]];
    for (NSNumber *HTTPMethodNum in requestMethods) {
        RKRequestMethod requestMethod = (RKRequestMethod)[HTTPMethodNum integerValue];
        RKRequestDescriptor *descriptor = [RKRequestDescriptor requestDescriptorWithMapping:mapping
                                                                                objectClass:[class class]
                                                                                rootKeyPath:rootKeyPath
                                                                                     method:requestMethod];
        [descriptors addObject:descriptor];
        
    }
    return descriptors;
}

#pragma mark - response descriptors
+ (NSArray *)responseDescriptorsForClass:(Class)class
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *mapping = [SRRestKitManager responseMappingForClass:class];
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                    method:RKRequestMethodAny
                                                                               pathPattern:nil
                                                                                   keyPath:nil
                                                                               statusCodes:statusCodes];
    return @[descriptor];
}

@end
