// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BKAuthor.h instead.

#import <CoreData/CoreData.h>


extern const struct BKAuthorAttributes {
	__unsafe_unretained NSString *name;
} BKAuthorAttributes;

extern const struct BKAuthorRelationships {
	__unsafe_unretained NSString *book;
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




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) BKBook* book;

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
