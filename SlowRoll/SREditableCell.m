//
//  SREditableCell.m
//  SlowRoll
//
//  Created by Michael Ng on 1/5/14.
//  Copyright (c) 2014 SlowRoll. All rights reserved.
//

#import "SREditableCell.h"

@interface SREditableCell ()

@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation SREditableCell

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.indentationWidth,
                                                                   0,
                                                                   self.contentView.bounds.size.width-2*self.indentationWidth,
                                                                   self.contentView.bounds.size.height)];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textField.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

@end
