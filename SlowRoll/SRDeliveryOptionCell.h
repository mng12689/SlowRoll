//
//  SRDeliveryOptionCell.h
//  SlowRoll
//
//  Created by Michael Ng on 1/18/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRDeliveryOptionCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *descriptionLabel;
@property (nonatomic, strong, readonly) UILabel *priceLabel;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;

@end
