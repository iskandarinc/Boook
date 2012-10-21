//
//  NSAttributedString+BoookAdditions.m
//  Boook
//
//  Created by Edwin Iskandar on 10/20/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "NSAttributedString+BoookAdditions.h"

@implementation NSAttributedString (BoookAdditions)
+ (NSDictionary *)attributesForParagraph {
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:14];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			nil];
}

+ (NSDictionary *)attributesForTitle {
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:25];
	NSShadow *shadowDic=[[NSShadow alloc] init];
	[shadowDic setShadowBlurRadius:3.0];
	[shadowDic setShadowColor:[UIColor darkGrayColor]];
	[shadowDic setShadowOffset:CGSizeMake(0, 1)];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			[UIColor blackColor], NSForegroundColorAttributeName,
			
			
			nil];
}

+ (NSDictionary *)attributesForFootNote {
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:14];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			[UIColor redColor], NSForegroundColorAttributeName,
			
			
			nil];
}

+ (NSDictionary *)attributesForFirstParagraphTitle {
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:35];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			[UIColor blackColor], NSForegroundColorAttributeName,
			
			
			nil];
}

- (UIFont *) font {
	NSRange *effectiveRange = nil;
	return [self attribute:NSFontAttributeName atIndex:0 effectiveRange:effectiveRange];
}

@end
