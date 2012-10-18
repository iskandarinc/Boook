// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKAuthor.m instead.

#import "_BKAuthor.h"

const struct BKAuthorAttributes BKAuthorAttributes = {
	.name = @"name",
};

const struct BKAuthorRelationships BKAuthorRelationships = {
	.book = @"book",
};

const struct BKAuthorFetchedProperties BKAuthorFetchedProperties = {
};

@implementation BKAuthorID
@end

@implementation _BKAuthor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Author";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Author" inManagedObjectContext:moc_];
}

- (BKAuthorID*)objectID {
	return (BKAuthorID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic book;

	






@end
