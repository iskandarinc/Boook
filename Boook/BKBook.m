#import "BKBook.h"
#import "SSZipArchive.h"
#import "NSFileManager+BoookAdditions.h"
#import "NSString+BoookAdditions.h"
#import "XMLReader.h"
#import "BKChapter.h"

@implementation BKBook

NSString *const kUnzipRootPath = @"/Documents/";
NSString *const kEpubContentRoot = @"/OPS/";
NSString *const kEpubContentManifest = @"/OPS/content.opf";


+ (NSString *)unzipPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *rootPath = [paths objectAtIndex:0];
	NSString *baseFileName = [fileName stringByReplacingOccurrencesOfString:@".epub" withString:@""];
	NSString *unzipPath = [NSString stringWithFormat:@"%@%@%@", rootPath, kUnzipRootPath, baseFileName];
	return unzipPath;
}

- (NSString *)pathToBookImage {
	// try to use standard bookcover filename
	NSString *path = [[self unzipPath] stringByAppendingString:@"/OPS/images/bookcover.jpg"];
	
	if ([UIImage imageWithContentsOfFile:path]) {
		return path;
	} else {
		// get first image in images dir
		NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[self unzipPath] stringByAppendingString:@"/OPS/images"] error:nil];
		path = [[[self unzipPath] stringByAppendingString:@"/OPS/images/"] stringByAppendingString:[directoryContents objectAtIndex:0]];
		return path;
	}
}

- (NSString *)unzipPath {
	return [[self class] unzipPathForFileName:self.baseName];
}

+ (void)unzipEpub:(NSString *)fileName {
	NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
	[SSZipArchive unzipFileAtPath:[NSString stringWithFormat:@"%@/%@", resourcesPath, fileName] toDestination:[[self class] unzipPathForFileName:fileName]];
}

+ (BKBook *)parseEpub:(NSString *)fileName {

	[[self class] unzipEpub:fileName];
	
	NSString *contentManifestPath = [[self unzipPathForFileName:fileName] stringByAppendingString:kEpubContentManifest];
	NSData *xmlData = [NSData dataWithContentsOfFile:contentManifestPath];
	NSDictionary *fileContents = [XMLReader dictionaryForXMLData:xmlData error:nil];
	
	// epub id and title
	NSString *epubId = [[[[fileContents objectForKey:@"package"] objectForKey:@"metadata"] objectForKey:@"dc:identifier"] objectForKey:@"text"];
	NSString *title = [[[[fileContents objectForKey:@"package"] objectForKey:@"metadata"] objectForKey:@"dc:title"] objectForKey:@"text"];
	
	// save the main book metadata
	BKBook *book = [BKBook findFirstByAttribute:@"epubId" withValue:epubId];
	
	if (book) {
		[book deleteInContext:[NSManagedObjectContext defaultContext]];
	}
		
	book = [BKBook createInContext:[NSManagedObjectContext defaultContext]];
	book.baseName = fileName;
	book.epubId = epubId;
	book.title = title;
	
	// lets go get the chapters
	__block NSMutableOrderedSet *chapters = [NSMutableOrderedSet orderedSetWithCapacity:2];
	
	NSArray *chaptersFileNames = [[[fileContents objectForKey:@"package"] objectForKey:@"manifest"] objectForKey:@"item"];
	[chaptersFileNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	

		NSDictionary *item = (NSDictionary *)obj;
		NSString *chapterFileName = [item objectForKey:@"href"];
		
		// read each file
		NSString *chapterFileNamePath = [[[self unzipPathForFileName:fileName] stringByAppendingString:kEpubContentRoot] stringByAppendingString:chapterFileName];
		
		if ([chapterFileName rangeOfString:@"chapter"].location != NSNotFound && [chapterFileName rangeOfString:@"html"].location != NSNotFound) {
			BKChapter *chapter = [BKChapter parseChapterWithFilename:chapterFileNamePath];
			[chapters addObject:chapter];
		}
	}];
	
	[book setChapters:chapters];
	[[NSManagedObjectContext defaultContext] save];
	return book;
}

@end
