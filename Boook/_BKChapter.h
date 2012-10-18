// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKChapter.h instead.

#import <CoreData/CoreData.h>


extern const struct BKChapterAttributes {
	 NSString *name;
} BKChapterAttributes;

extern const struct BKChapterRelationships {
	 NSString *book;
	 NSString *chunks;
} BKChapterRelationships;

extern const struct BKChapterFetchedProperties {
} BKChapterFetchedProperties;

@class BKBook;
@class NSManagedObject;



@interface BKChapterID : NSManagedObjectID {}
@end

@interface _BKChapter : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BKChapterID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BKBook* book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* chunks;

- (NSMutableSet*)chunksSet;





@end

@interface _BKChapter (CoreDataGeneratedAccessors)

- (void)addChunks:(NSSet*)value_;
- (void)removeChunks:(NSSet*)value_;
- (void)addChunksObject:(NSManagedObject*)value_;
- (void)removeChunksObject:(NSManagedObject*)value_;

@end

@interface _BKChapter (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;





- (BKBook*)primitiveBook;
- (void)setPrimitiveBook:(BKBook*)value;



- (NSMutableSet*)primitiveChunks;
- (void)setPrimitiveChunks:(NSMutableSet*)value;


@end
