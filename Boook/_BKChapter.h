// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKChapter.h instead.

#import <CoreData/CoreData.h>


extern const struct BKChapterAttributes {
	__unsafe_unretained NSString *name;
} BKChapterAttributes;

extern const struct BKChapterRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *chunks;
} BKChapterRelationships;

extern const struct BKChapterFetchedProperties {
} BKChapterFetchedProperties;

@class BKBook;
@class BKChunk;



@interface BKChapterID : NSManagedObjectID {}
@end

@interface _BKChapter : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BKChapterID*)objectID;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) BKBook* book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* chunks;

- (NSMutableSet*)chunksSet;





@end

@interface _BKChapter (CoreDataGeneratedAccessors)

- (void)addChunks:(NSSet*)value_;
- (void)removeChunks:(NSSet*)value_;
- (void)addChunksObject:(BKChunk*)value_;
- (void)removeChunksObject:(BKChunk*)value_;

@end

@interface _BKChapter (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;





- (BKBook*)primitiveBook;
- (void)setPrimitiveBook:(BKBook*)value;



- (NSMutableSet*)primitiveChunks;
- (void)setPrimitiveChunks:(NSMutableSet*)value;


@end
