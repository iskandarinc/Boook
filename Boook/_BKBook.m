// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKBook.m instead.

#import "_BKBook.h"

const struct BKBookAttributes BKBookAttributes = {
	.title = @"title",
};

const struct BKBookRelationships BKBookRelationships = {
	.authors = @"authors",
	.chapters = @"chapters",
};

const struct BKBookFetchedProperties BKBookFetchedProperties = {
};

@implementation BKBookID
@end

@implementation _BKBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (BKBookID*)objectID {
	return (BKBookID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic title;






@dynamic authors;

	
- (NSMutableSet*)authorsSet {
	[self willAccessValueForKey:@"authors"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"authors"];
  
	[self didAccessValueForKey:@"authors"];
	return result;
}
	

@dynamic chapters;

	






@end
