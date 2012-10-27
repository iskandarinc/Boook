//
//  BKLabel.m
//  Boook
//
//  Created by Edwin Iskandar on 10/25/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKLabel.h"

@implementation BKLabel
- (void)highLight {
	self.backgroundColor = [UIColor yellowColor];
}

- (void)unhighLight {
	self.backgroundColor = [UIColor clearColor];
}

- (BOOL)isHighLighted {
	return (self.backgroundColor == [UIColor yellowColor]);
}
@end
