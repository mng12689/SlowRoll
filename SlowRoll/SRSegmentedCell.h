//
//  SRSegmentedCell.h
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRSegmentedControl;

@interface SRSegmentedCell : UITableViewCell

@property (nonatomic, strong, readonly) SRSegmentedControl *segmentedControl;

@end
