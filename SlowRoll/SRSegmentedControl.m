//
//  SRSegmentedControl.m
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRSegmentedControl.h"
#import "UIColor+SRColors.h"
#import "UIImage+SRColor.h"

@implementation SRSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor SRGreen]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setTintColor:[UIColor whiteColor]];
        [self setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //NSDictionary *textDictionary = @{NSFontAttributeName : }
        //[self setTitleTextAttributes:textDictionary forState:UIControlStateNormal];
    }
    return self;
}

@end
