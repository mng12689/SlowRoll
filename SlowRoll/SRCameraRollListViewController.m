//
//  SRCameraRollListViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 12/26/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

@interface SRCameraRollListFetchedResultsController : NSFetchedResultsController
@end

@implementation SRCameraRollListFetchedResultsController

- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return [sectionName capitalizedString];
}

@end

#import "SRCameraRollListViewController.h"
#import "SRAppDelegate.h"
#import "SRCameraRoll.h"
#import "SRCreateRollViewController.h"
#import "SRCaptureViewController.h"
#import "SRSubtitleCell.h"
#import "UIColor+SRColors.h"

static NSString *BasicCellIdentifier = @"basicCellID";

@interface SRCameraRollListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SRCameraRollListFetchedResultsController *fetchedResultsController;

@end

@implementation SRCameraRollListViewController

#pragma mark - lifecycle

- (id)init
{
    if (self = [super init]) {
        self.title = NSLocalizedString(@"slowroll", @"title fo camera roll list view controller");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.allowsMultipleSelection = NO;
    [tableView registerClass:[SRSubtitleCell class] forCellReuseIdentifier:BasicCellIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    NSManagedObjectContext *MOC = [(SRAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([SRCameraRoll class])];
    NSSortDescriptor *stateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:SRCameraRollAttributes.stateSortPrecedence ascending:YES];
    
    // update this sort descriptor to use updatedAt property instead of name once we have accurate updated at info for the camera roll
    NSSortDescriptor *lastPhotoTakenSortDescriptor = [[NSSortDescriptor alloc] initWithKey:SRCameraRollAttributes.name ascending:NO];
    [fetchRequest setSortDescriptors:@[stateSortDescriptor,lastPhotoTakenSortDescriptor]];
    self.fetchedResultsController = [[SRCameraRollListFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:MOC
                                                                          sectionNameKeyPath:SRCameraRollAttributes.state
                                                                                   cacheName:nil];
    [self.fetchedResultsController performFetch:nil];
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCreateCameraRoll)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
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
    SRCameraRoll *cameraRoll = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text = cameraRoll.name;
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    // dummy data until we have an API
    cell.detailTextLabel.text = [NSString stringWithFormat:@"You have %i pictures left to take\n%@ took a picture 37 minutes ago", 1, @"Rob"];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];

    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    backgroundView.backgroundColor = [UIColor SRGreen];
    cell.selectedBackgroundView = backgroundView;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.fetchedResultsController.sectionIndexTitles[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRCameraRoll *cameraRoll = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    SRCaptureViewController *captureVC = [[SRCaptureViewController alloc] initWithCameraRoll:cameraRoll];
    [self.navigationController pushViewController:captureVC animated:YES];
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
