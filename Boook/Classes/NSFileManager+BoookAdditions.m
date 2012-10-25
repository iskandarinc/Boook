//
//  NSFileManager+BoookAdditions.m
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "NSFileManager+BoookAdditions.h"

@implementation NSFileManager (BoookAdditions)
- (void)logContentsOfResourceDirectory:(NSString *)relativePathFromResourceDir
{
	NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
	resourcesPath = [resourcesPath stringByAppendingString:relativePathFromResourceDir];
	NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcesPath error:nil];
	[directoryContents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSLog(@"content = %@", obj);
	}];
}
@end
