//
//  SRAppDelegate.h
//  SlowRoll
//
//  Created by Michael Ng on 12/21/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
