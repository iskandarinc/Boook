//
//  UILabel+BoookAdditions.m
//  Boook
//
//  Created by Edwin Iskandar on 10/21/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "UILabel+BoookAdditions.h"

@implementation UILabel (BoookAdditions)
- (BOOL) canBecomeFirstResponder
{
	// allows copy to clipboard
    return YES;
}
@end
