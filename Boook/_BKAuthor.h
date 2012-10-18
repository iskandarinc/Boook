// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKAuthor.h instead.

#import <CoreData/CoreData.h>


extern const struct BKAuthorAttributes {
	 NSString *name;
} BKAuthorAttributes;

extern const struct BKAuthorRelationships {
	 NSString *book;
} BKAuthorRelationships;

extern const struct BKAuthorFetchedProperties {
} BKAuthorFetchedProperties;

@class BKBook;



@interface BKAuthorID : NSManagedObjectID {}
@end

@interface _BKAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BKAuthorID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BKBook* book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;





@end

@interface _BKAuthor (CoreDataGeneratedAccessors)

@end

@interface _BKAuthor (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;





- (BKBook*)primitiveBook;
- (void)setPrimitiveBook:(BKBook*)value;


@end
