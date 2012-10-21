//
//  NSAttributedString+BoookAdditions.h
//  Boook
//
//  Created by Edwin Iskandar on 10/20/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (BoookAdditions)
+ (NSDictionary *)attributesForParagraph;
+ (NSDictionary *)attributesForTitle;
+ (NSDictionary *)attributesForFirstParagraphTitle;
+ (NSDictionary *)attributesForFootNote;
- (UIFont *) font;
@end
