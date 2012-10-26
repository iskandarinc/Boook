//
//  NSAttributedString+BoookAdditions.m
//  Boook
//
//  Created by Edwin Iskandar on 10/20/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "NSAttributedString+BoookAdditions.h"

@implementation NSAttributedString (BoookAdditions)
- (NSArray *)componentsSeperatedBySubString:(NSString *)subString {
	NSMutableArray *components = [NSMutableArray array];
	
	NSArray *wordStrings = [self.string componentsSeparatedByString:subString];
	[wordStrings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSString *wordString = (NSString *)obj;
		
		if ([self.string rangeOfString:wordString].location != NSNotFound) {
			NSMutableAttributedString *attributedWordString = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedSubstringFromRange:[self.string rangeOfString:wordString]]];
			[attributedWordString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]]; // add a space
			
			[components addObject:attributedWordString];
		}
	}];
	return components;
}

+ (NSDictionary *)attributesForParagraph {
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:14];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			nil];
}

+ (NSDictionary *)attributesForHeading{
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

+ (NSDictionary *)attributesForSubHeading{
	UIFont *font=[UIFont fontWithName:@"Baskerville-Italic" size:20];
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
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:14];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			font, NSFontAttributeName,
			[UIColor redColor], NSForegroundColorAttributeName,
			nil];
}

- (UIFont *) font {
	NSRange *effectiveRange = nil;
	return [self attribute:NSFontAttributeName atIndex:0 effectiveRange:effectiveRange];
}

@end
