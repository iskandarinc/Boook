//
//  NSFileManager+BoookAdditions.h
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BoookAdditions)
- (void)logContentsOfResourceDirectory:(NSString *)relativePathFromResourceDir;
@end
