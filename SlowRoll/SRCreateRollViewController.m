//
//  SRCreateRollViewController.m
//  SlowRoll
//
//  Created by Michael Ng on 12/26/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import "SRCreateRollViewController.h"

@interface SRCreateRollViewController ()

@end

@implementation SRCreateRollViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
