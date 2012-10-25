#import "_BKBook.h"

@interface BKBook : _BKBook {}
+ (BKBook *)parseEpub:(NSString *)fileName;
+ (NSString *)unzipPathForFileName:(NSString *)fileName;
- (NSString *)unzipPath;
- (NSString *)pathToBookImage;
@end
