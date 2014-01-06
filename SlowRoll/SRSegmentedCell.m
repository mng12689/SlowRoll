//
//  SRSegmentedCell.m
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRSegmentedCell.h"
#import "SRSegmentedControl.h"

@interface SRSegmentedCell ()

@property (nonatomic, strong, readwrite) SRSegmentedControl *segmentedControl;

@end

@implementation SRSegmentedCell

- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[SRSegmentedControl alloc] initWithFrame:self.contentView.bounds];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

@end
