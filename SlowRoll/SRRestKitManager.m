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
}

@end
