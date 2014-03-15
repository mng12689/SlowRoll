//
//  SRDeliveryOptionsViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 1/18/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRDeliveryOptionsViewController.h"
#import "SRDeliveryOptionCell.h"
#import "UIColor+SRColors.h"
#import "UIFont+SRFonts.h"

static NSString *OptionCellIdentifier = @"OptionCellID";

typedef NS_ENUM(NSInteger, SectionType) {
    SectionTypeMailOption,
    SectionTypeDigitalOption
};

@interface SRDeliveryOptionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SRDeliveryOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 140;
    [self.tableView registerClass:[SRDeliveryOptionCell class] forCellReuseIdentifier:OptionCellIdentifier];
    [self.view addSubview:self.tableView];
    
    UILabel *tableHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    tableHeader.textColor = [UIColor whiteColor];
    tableHeader.textAlignment = NSTextAlignmentCenter;
    tableHeader.text = NSLocalizedString(@"select delivery method", @"delivery option vc instruction on table view header");
    self.tableView.tableHeaderView = tableHeader;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake([[self topLayoutGuide] length], 0, 0, 0);
}

#pragma mark - UITableView data source/delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionType sectionType = [SRDeliveryOptionsViewController sectionTypeForSection:indexPath.section];
    
    SRDeliveryOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OptionCellIdentifier];
    switch (sectionType) {
        case SectionTypeMailOption:
            cell.descriptionLabel.text = @"high-quality prints delivered in 7 days";
            cell.priceLabel.text = @"$9.99";
            break;
        case SectionTypeDigitalOption:
            cell.descriptionLabel.text = @"access digital photos online in 7 days";
            cell.priceLabel.text = @"FREE";
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionType sectionType = [SRDeliveryOptionsViewController sectionTypeForSection:section];
    
    UILabel *header = [UILabel new];
    header.textColor = [UIColor whiteColor];
    header.backgroundColor = [UIColor SRGreen];
    header.font = [UIFont futuraFontWithSize:26];
    header.textAlignment = NSTextAlignmentCenter;
    header.text = sectionType == SectionTypeMailOption ? @"mail" : @"digital";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark - table view helpers
+ (SectionType)sectionTypeForSection:(NSInteger)section
{
    switch (section) {
        case 0: return SectionTypeMailOption;
        case 1: return SectionTypeDigitalOption;
        default: return -1;
    }
}

@end
