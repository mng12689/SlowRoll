//
//  SRCreateRollViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 12/26/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRCreateRollViewController.h"
#import "SRCameraRoll.h"
#import "SRCreateRollCoordinator.h"
#import "SREditableCell.h"
#import "SRSegmentedCell.h"
#import "SRSegmentedControl.h"

typedef NS_ENUM(NSInteger, CreateSectionType) {
    CreateSectionTypeRollName,
    CreateSectionTypeRollType,
    CreateSectionTypeRollSize,
};

static NSString *EditableCellIdentifier = @"EditableCellID";
static NSString *SelectionCellIdentifier = @"SelectionCellID";

static NSInteger rollSizeSegControlTag = 43290;
static NSInteger rollTypeSegControlTag = 239520;

@interface SRCreateRollViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SRCreateRollCoordinator *createRollCoordinator;

@end

@implementation SRCreateRollViewController

#pragma mark - lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Create Roll", @"title for SRCreateRollViewController");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[SREditableCell class] forCellReuseIdentifier:EditableCellIdentifier];
    [self.tableView registerClass:[SRSegmentedCell class] forCellReuseIdentifier:SelectionCellIdentifier];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(createCameraRoll)];
}

#pragma UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateSectionType sectionType = [self sectionTypeForSection:indexPath.section];
    NSString *cellIdentifier = [self cellIdentifierForSectionType:sectionType];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor blackColor];
    switch (sectionType) {
        case CreateSectionTypeRollName:{
            SREditableCell *editableCell = (SREditableCell *)cell;
            editableCell.textField.text = self.createRollCoordinator.cameraRollDraft.name;
            editableCell.textField.placeholder = [SRCameraRoll defaultRollName];
            editableCell.textField.textColor = [UIColor whiteColor];
            editableCell.textField.backgroundColor = [UIColor colorWithWhite:1 alpha:.3];
            editableCell.textField.layer.cornerRadius = 5;
            break;
        }
        case CreateSectionTypeRollSize:{
            SRSegmentedCell *segmentedCell = (SRSegmentedCell *)cell;
            segmentedCell.segmentedControl.tag = rollSizeSegControlTag;
            [segmentedCell.segmentedControl removeTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
            [segmentedCell.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
            [segmentedCell.segmentedControl removeAllSegments];
            [segmentedCell.segmentedControl insertSegmentWithTitle:@"24" atIndex:0 animated:NO];
            [segmentedCell.segmentedControl insertSegmentWithTitle:@"10" atIndex:0 animated:NO];
            if ([self.createRollCoordinator.cameraRollDraft.maxPhotos integerValue] == 10) {
                segmentedCell.segmentedControl.selectedSegmentIndex = 0;
            } else if ([self.createRollCoordinator.cameraRollDraft.maxPhotos integerValue] == 24) {
                segmentedCell.segmentedControl.selectedSegmentIndex = 1;
            } else {
                segmentedCell.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
            break;
        }
        case CreateSectionTypeRollType:{
            SRSegmentedCell *segmentedCell = (SRSegmentedCell *)cell;
            segmentedCell.segmentedControl.tag = rollTypeSegControlTag;
            [segmentedCell.segmentedControl removeTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
            [segmentedCell.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
            [segmentedCell.segmentedControl removeAllSegments];
            [segmentedCell.segmentedControl insertSegmentWithTitle:@"b&w" atIndex:0 animated:NO];
            [segmentedCell.segmentedControl insertSegmentWithTitle:@"color" atIndex:0 animated:NO];
            if ([self.createRollCoordinator.cameraRollDraft.printType isEqualToString:CameraRollAPIPrintTypeColor]) {
                segmentedCell.segmentedControl.selectedSegmentIndex = 0;
            } else if ([self.createRollCoordinator.cameraRollDraft.printType isEqualToString:CameraRollAPIPrintTypeBlackAndWhite]) {
                segmentedCell.segmentedControl.selectedSegmentIndex = 1;
            } else {
                segmentedCell.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
            break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateSectionType sectionType = [self sectionTypeForSection:indexPath.section];
    switch (sectionType) {
        case CreateSectionTypeRollName: return 30;
        case CreateSectionTypeRollSize: return 50;
        case CreateSectionTypeRollType: return 50;
    }
}

#pragma mark - UITableView headers
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CreateSectionType sectionType = [self sectionTypeForSection:section];
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = [self sectionTitleForSectionType:sectionType];
    return label;
}

#pragma mark - table view helpers
- (CreateSectionType)sectionTypeForSection:(NSInteger)section
{
    return section;
}

- (NSString *)sectionTitleForSectionType:(CreateSectionType)sectionType
{
    switch (sectionType) {
        case CreateSectionTypeRollName: return @"Enter roll name";
        case CreateSectionTypeRollSize: return @"Select roll size";
        case CreateSectionTypeRollType: return @"Select roll type";
    }
}

- (NSString *)cellIdentifierForSectionType:(CreateSectionType)sectionType
{
    switch (sectionType) {
        case CreateSectionTypeRollName:
            return EditableCellIdentifier;
        case CreateSectionTypeRollSize:
        case CreateSectionTypeRollType:
            return SelectionCellIdentifier;
    }
}

#pragma mark - segmented control
- (void)segmentedControlChanged:(id)sender
{
    UISegmentedControl *segControl = sender;
    if (segControl.tag == rollTypeSegControlTag) {
        switch (segControl.selectedSegmentIndex) {
            case 0:
                self.createRollCoordinator.cameraRollDraft.printType = CameraRollAPIPrintTypeColor;
                break;
            case 1:
                self.createRollCoordinator.cameraRollDraft.printType = CameraRollAPIPrintTypeBlackAndWhite;
                break;
            default:
                break;
        }
    } else if (segControl.tag == rollSizeSegControlTag) {
        switch (segControl.selectedSegmentIndex) {
            case 0:
                self.createRollCoordinator.cameraRollDraft.maxPhotos = @10;
                break;
            case 1:
                self.createRollCoordinator.cameraRollDraft.maxPhotos = @24;
                break;
            default:
                break;
        }
    }
}

#pragma mark - create coordinator
- (SRCreateRollCoordinator *)createRollCoordinator
{
    if (!_createRollCoordinator) {
        _createRollCoordinator = [SRCreateRollCoordinator new];
    }
    return _createRollCoordinator;
}

#pragma mark - validation
- (void)createCameraRoll
{
    NSError *error;
    [self.createRollCoordinator createCameraRoll:&error];
    
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Camera Roll" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
