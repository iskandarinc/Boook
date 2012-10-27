#import "_BKChapter.h"

@interface BKChapter : _BKChapter {}
+ (BKChapter* )parseChapterWithFilename:(NSString *)chapterFileName forBook:(BKBook *)book;
- (NSString *)title;
@end
