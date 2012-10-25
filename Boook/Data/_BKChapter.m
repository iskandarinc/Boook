// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKChapter.m instead.

#import "_BKChapter.h"

const struct BKChapterAttributes BKChapterAttributes = {
	.name = @"name",
};

const struct BKChapterRelationships BKChapterRelationships = {
	.book = @"book",
	.chunks = @"chunks",
};

const struct BKChapterFetchedProperties BKChapterFetchedProperties = {
};

@implementation BKChapterID
@end

@implementation _BKChapter

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Chapter" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Chapter";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Chapter" inManagedObjectContext:moc_];
}

- (BKChapterID*)objectID {
	return (BKChapterID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic book;

	

@dynamic chunks;

	
- (NSMutableOrderedSet*)chunksSet {
	[self willAccessValueForKey:@"chunks"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"chunks"];
  
	[self didAccessValueForKey:@"chunks"];
	return result;
}
	






@end
