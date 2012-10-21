//
//  BKPageCell.m
//  Boook
//
//  Created by Edwin Iskandar on 10/19/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKPageCell.h"

@implementation BKPageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
