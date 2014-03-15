//
//  SRDeliveryOptionCell.m
//  SlowRoll
//
//  Created by Michael Ng on 1/18/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SRDeliveryOptionCell.h"
#import "UIFont+SRFonts.h"

@interface SRDeliveryOptionCell ()

@property (nonatomic, strong, readwrite) UILabel *descriptionLabel;
@property (nonatomic, strong, readwrite) UILabel *priceLabel;
@property (nonatomic, strong, readwrite) UIImageView *iconImageView;

@end

@implementation SRDeliveryOptionCell

#pragma mark - layout
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static NSInteger margin = 25;
    
    CGSize descLabelSize = [self.descriptionLabel sizeThatFits:CGSizeMake(self.contentView.frame.size.width/2-margin, NSIntegerMax)];
    self.descriptionLabel.frame = CGRectMake(margin, margin, descLabelSize.width, descLabelSize.height);
    
    static NSInteger iconSideLength = 70;
    self.iconImageView.frame = CGRectMake(self.contentView.frame.size.width-iconSideLength-margin, margin, iconSideLength, iconSideLength);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.center = self.iconImageView.center;
    self.priceLabel.frame = CGRectMake(self.priceLabel.frame.origin.x, self.iconImageView.frame.origin.y+self.iconImageView.frame.size.height+10, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);
}

#pragma mark - lazy loaders
- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont futuraFontWithSize:18];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont futuraFontWithSize:20];
        _priceLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

@end
