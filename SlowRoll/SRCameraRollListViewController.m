//
//  SRCameraRollListViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 12/26/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRCameraRollListViewController.h"
#import "SRAppDelegate.h"
#import "SRCameraRoll.h"
#import "SRCreateRollViewController.h"

static NSString *BasicCellIdentifier = @"basicCellID";

@interface SRCameraRollListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation SRCameraRollListViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BasicCellIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    NSManagedObjectContext *MOC = [(SRAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([SRCameraRoll class])];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updated_at" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:MOC
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSError *error;
    //BOOL success = [self.fetchedResultsController performFetch:&error];
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCreateCameraRoll)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate and data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.fetchedResultsController.sections.count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier];
    
    return cell;
}

#pragma mark - NSFetchedResultsController delegate methods
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Create new roll
- (void)showCreateCameraRoll
{
    SRCreateRollViewController *createVC = [SRCreateRollViewController new];
    createVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModal)];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createVC];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)dismissModal
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
