//
//  SRSegmentedCell.m
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRSegmentedCell.h"
#import "SRSegmentedControl.h"
#import "UIFont+SRFonts.h"

@interface SRSegmentedCell ()

@property (nonatomic, strong, readwrite) SRSegmentedControl *segmentedControl;

@end

@implementation SRSegmentedCell

- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[SRSegmentedControl alloc] initWithFrame:self.contentView.bounds];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        NSDictionary *titleTextAttributes = @{NSFontAttributeName : [UIFont futuraFontWithSize:18]};
        [_segmentedControl setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        [self.contentView addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

@end
