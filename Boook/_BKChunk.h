// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKChunk.h instead.

#import <CoreData/CoreData.h>


extern const struct BKChunkAttributes {
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *type;
} BKChunkAttributes;

extern const struct BKChunkRelationships {
	__unsafe_unretained NSString *chapter;
} BKChunkRelationships;

extern const struct BKChunkFetchedProperties {
} BKChunkFetchedProperties;

@class BKChapter;





@interface BKChunkID : NSManagedObjectID {}
@end

@interface _BKChunk : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BKChunkID*)objectID;




@property (nonatomic, strong) NSString *image;


//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *text;


//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *type;


@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) BKChapter* chapter;

//- (BOOL)validateChapter:(id*)value_ error:(NSError**)error_;





@end

@interface _BKChunk (CoreDataGeneratedAccessors)

@end

@interface _BKChunk (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveImage;
- (void)setPrimitiveImage:(NSString *)value;




- (NSString *)primitiveText;
- (void)setPrimitiveText:(NSString *)value;




- (NSNumber *)primitiveType;
- (void)setPrimitiveType:(NSNumber *)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;





- (BKChapter*)primitiveChapter;
- (void)setPrimitiveChapter:(BKChapter*)value;


@end
