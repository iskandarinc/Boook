// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKBook.h instead.

#import <CoreData/CoreData.h>


extern const struct BKBookAttributes {
	 NSString *title;
} BKBookAttributes;

extern const struct BKBookRelationships {
	 NSString *authors;
	 NSString *chapters;
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




@property (nonatomic, retain) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* authors;

- (NSMutableSet*)authorsSet;




@property (nonatomic, retain) BKChapter* chapters;

//- (BOOL)validateChapters:(id*)value_ error:(NSError**)error_;





@end

@interface _BKBook (CoreDataGeneratedAccessors)

- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(BKAuthor*)value_;
- (void)removeAuthorsObject:(BKAuthor*)value_;

@end

@interface _BKBook (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveTitle;
- (void)setPrimitiveTitle:(NSString *)value;





- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;



- (BKChapter*)primitiveChapters;
- (void)setPrimitiveChapters:(BKChapter*)value;


@end
