//
//  BKPageCell.m
//  Boook
//
//  Created by Edwin Iskandar on 10/19/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKPageCell.h"

@implementation BKPageCell

-(void)prepareForReuse {
	[super prepareForReuse];
	[[self.textView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		UIView *view = (UIView *)obj;
		[view removeFromSuperview];
	}];
}
@end
