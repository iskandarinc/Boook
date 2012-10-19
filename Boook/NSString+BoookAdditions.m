//
//  NSString+BoookAdditions.m
//  Boook
//
//  Created by Edwin Iskandar on 10/19/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "NSString+BoookAdditions.h"

@implementation NSString (BoookAdditions)

- (NSString *)sanitizeString {
	NSString *sanitizedString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
	sanitizedString = [sanitizedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
								 
	return sanitizedString;
}

@end
