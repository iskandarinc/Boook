#import "BKChunk.h"

@implementation BKChunk

+ (BKChunk *)chunkWithType:(ChunkType)chunkType andValue:(NSString*)value {
	BKChunk *chunk = [BKChunk insertInManagedObjectContext:[NSManagedObjectContext defaultContext]];
	chunk.text = value;
	chunk.type = [NSNumber numberWithInt:chunkType];
	return chunk;
}

@end
