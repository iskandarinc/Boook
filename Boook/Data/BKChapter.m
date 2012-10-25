#import "BKChapter.h"
#import "GDataXMLNode.h"
#import "BKChunk.h"

@implementation BKChapter

+ (BKChapter* )parseChapterWithFilename:(NSString *)chapterFileName {
	BKChapter *chapter = [BKChapter insertInManagedObjectContext:[NSManagedObjectContext defaultContext]];
	
	NSData *xmlData = [NSData dataWithContentsOfFile:chapterFileName];
	GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithHTMLData:xmlData encoding:NSUTF8StringEncoding error:nil];
	
	// get the title of the chapter assuming its the first h1
	GDataXMLElement *titleElement = (GDataXMLElement *)[[xmlDoc nodesForXPath:@"//title" error:nil] objectAtIndex:0];
	[chapter setName:titleElement.stringValue];
	
	// get the chunks of text
	NSArray *nodes = [xmlDoc nodesForXPath:@"//h1 | //h2 | //h3 | //h4 | //p | //img" error:nil];
	
	NSMutableOrderedSet *chunks = [NSMutableOrderedSet orderedSetWithCapacity:2];
	[nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		GDataXMLElement *xmlElement = (GDataXMLElement *)obj;
		
		ChunkType chunkType;
		NSString *textValue = xmlElement.stringValue;
		if ([xmlElement.name isEqualToString:@"h1"]) {
			chunkType = ChunkTypeTitle;
		} else if ([xmlElement.name isEqualToString:@"h2"]) {
			chunkType = ChunkTypeSubTitle;
		} else if ([xmlElement.name isEqualToString:@"h3"]) {
			chunkType = ChunkTypeHeading;
		} else if ([xmlElement.name isEqualToString:@"h4"]) {
				chunkType = ChunkTypeSubHeading;
		} else if ([xmlElement.name isEqualToString:@"p"]) {
			chunkType = ChunkTypeParagraph;
		} else if ([xmlElement.name isEqualToString:@"img"]) {
			chunkType = ChunkTypeImage;
		}
		
		BKChunk *chunk = [BKChunk chunkWithType:chunkType andValue:textValue];
		
		if ([xmlElement.name isEqualToString:@"img"]) {
			chunk.image = [xmlElement attributeForName:@"src"].stringValue;
		}
		[chunks addObject:chunk];
	}];
	
	if ([chunks count]) {
		[chapter setChunks:chunks];
	}
	return chapter;
}


@end
