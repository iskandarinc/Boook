// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKChunk.m instead.

#import "_BKChunk.h"

const struct BKChunkAttributes BKChunkAttributes = {
	.image = @"image",
	.text = @"text",
	.type = @"type",
};

const struct BKChunkRelationships BKChunkRelationships = {
	.chapter = @"chapter",
};

const struct BKChunkFetchedProperties BKChunkFetchedProperties = {
};

@implementation BKChunkID
@end

@implementation _BKChunk

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Chunk" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Chunk";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Chunk" inManagedObjectContext:moc_];
}

- (BKChunkID*)objectID {
	return (BKChunkID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic image;






@dynamic text;






@dynamic type;



- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(int16_t)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}





@dynamic chapter;

	






@end
