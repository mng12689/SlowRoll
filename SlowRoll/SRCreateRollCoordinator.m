//
//  SRCreateRollCoordinator.m
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRCreateRollCoordinator.h"
#import "SRCameraRoll.h"
#import "SRAppDelegate.h"

@interface SRCreateRollCoordinator ()

@property (nonatomic, strong, readwrite) SRCameraRoll *cameraRollDraft;
@property (nonatomic, strong) NSManagedObjectContext *editableContext;

@end

@implementation SRCreateRollCoordinator

#pragma mark - lazy loaders
- (SRCameraRoll *)cameraRollDraft
{
    if (!_cameraRollDraft) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([SRCameraRoll class]) inManagedObjectContext:self.editableContext];
        _cameraRollDraft = (SRCameraRoll*)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.editableContext];
        _cameraRollDraft.name = [NSString stringWithFormat:@"Camera Roll %i", 482390];
        _cameraRollDraft.state = @"active"; //REMOVE THIS WHEN WE HAVE AN API
    }
    return _cameraRollDraft;
}

- (NSManagedObjectContext *)editableContext
{
    if (!_editableContext) {
        _editableContext = [NSManagedObjectContext new];
        _editableContext.persistentStoreCoordinator = [(SRAppDelegate *)[UIApplication sharedApplication].delegate persistentStoreCoordinator];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextHasChanged:) name:NSManagedObjectContextDidSaveNotification object:nil]; //REMOVE THIS WHEN WE HAVE AN API

    }
    return _editableContext;
}

#pragma mark - API interactions
- (void)createCameraRoll
{
    [self.editableContext save:nil];
}

//REMOVE THIS WHEN WE HAVE AN API
- (void)contextHasChanged:(NSNotification *)notification
{
    [[(SRAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
}

@end
