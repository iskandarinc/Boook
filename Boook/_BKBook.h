// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKBook.h instead.

#import <CoreData/CoreData.h>


extern const struct BKBookAttributes {
	__unsafe_unretained NSString *epubId;
	__unsafe_unretained NSString *title;
} BKBookAttributes;

extern const struct BKBookRelationships {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *chapters;
} BKBookRelationships;

extern const struct BKBookFetchedProperties {
} BKBookFetchedProperties;

@class BKAuthor;
@class BKChapter;




@interface BKBookID : NSManagedObjectID {}
@end

@interface _BKBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BKBookID*)objectID;




@property (nonatomic, strong) NSString *epubId;


//- (BOOL)validateEpubId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* authors;

- (NSMutableSet*)authorsSet;




@property (nonatomic, strong) NSOrderedSet* chapters;

- (NSMutableOrderedSet*)chaptersSet;





@end

@interface _BKBook (CoreDataGeneratedAccessors)

- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(BKAuthor*)value_;
- (void)removeAuthorsObject:(BKAuthor*)value_;

- (void)addChapters:(NSOrderedSet*)value_;
- (void)removeChapters:(NSOrderedSet*)value_;
- (void)addChaptersObject:(BKChapter*)value_;
- (void)removeChaptersObject:(BKChapter*)value_;

@end

@interface _BKBook (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveEpubId;
- (void)setPrimitiveEpubId:(NSString *)value;




- (NSString *)primitiveTitle;
- (void)setPrimitiveTitle:(NSString *)value;





- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;



- (NSMutableOrderedSet*)primitiveChapters;
- (void)setPrimitiveChapters:(NSMutableOrderedSet*)value;


@end
